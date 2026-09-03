import json
from pydantic import ValidationError
# افترضنا استيراد النموذج والدوال الخاصة بك
# from models import CustomerRegistrationSchema

async def _process_registration_flow(self, user_message: str) -> dict:
    # 1. إعداد الـ Prompt المبدئي
    schema_str = json.dumps(CustomerRegistrationSchema.model_json_schema(), ensure_ascii=False)
    
    messages = [
        {
            "role": "system",
            "content": (
                f"أنت موديل استخراج بيانات. مهمتك فحص رسالة المستخدم واستخراج الاسم والعنوان كـ JSON فقط بالصيغة التالية.\n"
                f"التزم تماماً بالـ schema التالية:\n{schema_str}\n"
                f"لا تكتب أي نص آخر خارج الـ JSON.\n"
                f"إذا كانت الرسالة لا تحتوي صراحة على اسم أو عنوان، فأرجع:\n"
                f'{{"name": null, "address": null}}\n'
                f"إياك واختلاق أي اسم أو عنوان من رأسك."
            )
        },
        {"role": "user", "content": user_message}
    ]

    max_retries = 2  # عدد محاولات إعادة المحاولة عند حدوث خطأ
    
    for attempt in range(max_retries + 1):
        try:
            # استدعاء الـ LLM
            response_message = await self.llm_client.generate_reply(messages, [])
            
            # استخراج محتوى الرد (سواء كان dict أو object)
            msg = (
                response_message.get("message")
                if isinstance(response_message, dict)
                else getattr(response_message, "message", None)
            )

            # لو الرد جه كنص (String) فيه JSON داخل Markdown مثلاً، نعمله parse
            if isinstance(msg, str):
                msg_clean = msg.strip().removeprefix("```json").removesuffix("```").strip()
                msg = json.loads(msg_clean)

            # 2. الـ Validation باستخدام Pydantic
            if isinstance(msg, dict):
                validated_data = CustomerRegistrationSchema.model_validate(msg)
                
                # نجاح الـ Validation! نحول إلى Dict ونرجع النتيجة فوراً
                customer_dict = validated_data.model_dump()
                return customer_dict
            else:
                raise ValueError("الرد المرجع ليس بصيغة Dictionary أو JSON صحيح.")

        except (ValidationError, ValueError, json.JSONDecodeError) as e:
            # في حالة الفشل ووعدم استنفاد المحاولات
            if attempt < max_retries:
                # إعداد رسالة التصحيح للـ LLM
                error_details = e.json() if isinstance(e, ValidationError) else str(e)
                
                # إضافة الرد الخاطئ وتنبيه الخطأ لسياق المحادثة (Conversation History)
                messages.append({"role": "assistant", "content": str(msg)})
                messages.append({
                    "role": "user",
                    "content": (
                        f"الرد السابق كان غير مطابق للمطلوب بسبب الخطأ التالي:\n{error_details}\n"
                        f"يرجى إعادة إخراج الـ JSON بشكل صحيح تماماً وبدون أي نص خارجي."
                    )
                })
            else:
                # 3. في حالة استنفاد جميع المحاولات (Fallback Strategy)
                # بدلاً من انهيار السيرفر، نرجع قاموس فاضي نمنع بيه الـ 500 Internal Error
                print(f"[Registration Flow] Failed after {max_retries} retries. Error: {e}")
                return {"name": None, "address": None}
