import json
import re
from typing import Any, Dict, List, Optional, Union
import logging

logger = logging.getLogger(__name__)

def parse_llm_json(raw_response: Union[str, Dict[str, Any]]) -> Dict[str, Any]:
    """
    دالة موحدة لاستخراج وتنظيف الـ JSON من مخرجات الـ LLM
    تتعامل مع:
    1. الـ Dict المباشر إذا كان الكلاينت مرجع dict.
    2. الـ Markdown blocks (```json ... ``` أو ``` ... ```).
    3. النصوص الجانبية والمقدمات الشارحة قبل وبعد الـ JSON.
    4. قيم 'null' و 'None' النصية وتحويلها إلى None.
    """
    if not raw_response:
        raise ValueError("الرد القادم من الـ LLM فارغ.")

    # لو الرد جايلك جاهز كـ Dict من مكتبة الكلاينت
    if isinstance(raw_response, dict):
        return _clean_null_strings(raw_response)

    text = str(raw_response).strip()

    # 1. محاولة التحليل المباشر (Direct Parsing)
    try:
        data = json.loads(text)
        if isinstance(data, dict):
            return _clean_null_strings(data)
    except json.JSONDecodeError:
        pass

    # 2. استخراج الـ JSON باستخدام Regex لتجاوز الـ Markdown والأقواس المتداخلة
    # بيبحث عن أول {...} أو [...] سواء جوا ```json أو خارجها
    json_pattern = r"(?:```(?:json)?\s*)?(\{[\s\S]*\}|\[[\s\S]*\])(?:\s*```)?"
    match = re.search(json_pattern, text)

    if match:
        json_str = match.group(1).strip()
        try:
            data = json.loads(json_str)
            if isinstance(data, dict):
                return _clean_null_strings(data)
            elif isinstance(data, list):
                return {"items": _clean_null_strings(data)}
        except json.JSONDecodeError as e:
            logger.error(f"فشل تحليل الـ JSON بعد الاستخراج بالـ Regex: {e}")

    raise json.JSONDecodeError(
        f"فشل استخراج JSON صالح من رد الـ LLM. النص الخام: {text[:100]}...",
        doc=text,
        pos=0
    )


def _clean_null_strings(data: Union[Dict, List, Any]) -> Any:
    """دالة مساعدة لتنظيف القيم النصية مثل 'null' و 'None' و '' وتحويلها لـ None حقيقي."""
    if isinstance(data, dict):
        return {
            k: (None if v in ["null", "None", "NULL", ""] else _clean_null_strings(v))
            for k, v in data.items()
        }
    elif isinstance(data, list):
        return [_clean_null_strings(item) for item in data]
    return data
