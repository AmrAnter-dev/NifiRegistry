import logging
from typing import Type, TypeVar, List, Dict, Any, Optional
from pydantic import BaseModel, ValidationError

logger = logging.getLogger(__name__)

# TypeVar لضمان التوافق التام مع IDE Auto-complete للناتج
T = TypeVar("T", bound=BaseModel)


class OllamaClient(BaseLLMClient):

    async def generate_structured(
        self,
        system_prompt: str,
        user_message: str,
        response_model: Type[T],
        temperature: float = 0.0,
        max_retries: int = 3,
        **kwargs: Any
    ) -> T:
        """
        Generates a structured output validated against a Pydantic Model.

        Args:
            system_prompt: High-level instructions for the agent.
            user_message: The actual input/query.
            response_model: The Pydantic model class to enforce and validate.
            temperature: Sampling temperature (defaults to 0.0 for deterministic structured outputs).
            max_retries: Max self-correction retries on parsing/validation failure.
            **kwargs: Extra arguments passed down to generate_reply (e.g. tools_schema, options_override).

        Returns:
            An instance of response_model containing validated data.
        """
        # 1. استخراج الـ Schema وحقن تعليمات الـ Structured Format
        json_schema = response_model.model_json_schema()

        structured_system_prompt = (
            f"{system_prompt}\n\n"
            f"### REQUIRED OUTPUT FORMAT\n"
            f"You MUST return ONLY a valid JSON object matching the following JSON Schema:\n"
            f"```json\n{json_schema}\n```\n"
            f"Do NOT include any text, intro, explanations, or codeblock tags (like ```json) outside the pure JSON payload."
        )

        messages: List[Dict[str, Any]] = [
            {"role": "system", "content": structured_system_prompt},
            {"role": "user", "content": user_message},
        ]

        last_error: Optional[Exception] = None

        # 2. Execution Loop مع آلية الـ Self-Correction
        for attempt in range(1, max_retries + 1):
            try:
                # استدعاء الدالة الأساسية لتمرير الطلب لـ Ollama
                # يتم تمرير temperature في kwargs كـ options_override لو لزم الأمر
                options_override = kwargs.pop("options_override", {})
                options_override["temperature"] = temperature

                response_dict = await self.generate_reply(
                    messages=messages,
                    options_override=options_override,
                    **kwargs
                )

                # استخراج النص الصافي من رد Ollama
                raw_text = response_dict.get("message", {}).get("content", "")

                # 3. استخدام parse_llm_json لمعالجة الـ JSON وتحويله لـ Pydantic Model
                # (سواء كانت parse_llm_json دالة عامة أو static method لديك)
                structured_data: T = parse_llm_json(raw_text, response_model)
                return structured_data

            except (ValidationError, ValueError, TypeError) as err:
                last_error = err
                logger.warning(
                    f"[Structured Generation] Attempt {attempt}/{max_retries} failed for "
                    f"model '{response_model.__name__}': {str(err)}"
                )

                if attempt == max_retries:
                    break

                # 4. إضافة الإجابة الخاطئة + رسالة الخطأ للـ Context لإجبار الموديل على التصحيح (Self-Correction Prompt)
                messages.append({"role": "assistant", "content": raw_text})
                messages.append({
                    "role": "user",
                    "content": (
                        f"Your output was invalid and failed with error:\n`{str(err)}`\n"
                        f"Please correct the JSON syntax or schema mismatches and output ONLY valid JSON."
                    )
                })

        raise ValueError(
            f"Failed to generate valid structured response for '{response_model.__name__}' "
            f"after {max_retries} attempts. Last error: {last_error}"
        ) from last_error

class IntentToolRegistry:

    def __init__(self):
        self._mapping = {
            Intent.SEARCH_PRODUCT: [
                "search_products",
            ],
            Intent.CHECK_STOCK: [
                "search_products",
                "check_stock",
            ],
            Intent.ADD_TO_CART: [
                "search_products",
                "add_to_cart",
            ],
            Intent.VIEW_CART: [
                "get_cart",
            ],
            Intent.CHECKOUT: [
                "checkout",
            ],
            Intent.ORDER_STATUS: [
                "get_order_status",
            ],
            Intent.CANCEL_ORDER: [
                "cancel_order",
            ],
            Intent.UNKNOWN: [],
        }

    def get_tools(self, intent: Intent) -> list[str]:
        return self._mapping.get(intent, [])

from enum import Enum
from pydantic import BaseModel, Field


class Intent(str, Enum):
    SEARCH_PRODUCT = "search_product"
    CHECK_STOCK = "check_stock"
    ADD_TO_CART = "add_to_cart"
    VIEW_CART = "view_cart"
    CHECKOUT = "checkout"
    ORDER_STATUS = "order_status"
    CANCEL_ORDER = "cancel_order"
    UNKNOWN = "unknown"


class IntentResult(BaseModel):
    intent: Intent = Field(
        description="The user's primary intent."
    )


class IntentRetriever:

    def __init__(self, llm):
        self._llm = llm

    async def retrieve(self, user_message: str) -> Intent:
        result = await self._llm.generate_structured(
            system_prompt=self._build_system_prompt(),
            user_message=user_message,
            response_model=IntentResult,
        )

        return result.intent

    @staticmethod
    def _build_system_prompt() -> str:
        return """
You are an intent classification component for a pharmacy assistant.

Your ONLY task is to identify the user's primary intent.

Do NOT:
- answer the user
- call tools
- extract tool parameters
- invent intents
- perform any business logic

Choose exactly ONE intent from the allowed intents.

Allowed intents:

- search_product:
  User wants to find or search for a product.

- check_stock:
  User wants to know whether a product is available
  or how much is available.

- add_to_cart:
  User wants to add a product to the shopping cart.

- view_cart:
  User wants to see the current shopping cart.

- checkout:
  User wants to confirm or execute the order.

- order_status:
  User wants to know the status of an existing order.

- cancel_order:
  User wants to cancel an existing order.

- unknown:
  The request does not clearly match any available intent.

Return only the structured intent.
"""
async def get_many(self, names: list[str]) -> list[Tool]:
    """
    Return registered tools matching the given names.

    Unknown tool names are ignored.
    The order of the returned tools follows the order of `names`.
    Duplicate names are removed.
    """
    if not names:
        return []

    seen: set[str] = set()
    tools: list[Tool] = []

    for name in names:
        if name in seen:
            continue

        seen.add(name)

        tool = self._tools.get(name)

        if tool is not None:
            tools.append(tool)

    return tools

