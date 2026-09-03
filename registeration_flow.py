 async def _process_registration_flow(self, user_message: str):
        
        schema_str = json.dumps(CustomerRegistrationSchema.model_json_schema(),ensure_ascii=False)
        registration_prompt = [
            {
                "role": "system",
                "content": (
                f" أنت موديول استخراج بيانات. مهمتك فحص رسالة المستخدم واستخراج الاسم والعنوان كـ JSON فقط بالصيغة التالية:\n"
                f" التزم بال schema  التالية تمام:\n"
                f"{schema_str}\n"
                f" لا تكتب أي نص آخر خارج الـ JSON.\n"
                f" إذا كانت رسالة المستخدم مجرد تحية أو سؤال عام أو لا تحتوي صراحة على اسم أو عنوان، فأرجع JSON بالقيم التالية فقط:\n"
                f'{{"name": null, "address": null}}\n'
                f" إياك واختلاق أي اسم أو عنوان من رأسك."
               ),
            },
            {"role": "user", "content": user_message}
        ]
        
       
        messages=[]
        
        
        max_retries = 2  # عدد محاولات إعادة المحاولة عند حدوث خطأ
    
        for attempt in range(max_retries + 1):
        

            try:
                
                current_prompt = registration_prompt + messages
                response_message = await self.llm_client.generate_reply(current_prompt, [])

                msg = (
                    response_message.get("message")
                    if isinstance(response_message, dict)
                    else getattr(response_message, "message", None)
                )

                if hasattr(msg, "content"):
                    raw_content = msg.content
                elif isinstance(msg, dict):
                    raw_content = msg.get("content", "")
                else:
                    raw_content = str(msg or "")
                
                print(f"DEBUG raw_content : raw_content.type = {type(raw_content)} raw_content.content = {raw_content}")

                raw_content = raw_content.strip()

                parsed_content = parse_llm_json(raw_content)
                
                print(f"DEBUG parsed_content : parsed_content.type = {type(parsed_content)} parsed_content.content = {parsed_content}")
                
                if not isinstance(parsed_content, dict):
                    return None

                validated_customer_data=CustomerRegistrationSchema.model_validate(parsed_content)
                
                name=validated_customer_data.name
                
                address=validated_customer_data.address
                
                has_valid_address = False
                
                if address:
                
                    parsed_address= address.model_dump(exclude_none=True)

                    

                    if isinstance(parsed_address, dict):
                        # التأكد من وجود قيمة حقيقية غير فارغة داخل القاموس
                        has_valid_address = any(bool(v and str(v).strip()) for v in parsed_address.values())
            
                if not name and not has_valid_address:
                    return None

                return validated_customer_data
            
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
                    
                    print(f"[Registration Flow] Failed after {max_retries} retries. Error: {e}")
                    logger.error("خطأ غير متوقع أثناء معالجة رسالة التسجيل: %s", e)
                    return None
       

            
