from typing import Any, Literal, Optional

from pydantic import BaseModel, Field


# ============================================================
# Tool Input
# ============================================================

class RecommendationEngineTool(BaseModel):
    """
    Find available medicine equivalents or alternatives.

    Strategy:
    1. Find the requested product.
    2. Find products with the same active ingredients.
    3. Exclude products that are out of stock.
    4. If no available equivalent exists, search semantic
       alternatives in the vector database.
    5. Exclude unavailable alternatives as well.
    """

    product_name: str = Field(
        ...,
        min_length=1,
        description=(
            "Medicine or product name for which the user "
            "wants an equivalent or alternative."
        ),
    )

    limit: int = Field(
        default=5,
        ge=1,
        le=10,
        description="Maximum number of available recommendations.",
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
        product_name: str,
        limit: int = 5,
    ) -> RecommendationResponse:

        try:

            # ------------------------------------------------
            # 1. Find Original Product
            # ------------------------------------------------

            product = await self.product_service.get_by_name(
                product_name=product_name
            )

            if not product:

                return await self._search_alternatives(
                    query=product_name,
                    product=None,
                    limit=limit,
                )


            original_product = (
                self._build_original_product(product)
            )


            # ------------------------------------------------
            # 2. Extract Active Ingredients
            # ------------------------------------------------

            active_ingredients = (
                self._get_active_ingredients(product)
            )


            # ------------------------------------------------
            # No Active Ingredient
            # ------------------------------------------------

            if not active_ingredients:

                return await self._search_alternatives(
                    query=self._build_semantic_query(product),
                    product=original_product,
                    limit=limit,
                )


            # ------------------------------------------------
            # 3. Find Products With Same Ingredients
            # ------------------------------------------------

            equivalents = (
                await self.product_service
                .get_by_active_ingredients(
                    active_ingredients=active_ingredients,
                    exclude_product_id=product.get("id"),
                )
            )


            # ------------------------------------------------
            # 4. Check Availability
            # ------------------------------------------------

            available_equivalents = (
                await self._filter_available_products(
                    products=equivalents,
                    limit=limit,
                )
            )


            # ------------------------------------------------
            # 5. Available Equivalents Found
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
                        "Available equivalent medicines "
                        "with the same active ingredients "
                        "were found."
                    ),
                )


            # ------------------------------------------------
            # 6. No Available Equivalents
            # ------------------------------------------------
            # Important:
            # Products may exist in the database but have
            # zero stock. Therefore we fallback to semantic
            # alternatives.

            return await self._search_alternatives(
                query=self._build_semantic_query(product),
                product=original_product,
                limit=limit,
            )


        except Exception as exc:

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
    # Availability Filtering
    # ========================================================

    async def _filter_available_products(
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
        # Get stock in one call
        # ----------------------------------------------------
        #
        # IMPORTANT:
        # Do NOT call inventory_service once per product.
        #
        # Bad:
        #
        #   for product:
        #       await inventory_service.get_stock(product["id"])
        #
        # This creates N database calls.
        #
        # Instead:
        #
        #   get_available_stock(product_ids)
        #

        stock_map = (
            await self.inventory_service
            .get_available_stock(
                product_ids=product_ids
            )
        )


        available = []


        for product in products:

            product_id = product.get("id")

            quantity = stock_map.get(
                product_id,
                0,
            )


            # ------------------------------------------------
            # Only products with stock
            # ------------------------------------------------

            if quantity <= 0:
                continue


            item = dict(product)

            item["available_quantity"] = quantity

            available.append(item)


            if len(available) >= limit:
                break


        return available


    # ========================================================
    # Semantic Alternatives
    # ========================================================

    async def _search_alternatives(
        self,
        query: str,
        product: Optional[
            OriginalProductResponse
        ],
        limit: int,
    ) -> RecommendationResponse:


        # ----------------------------------------------------
        # Search Vector DB
        # ----------------------------------------------------

        semantic_results = (
            await self.semantic_service.search(
                query=query,

                # Ask for more than limit because some
                # results may be unavailable.
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
                    "No equivalent or alternative "
                    "products were found."
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
        # Filter Availability
        # ----------------------------------------------------

        available_products = (
            await self._filter_available_products(
                products=products,
                limit=limit,
            )
        )


        # ----------------------------------------------------
        # No Available Alternatives
        # ----------------------------------------------------

        if not available_products:

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
                "No available equivalent with the same "
                "active ingredients was found. "
                "Available therapeutic alternatives "
                "were returned."
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

            name=product.get(
                "name",
                "",
            ),

            active_ingredients=(
                self._get_active_ingredients(product)
            ),

            available_quantity=product.get(
                "available_quantity"
            ),

            reason=(
                "Same active ingredients as the "
                "requested product and currently "
                "available in stock."
            ),
        )


    def _build_alternative_response(
        self,
        product: dict,
    ) -> ProductResponse:

        return ProductResponse(
            id=product.get("id"),

            name=product.get(
                "name",
                "",
            ),

            active_ingredients=(
                self._get_active_ingredients(product)
            ),

            available_quantity=product.get(
                "available_quantity"
            ),

            similarity_score=product.get(
                "_semantic_score"
            ),

            reason=(
                "Therapeutically or semantically "
                "similar and currently available. "
                "It may not contain the same "
                "active ingredients."
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
