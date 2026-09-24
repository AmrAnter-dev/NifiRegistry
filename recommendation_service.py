```python
from __future__ import annotations

from enum import StrEnum
from typing import Any

from pydantic import BaseModel, Field


# ============================================================
# Exceptions
# ============================================================


class RecommendationError(Exception):
    """Base exception for recommendation failures."""


class RecommendationFailure(RecommendationError):
    """Raised when recommendation processing fails."""


# ============================================================
# DTOs
# ============================================================


class RecommendationType(StrEnum):
    EQUIVALENT = "equivalent"
    ALTERNATIVE = "alternative"


class RecommendationStatus(StrEnum):
    SUCCESS = "success"
    NO_RECOMMENDATION = "no_recommendation"


class RecommendationRequest(BaseModel):
    """
    Input required to find an equivalent or alternative product.

    The request represents the product information extracted
    from the web or supplied by another internal service.
    """

    active_ingredients: list[str] = Field(
        min_length=1,
        description="Active ingredients of the requested product.",
    )

    strength: str | None = Field(
        default=None,
        description=(
            "Overall strength representation of the product. "
            "Example: '20/10 mg'."
        ),
    )

    route: str = Field(
        min_length=1,
        description="Explicit route of administration.",
    )

    limit: int = Field(
        default=5,
        ge=1,
        le=10,
        description="Maximum number of recommendations.",
    )


class ProductRecommendation(BaseModel):
    """
    A locally available recommended product.
    """

    item_code: int

    name: str

    active_ingredients: list[str] = Field(
        default_factory=list,
    )

    available_quantity: float

    similarity_score: float | None = None


class RecommendationResult(BaseModel):
    """
    Result returned by RecommendationService.

    recommendation_type:
        equivalent -> same active ingredients + strength + route
        alternative -> semantic alternative, not necessarily same signature
    """

    status: RecommendationStatus

    recommendation_type: RecommendationType | None = None

    recommendations: list[ProductRecommendation] = Field(
        default_factory=list,
    )


# ============================================================
# Recommendation Service
# ============================================================


class RecommendationService:
    """
    Find locally available equivalent or alternative products.

    Strategy
    --------
    1. Build the canonical drug signature from:
           active_ingredients + strength + route

    2. Search local products using the exact drug signature.

    3. Check LOCAL stock only.

    4. If locally available equivalents exist:
           return EQUIVALENT

    5. If no locally available equivalent exists:
           perform semantic search.

    6. Check LOCAL stock of semantic candidates.

    7. If locally available semantic candidates exist:
           return ALTERNATIVE

    8. Otherwise:
           return NO_RECOMMENDATION
    """

    def __init__(
        self,
        product_service: ProductService,
        availability_service: AvailabilityService,
        semantic_service: SemanticService,
    ) -> None:
        self._product_service = product_service
        self._availability_service = availability_service
        self._semantic_service = semantic_service

    # ========================================================
    # Public API
    # ========================================================

    async def recommend(
        self,
        request: RecommendationRequest,
    ) -> RecommendationResult:

        try:
            # ------------------------------------------------
            # 1. Validate request
            # ------------------------------------------------

            signature = self._build_drug_signature(
                active_ingredients=request.active_ingredients,
                strength=request.strength,
                route=request.route,
            )

            # ------------------------------------------------
            # 2. Find exact equivalents
            # ------------------------------------------------

            equivalent_products = (
                await self._find_equivalents(
                    drug_signature=signature,
                )
            )

            # ------------------------------------------------
            # 3. Check LOCAL stock
            # ------------------------------------------------

            available_equivalents = (
                await self._filter_local_stock(
                    products=equivalent_products,
                    limit=request.limit,
                )
            )

            # ------------------------------------------------
            # 4. Equivalent found
            # ------------------------------------------------

            if available_equivalents:

                return RecommendationResult(
                    status=RecommendationStatus.SUCCESS,
                    recommendation_type=(
                        RecommendationType.EQUIVALENT
                    ),
                    recommendations=[
                        self._build_product_recommendation(
                            product=product,
                        )
                        for product in available_equivalents
                    ],
                )

            # ------------------------------------------------
            # 5. No locally available equivalent
            #
            # Fallback to semantic alternatives
            # ------------------------------------------------

            return await self._find_semantic_alternatives(
                request=request,
            )

        except RecommendationError:
            raise

        except Exception as exc:
            raise RecommendationFailure(
                "Recommendation engine failed."
            ) from exc

    # ========================================================
    # Exact Equivalent Search
    # ========================================================

    async def _find_equivalents(
        self,
        drug_signature: str,
    ) -> list[dict[str, Any]]:

        try:
            products = (
                await self._product_service
                .get_by_drug_signature(
                    drug_signature=drug_signature,
                )
            )

            return products or []

        except Exception as exc:
            raise RecommendationFailure(
                "Failed to search for equivalent products."
            ) from exc

    # ========================================================
    # Semantic Alternatives
    # ========================================================

    async def _find_semantic_alternatives(
        self,
        request: RecommendationRequest,
    ) -> RecommendationResult:

        query = self._build_semantic_query(
            request=request,
        )

        try:
            semantic_results = (
                await self._semantic_service.search(
                    query=query,

                    # Ask for more candidates because
                    # some candidates may have no local stock.
                    limit=request.limit * 3,
                )
            )

        except Exception as exc:
            raise RecommendationFailure(
                "Failed to search for semantic alternatives."
            ) from exc

        if not semantic_results:

            return RecommendationResult(
                status=(
                    RecommendationStatus.NO_RECOMMENDATION
                ),
                recommendation_type=None,
                recommendations=[],
            )

        # ----------------------------------------------------
        # Extract product records from semantic results
        # ----------------------------------------------------

        products: list[dict[str, Any]] = []

        for result in semantic_results:

            product = result.get(
                "product",
                result,
            )

            if not product:
                continue

            item = dict(product)

            item["_semantic_score"] = result.get(
                "score"
            )

            products.append(item)

        if not products:

            return RecommendationResult(
                status=(
                    RecommendationStatus.NO_RECOMMENDATION
                ),
                recommendation_type=None,
                recommendations=[],
            )

        # ----------------------------------------------------
        # Keep LOCAL stock only
        # ----------------------------------------------------

        available_products = (
            await self._filter_local_stock(
                products=products,
                limit=request.limit,
            )
        )

        if not available_products:

            return RecommendationResult(
                status=(
                    RecommendationStatus.NO_RECOMMENDATION
                ),
                recommendation_type=None,
                recommendations=[],
            )

        # ----------------------------------------------------
        # Return alternatives
        # ----------------------------------------------------

        return RecommendationResult(
            status=RecommendationStatus.SUCCESS,
            recommendation_type=(
                RecommendationType.ALTERNATIVE
            ),
            recommendations=[
                self._build_product_recommendation(
                    product=product,
                    semantic=True,
                )
                for product in available_products
            ],
        )

    # ========================================================
    # Local Stock Filtering
    # ========================================================

    async def _filter_local_stock(
        self,
        products: list[dict[str, Any]],
        limit: int,
    ) -> list[dict[str, Any]]:

        if not products:
            return []

        product_ids = [
            product.get("id")
            for product in products
            if product.get("id") is not None
        ]

        if not product_ids:
            return []

        try:
            availability_map = (
                await self._availability_service
                .get_local_stock(
                    product_ids=product_ids,
                )
            )

        except Exception as exc:
            raise RecommendationFailure(
                "Failed to check local product availability."
            ) from exc

        available: list[dict[str, Any]] = []

        for product in products:

            product_id = product.get("id")

            local_quantity = availability_map.get(
                product_id,
                0,
            )

            if local_quantity <= 0:
                continue

            item = dict(product)

            item["available_quantity"] = (
                local_quantity
            )

            available.append(item)

            if len(available) >= limit:
                break

        return available

    # ========================================================
    # Drug Signature
    # ========================================================

    def _build_drug_signature(
        self,
        active_ingredients: list[str],
        strength: str | None,
        route: str,
    ) -> str:

        normalized_ingredients = sorted(
            {
                ingredient.strip().lower()
                for ingredient in active_ingredients
                if ingredient
                and ingredient.strip()
            }
        )

        normalized_strength = (
            strength.strip().lower()
            if strength
            else ""
        )

        normalized_route = route.strip().lower()

        return " | ".join(
            [
                "+".join(normalized_ingredients),
                normalized_strength,
                normalized_route,
            ]
        )

    # ========================================================
    # Semantic Query
    # ========================================================

    def _build_semantic_query(
        self,
        request: RecommendationRequest,
    ) -> str:

        ingredients = ", ".join(
            ingredient.strip()
            for ingredient in request.active_ingredients
            if ingredient.strip()
        )

        strength = (
            request.strength.strip()
            if request.strength
            else ""
        )

        route = request.route.strip()

        return (
            f"Active ingredients: {ingredients}\n"
            f"Strength: {strength}\n"
            f"Route: {route}"
        )

    # ========================================================
    # Response Builder
    # ========================================================

    def _build_product_recommendation(
        self,
        product: dict[str, Any],
        semantic: bool = False,
    ) -> ProductRecommendation:

        similarity_score = None

        if semantic:
            similarity_score = product.get(
                "_semantic_score"
            )

        return ProductRecommendation(
            item_code=int(
                product.get(
                    "item_code",
                    product.get("id"),
                )
            ),
            name=product.get(
                "name",
                "",
            ),
            active_ingredients=(
                self._get_active_ingredients(
                    product
                )
            ),
            available_quantity=float(
                product.get(
                    "available_quantity",
                    0,
                )
            ),
            similarity_score=similarity_score,
        )

    # ========================================================
    # Active Ingredients Helper
    # ========================================================

    def _get_active_ingredients(
        self,
        product: dict[str, Any],
    ) -> list[str]:

        ingredients = product.get(
            "active_ingredients"
        )

        if not ingredients:

            ingredients = product.get(
                "active_ingredient"
            )

        if isinstance(
            ingredients,
            list,
        ):
            return [
                str(item).strip()
                for item in ingredients
                if str(item).strip()
            ]

        if isinstance(
            ingredients,
            str,
        ):
            return [
                item.strip()
                for item in ingredients.split(",")
                if item.strip()
            ]

        return []
```
