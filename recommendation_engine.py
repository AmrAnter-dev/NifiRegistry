```python
from typing import Any, Literal, Optional

from pydantic import BaseModel, Field


# ============================================================
# Tool Input
# ============================================================

class RecommendationEngineTool(BaseModel):
    """
    Find an available equivalent or alternative product.

    Strategy:
    1. Find the requested product by item_code.
    2. Use the product's drug_signature:
       active_ingredients | strength | route
    3. Find products with the exact same signature.
    4. Keep only products with LOCAL stock > 0.
    5. If no locally available equivalent exists,
       search semantic alternatives.
    6. Keep only alternatives with LOCAL stock > 0.
    """

    item_code: int = Field(
        ...,
        description=(
            "Item code of the medicine/product for which "
            "an equivalent or alternative is requested."
        ),
    )

    limit: int = Field(
        default=5,
        ge=1,
        le=10,
        description="Maximum number of recommendations.",
    )


# ============================================================
# Response Models
# ============================================================

class ProductResponse(BaseModel):

    id: Any

    name: str

    active_ingredients: list[str] = Field(
        default_factory=list
    )

    available_quantity: Optional[float] = None

    similarity_score: Optional[float] = None

    reason: str


class OriginalProductResponse(BaseModel):

    id: Optional[Any] = None

    name: str

    active_ingredients: list[str] = Field(
        default_factory=list
    )


class RecommendationResponse(BaseModel):

    status: Literal[
        "success",
        "not_found",
        "error",
    ]

    recommendation_type: Optional[
        Literal[
            "equivalent",
            "alternative",
        ]
    ] = None

    original_product: Optional[
        OriginalProductResponse
    ] = None

    recommendations: list[
        ProductResponse
    ] = Field(default_factory=list)

    message: str


# ============================================================
# Recommendation Service
# ============================================================

class RecommendationService:

    def __init__(
        self,
        product_service,
        inventory_service,
        semantic_service,
    ):
        self.product_service = product_service
        self.inventory_service = inventory_service
        self.semantic_service = semantic_service

    # ========================================================
    # Public API
    # ========================================================

    async def recommend(
        self,
        item_code: int,
        limit: int = 5,
    ) -> RecommendationResponse:

        try:

            # ------------------------------------------------
            # 1. Find Original Product
            # ------------------------------------------------

            product = await self.product_service.get_by_id(
                item_code=item_code
            )

            if not product:

                return RecommendationResponse(
                    status="not_found",
                    recommendation_type=None,
                    original_product=None,
                    recommendations=[],
                    message=(
                        f"Product with item_code={item_code} "
                        "was not found."
                    ),
                )

            original_product = (
                self._build_original_product(product)
            )

            # ------------------------------------------------
            # 2. Get Drug Signature
            # ------------------------------------------------

            drug_signature = product.get(
                "drug_signature"
            )

            # ------------------------------------------------
            # 3. No Signature
            # ------------------------------------------------

            if not drug_signature:

                return await self._search_alternatives(
                    product=original_product,
                    query=self._build_semantic_query(product),
                    limit=limit,
                )

            # ------------------------------------------------
            # 4. Find Exact Equivalents
            # ------------------------------------------------
            #
            # drug_signature means:
            #
            # active_ingredients | strength | route
            #
            # Therefore this is an exact equivalence search.
            # ------------------------------------------------

            equivalents = (
                await self.product_service
                .get_by_drug_signature(
                    drug_signature=drug_signature,
                    exclude_item_code=item_code,
                )
            )

            # ------------------------------------------------
            # 5. Keep ONLY locally available equivalents
            # ------------------------------------------------

            available_equivalents = (
                await self._filter_local_stock(
                    products=equivalents,
                    limit=limit,
                )
            )

            # ------------------------------------------------
            # 6. Equivalent Found
            # ------------------------------------------------

            if available_equivalents:

                return RecommendationResponse(
                    status="success",
                    recommendation_type="equivalent",
                    original_product=original_product,
                    recommendations=[
                        self._build_equivalent_response(
                            item
                        )
                        for item in available_equivalents
                    ],
                    message=(
                        "Available equivalent products "
                        "with the same drug signature were found "
                        "in the current branch."
                    ),
                )

            # ------------------------------------------------
            # 7. No LOCAL Equivalent
            # ------------------------------------------------
            #
            # Important:
            # We do NOT care here if an equivalent exists
            # somewhere else in the network.
            #
            # The customer needs a product available NOW
            # in the current branch.
            #
            # Therefore we fallback to semantic alternatives.
            # ------------------------------------------------

            return await self._search_alternatives(
                product=original_product,
                query=self._build_semantic_query(product),
                limit=limit,
            )

        except Exception:

            return RecommendationResponse(
                status="error",
                recommendation_type=None,
                original_product=None,
                recommendations=[],
                message=(
                    "Unable to complete recommendation search."
                ),
            )

    # ========================================================
    # Local Stock Filtering
    # ========================================================

    async def _filter_local_stock(
        self,
        products: list[dict],
        limit: int,
    ) -> list[dict]:

        if not products:
            return []

        product_ids = [
            product["id"]
            for product in products
            if product.get("id") is not None
        ]

        if not product_ids:
            return []

        # ----------------------------------------------------
        # Get LOCAL stock in one call
        # ----------------------------------------------------
        #
        # This MUST NOT return network quantity.
        #
        # We only want:
        #
        # product_id -> local_quantity
        #
        # Example:
        #
        # {
        #     101: 0,
        #     102: 15,
        #     103: 7,
        # }
        # ----------------------------------------------------

        local_stock_map = (
            await self.inventory_service
            .get_local_stock(
                product_ids=product_ids
            )
        )

        available = []

        for product in products:

            product_id = product.get("id")

            local_quantity = local_stock_map.get(
                product_id,
                0,
            )

            # ------------------------------------------------
            # LOCAL STOCK ONLY
            # ------------------------------------------------

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
    # Semantic Alternatives
    # ========================================================

    async def _search_alternatives(
        self,
        product: OriginalProductResponse,
        query: str,
        limit: int,
    ) -> RecommendationResponse:

        # ----------------------------------------------------
        # Search Vector DB
        # ----------------------------------------------------

        semantic_results = (
            await self.semantic_service.search(
                query=query,

                # Ask for more candidates because
                # some may have no LOCAL stock.
                limit=limit * 3,
            )
        )

        if not semantic_results:

            return RecommendationResponse(
                status="not_found",
                recommendation_type=None,
                original_product=product,
                recommendations=[],
                message=(
                    "No available equivalent or "
                    "alternative products were found."
                ),
            )

        # ----------------------------------------------------
        # Extract Products
        # ----------------------------------------------------

        products = []

        for result in semantic_results:

            item = result.get(
                "product",
                result,
            )

            item = dict(item)

            item["_semantic_score"] = result.get(
                "score"
            )

            products.append(item)

        # ----------------------------------------------------
        # LOCAL STOCK ONLY
        # ----------------------------------------------------

        available_products = (
            await self._filter_local_stock(
                products=products,
                limit=limit,
            )
        )

        # ----------------------------------------------------
        # No Locally Available Alternatives
        # ----------------------------------------------------

        if not available_products:

            return RecommendationResponse(
                status="not_found",
                recommendation_type=None,
                original_product=product,
                recommendations=[],
                message=(
                    "No equivalent or alternative "
                    "products are currently available "
                    "in the current branch."
                ),
            )

        # ----------------------------------------------------
        # Return Alternatives
        # ----------------------------------------------------

        return RecommendationResponse(
            status="success",
            recommendation_type="alternative",
            original_product=product,
            recommendations=[
                self._build_alternative_response(
                    item
                )
                for item in available_products
            ],
            message=(
                "No locally available equivalent with "
                "the same drug signature was found. "
                "Available alternatives in the current "
                "branch were returned."
            ),
        )

    # ========================================================
    # Response Builders
    # ========================================================

    def _build_original_product(
        self,
        product: dict,
    ) -> OriginalProductResponse:

        return OriginalProductResponse(
            id=product.get("id"),
            name=product.get("name", ""),
            active_ingredients=(
                self._get_active_ingredients(product)
            ),
        )

    def _build_equivalent_response(
        self,
        product: dict,
    ) -> ProductResponse:

        return ProductResponse(
            id=product.get("id"),
            name=product.get("name", ""),
            active_ingredients=(
                self._get_active_ingredients(product)
            ),
            available_quantity=(
                product.get("available_quantity")
            ),
            reason=(
                "Same drug signature "
                "(active ingredients, strength, and route) "
                "and currently available in the current branch."
            ),
        )

    def _build_alternative_response(
        self,
        product: dict,
    ) -> ProductResponse:

        return ProductResponse(
            id=product.get("id"),
            name=product.get("name", ""),
            active_ingredients=(
                self._get_active_ingredients(product)
            ),
            available_quantity=(
                product.get("available_quantity")
            ),
            similarity_score=(
                product.get("_semantic_score")
            ),
            reason=(
                "Semantically similar and currently "
                "available in the current branch. "
                "It may not have the same drug signature."
            ),
        )

    # ========================================================
    # Helpers
    # ========================================================

    def _get_active_ingredients(
        self,
        product: dict,
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

    def _build_semantic_query(
        self,
        product: dict,
    ) -> str:

        name = product.get(
            "name",
            "",
        )

        ingredients = (
            self._get_active_ingredients(
                product
            )
        )

        indications = product.get(
            "indications",
            "",
        )

        return (
            f"Medicine: {name}\n"
            f"Active ingredients: "
            f"{', '.join(ingredients)}\n"
            f"Indications: {indications}"
        )
```
