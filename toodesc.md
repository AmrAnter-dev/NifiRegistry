بالضبط، ودى من أهم أسباب نجاح أو فشل الـ Tool Calling.

الموديل **لا يرى الكود**، هو يرى فقط:

* اسم الأداة (name)
* الوصف (description)
* Parameters
* Required fields

إذا كان الوصف ضعيفًا، سيختار الأداة الخطأ.

---

## مثال سيئ

```python
class SearchTool(BaseTool):

    name = "search"

    description = "Search products."
```

الموديل لن يعرف:

* search فين؟
* PostgreSQL؟
* Vector DB؟
* Elasticsearch؟
* Product؟
* FAQ؟

---

## مثال احترافي

```python
class SearchProductsTool(BaseTool):

    name = "search_products"

    description = """
Search the product catalog.

Use this tool ONLY when the customer wants to:

- search for products
- recommend products
- compare products
- search by category
- search by brand
- search by features
- search by price range

Do NOT use this tool for:

- checking stock availability
- tracking orders
- returns
- company policies
- FAQs

Always pass the complete customer query.
"""
```

الفرق ضخم.

---

## Inventory Tool

```python
class InventoryTool(BaseTool):

    name = "check_inventory"

    description = """
Check current inventory.

Use ONLY when the customer asks:

- هل المنتج متوفر؟
- عندكم؟
- متى يتوفر؟
- كام قطعة؟
- In stock?
- Available?

Input:

Product name.

Output:

Availability
Quantity
Warehouse
Expected restock date.
"""
```

---

## RAG Tool

```python
class RagSearchTool(BaseTool):

    name = "knowledge_search"

    description = """
Search the company knowledge base.

Use ONLY when the customer asks about:

- company policy
- warranty
- shipping
- returns
- payment
- documentation
- manuals
- technical information

Do NOT use for product search.
"""
```

---

## Order Tool

```python
class OrderStatusTool(BaseTool):

    name = "get_order_status"

    description = """
Retrieve customer order status.

Use ONLY when the customer asks:

- أين طلبي؟
- Track my order.
- حالة الطلب.
- الشحنة وصلت فين؟

Requires:

order_number
```

---

# Parameters مهمة جدًا

بدل

```python
{
    "type":"object",
    "properties":{
        "query":{
            "type":"string"
        }
    }
}
```

اكتب

```python
{
    "type":"object",
    "properties":{
        "query":{
            "type":"string",
            "description":"Complete customer request exactly as written."
        }
    }
}
```

حتى الـ parameter له Description.

---

# أسماء الأدوات

بدل

```text
search
inventory
tool1
tool2
```

استعمل أسماء واضحة.

```text
search_products

check_inventory

get_order_status

search_knowledge_base

create_order

cancel_order

recommend_products
```

الـ LLM يعتمد كثيرًا على الاسم.

---

# وهناك نقطة أهم من الوصف

أنا لاحظت من مشروعك أنك ستبنى Agent لمتجر.

أنا لن أكتب الوصف بهذه الطريقة فقط.

بل سأضيف **Few-shot examples** داخل الـ description.

مثلاً:

```text
Use this tool when:

Customer:
"رشحلي لابتوب"

Customer:
"أريد شاشة سامسونج"

Customer:
"عندكم iPhone 16؟"

Customer:
"Show gaming laptops."

Customer:
"أفضل موبايل أقل من 20000 جنيه."

Do not use when:

Customer:
"أين طلبي؟"

Customer:
"سياسة الاسترجاع"

Customer:
"طرق الدفع"
```

هذه الأمثلة تجعل الموديل يفهم متى يستخدم الأداة ومتى لا يستخدمها، وغالبًا تحسن دقة الاختيار أكثر من مجرد وصف عام.

---

## التصميم الذي أنصح به لمشروعك

بما أنك تبني **Shopping Agent**، اجعل كل Tool تحتوي على:

```python
class BaseTool:

    name: str

    description: str

    examples: list[str]

    parameters: dict

    execute(...)
```

ثم عند تحويلها إلى Schema (`to_ollama_format()`)، ادمج الوصف والأمثلة:

```text
Description
+
Examples
+
Do NOT use when...
```

بهذا يصبح لدى الـ LLM سياق غني يساعده على اختيار الأداة الصحيحة دون الحاجة إلى كتابة قواعد `if/else` في الكود. هذا الأسلوب هو الأقرب لما تستخدمه أطر عمل احترافية مثل LangChain وLlamaIndex عند تصميم أدوات الـ Agents.
