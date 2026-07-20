لو أنا ببنى Agent احترافى **لن أكتب IntentRouter يعتمد على if/else** مثل:

```python
if "منتج" in query:
    ...
elif "مخزون" in query:
    ...
```

لأن بعد شهر هيبقى عندك 50 Intent.

بدلاً من ذلك أبنى Router يعتمد على **LLM Classification**.

الفكرة:

```
Customer
      │
      ▼
 IntentRouter
      │
      ├──────────────┐
      ▼              ▼
 CHAT           TOOL_CALLING
                     │
                     ▼
                 CustomerAgent
                     │
                     ▼
               ToolManager
```

أو

```
                 IntentRouter
                      │
     ┌────────┬──────────┬──────────┐
     ▼        ▼          ▼          ▼
   CHAT      RAG      TOOL      HYBRID
```

---

## Intent Enum

```python
from enum import Enum


class Intent(str, Enum):
    CHAT = "chat"
    RAG = "rag"
    TOOL = "tool"
    HYBRID = "hybrid"
```

---

## نتيجة التصنيف

```python
from pydantic import BaseModel


class IntentResult(BaseModel):
    intent: Intent
    confidence: float
    reason: str
```

---

## Base Router

```python
from abc import ABC, abstractmethod


class BaseIntentRouter(ABC):

    @abstractmethod
    def classify(self, query: str) -> IntentResult:
        pass
```

---

## LLM Router

```python
import json


class LLMIntentRouter(BaseIntentRouter):

    def __init__(self, llm):

        self.llm = llm

    def classify(self, query: str) -> IntentResult:

        prompt = f"""
أنت مصنف للنوايا.

اختر واحدة فقط:

chat
rag
tool
hybrid

chat
للتحية والكلام العام.

rag
إذا احتاج السؤال إلى البحث فى قاعدة المعرفة.

tool
إذا احتاج تنفيذ Tool مثل البحث عن منتج أو التحقق من المخزون أو إنشاء طلب.

hybrid
إذا احتاج RAG ثم Tool.

أعد JSON فقط.

مثال:

{{
"intent":"tool",
"confidence":0.96,
"reason":"The user wants to check product availability."
}}

السؤال:

{query}
"""

        response = self.llm.generate(prompt)

        data = json.loads(response)

        return IntentResult(**data)
```

---

## داخل الـ Agent

```python
intent = router.classify(user_query)

match intent.intent:

    case Intent.CHAT:

        return self.chat(user_query)

    case Intent.RAG:

        return self.rag(user_query)

    case Intent.TOOL:

        return self.tool_calling(user_query)

    case Intent.HYBRID:

        return self.hybrid(user_query)
```

---

# والأهم...

أنا **لن أرسل جميع الأدوات للموديل**.

لو عندك

```
InventoryTool

SearchTool

OrderTool

ReturnTool

ReviewTool

RecommendationTool

FAQTool

SupportTool

...
```

فإرسالهم كلهم فى كل Request سيقلل دقة الاختيار ويزيد الـ Tokens.

لذلك أضيف خطوة أخرى:

```
IntentRouter
      │
      ▼
ToolSelector
      │
      ▼
LLM
```

مثلاً:

```python
TOOLS_BY_INTENT = {

    Intent.TOOL: [
        "search_products",
        "inventory",
        "order"
    ],

    Intent.RAG: [
        "rag_search"
    ],

    Intent.HYBRID: [
        "rag_search",
        "inventory",
        "search_products"
    ]
}
```

ثم:

```python
tools = tool_manager.get_tools(
    TOOLS_BY_INTENT[intent.intent]
)
```

وبذلك يحصل الـ LLM على **3 أدوات فقط** بدلاً من 25 أداة، مما يحسن دقة الاختيار ويقلل استهلاك الـ Tokens.

## ملاحظة مهمة

إذا كان مشروعك يستخدم **Ollama Tool Calling**، ففي كثير من الحالات يمكنك **الاستغناء عن `IntentRouter` بالكامل**. أعطِ الموديل أدوات موصوفة جيدًا، وإذا كانت الرسالة مجرد تحية أو سؤال عام فلن يستدعي أي Tool، وسيجيب مباشرة. عندها يكفي أن يكون لديك:

```
User
   │
   ▼
CustomerAgent
   │
   ▼
LLM (مع مجموعة الأدوات المناسبة)
   │
   ├── لا يوجد tool_calls → أرسل الرد للمستخدم
   └── يوجد tool_calls → ToolManager → نتيجة الأداة → LLM → الرد النهائي
```

أنصح بإضافة `IntentRouter` فقط إذا كان لديك عشرات الأدوات، أو كنت تريد التحكم الصارم في متى يُسمح باستخدام RAG أو أنواع معينة من الأدوات، أو كنت تريد تقليل تكلفة وعدد الـ tokens. أما مع عدد صغير إلى متوسط من الأدوات، فغالبًا يكون تصميم الـ Tool Calling المباشر أبسط وأكثر قابلية للصيانة.
