"""
ALTER TABLE products 
ADD COLUMN patient_counseling JSONB DEFAULT '[]'::jsonb,
ADD COLUMN usage_warnings TEXT;

-- مثال لإدخال بيانات الدوكسيسيكلين (Doxycycline):
UPDATE products 
SET patient_counseling = '[
  "تناول الكبسولة مع كوب ماء كبير (200-250 مل) ولا تستلقِ لمدة 30 دقيقة بعدها لتجنب تهيج المريء.",
  "افصل بين الجرعة ومنتجات الألبان (اللبن/الجبن/الزبادي) بساعتين على الأقل.",
  "تجنب التعرض المباشر لأشعة الشمس واستخدم واقي الشمس أثناء فترة العلاج.",
  "افصل بساعتين بين الجرعة وأقراص الكالسيوم أو الحديد أو مضادات الحموضة."
]'::jsonb
WHERE id = 'doxycycline_100mg';


"""


# app/services/order_counseling.py

async def generate_order_patient_guide(order_id: str) -> str:
    # 1. جلب الأصناف المشتراة في الطلب مع تعليماتها الطبية من الداتابيز
    order_items = await order_repo.get_items_with_counseling(order_id)
    
    counseling_summary = []
    
    for item in order_items:
        if item.patient_counseling:  # إذا كان الدواء يحتوي على تعليمات خاصة
            bullets = "\n".join([f"  • {tip}" for tip in item.patient_counseling])
            counseling_summary.append(f"💊 *{item.product_name}*:\n{bullets}")
            
    if not counseling_summary:
        return None  # لا يوجد أدوية تتطلب تعليمات خاصة في هذا الطلب
        
    # 2. تجميع التعليمات في نص مهيكل جاهز
    full_guide_text = (
        "تعليمات وإرشادات هامة لاستخدام أدويتك لسلامتك:\n\n" +
        "\n\n".join(counseling_summary)
    )
    return full_guide_text
"""
-- SQL Query: Get Order with Items & Patient Counseling
SELECT 
    o.id AS order_id,
    o.customer_id,
    o.status,
    o.total_amount,
    COALESCE(
        json_agg(
            json_build_object(
                'product_id', p.id,
                'product_name', p.name,
                'quantity', oi.quantity,
                'patient_counseling', p.patient_counseling,
                'usage_warnings', p.usage_warnings
            )
        ) FILTER (WHERE p.id IS NOT NULL), '[]'
    ) AS items
FROM orders o
JOIN order_items oi ON o.id = oi.order_id
JOIN products p ON oi.product_id = p.id
WHERE o.id = $1
GROUP BY o.id;
"""

# app/schemas/order.py

from pydantic import BaseModel
from typing import List, Optional, Any

class OrderItemCounseling(BaseModel):
    product_id: str
    product_name: str
    quantity: int
    patient_counseling: Optional[List[str]] = []
    usage_warnings: Optional[str] = None

class OrderDetailsWithCounseling(BaseModel):
    order_id: str
    customer_id: str
    status: str
    total_amount: float
    items: List[OrderItemCounseling]

# app/repositories/order_repository.py

from typing import Optional
from asyncpg import Pool, Connection
from app.schemas.order import OrderDetailsWithCounseling

class OrderRepository:
    def __init__(self, db_pool: Pool):
        self.pool = db_pool

    async def get_order_with_patient_counseling(
        self, order_id: str, conn: Optional[Connection] = None
    ) -> Optional[OrderDetailsWithCounseling]:
        """
        جلب تفاصيل الطلب مع قائمة التعليمات الطبية (JSONB) للأدوية المشتراة في استعلام واحد.
        يدعم إمكانية التمرير بداخل Transaction قائمة أو فتح Connection جديدة.
        """
        query = """
            SELECT 
                o.id AS order_id,
                o.customer_id,
                o.status,
                o.total_amount::float,
                COALESCE(
                    json_agg(
                        json_build_object(
                            'product_id', p.id,
                            'product_name', p.name,
                            'quantity', oi.quantity,
                            'patient_counseling', p.patient_counseling,
                            'usage_warnings', p.usage_warnings
                        )
                    ) FILTER (WHERE p.id IS NOT NULL), '[]'::json
                )::text AS items_json
            FROM orders o
            JOIN order_items oi ON o.id = oi.order_id
            JOIN products p ON oi.product_id = p.id
            WHERE o.id = $1
            GROUP BY o.id;
        """
        
        executor = conn if conn else self.pool

        row = await executor.fetchrow(query, order_id)
        if not row:
            return None

        import json
        items_data = json.loads(row["items_json"])

        return OrderDetailsWithCounseling(
            order_id=row["order_id"],
            customer_id=row["customer_id"],
            status=row["status"],
            total_amount=row["total_amount"],
            items=items_data
        )

    async def complete_order_and_get_summary(
        self, order_id: str
    ) -> Optional[OrderDetailsWithCounseling]:
        """
        عمليات الـ Checkout والتحديث الذري (Atomic Transaction):
        تحديث حالة الطلب لـ COMPLETED ثم جلب بيانات الإرشادات الطبية فوراً.
        """
        async with self.pool.acquire() as connection:
            async with connection.transaction():
                # 1. تحديث حالة الطلب
                update_query = """
                    UPDATE orders 
                    SET status = 'COMPLETED', updated_at = NOW()
                    WHERE id = $1 AND status = 'PENDING'
                    RETURNING id;
                """
                updated_id = await connection.fetchval(update_query, order_id)
                if not updated_id:
                    return None

                # 2. جلب التعليمات بداخل نفس الـ Transaction
                return await self.get_order_with_patient_counseling(order_id, conn=connection)
# app/services/counseling_service.py

from app.repositories.order_repository import OrderRepository

class OrderCounselingService:
    def __init__(self, order_repo: OrderRepository):
        self.order_repo = order_repo

    async def build_counseling_payload(self, order_id: str) -> Optional[str]:
        order_details = await self.order_repo.get_order_with_patient_counseling(order_id)
        if not order_details:
            return None

        counseling_blocks = []
        
        for item in order_details.items:
            # نقوم بتجميع الأدوية التي تحتوي على تعليمات فقط
            if item.patient_counseling or item.usage_warnings:
                block = f"💊 *{item.product_name}*:\n"
                
                if item.patient_counseling:
                    tips = "\n".join([f"  • {tip}" for tip in item.patient_counseling])
                    block += tips
                
                if item.usage_warnings:
                    block += f"\n  ⚠️ *تحذير:* {item.usage_warnings}"
                    
                counseling_blocks.append(block)

        if not counseling_blocks:
            return None  # الطلب خالي من أي أدوية تحتاج تعليمات خاصة

        # الهيكل النهائي المصنوع للنظام والـ LLM
        return (
            "[SYSTEM_EVENT: ORDER_COMPLETED_WITH_COUNSELING]\n"
            "تم إتمام الطلب. يرجى إرسال الرسالة التالية للعميل بأسلوب صيدلي ودود وواضح:\n\n"
            "إليك أهم التعليمات والإرشادات الطبية الخاصة بطلبك لضمان سلامتك وفاعلية العلاج:\n\n"
            + "\n\n".join(counseling_blocks)
        )

