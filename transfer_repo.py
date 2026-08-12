from dataclasses import dataclass
from enum import Enum
from typing import Any, Optional


class TransferStatus(str, Enum):
    PENDING = "PENDING"
    COMPLETED = "COMPLETED"
    FAILED = "FAILED"


@dataclass
class TransferEntity:
    id: str
    item_code: str
    quantity: int
    source_id: str
    destination_branch_id: str
    source_type: str
    status: TransferStatus


class TransferRepository:

    def __init__(self, pool_manager: Any):
        """نمرر هنا الـ pool_manager بدلاً من db connection ثابت"""
        self.pool_manager = pool_manager

    async def create_transfer(
        self,
        item_code: str,
        quantity: int,
        source_id: str,
        destination_branch_id: str,
        source_type: str,
    ) -> TransferEntity:
        """إنشاء سجل تحويل في قاعدة البيانات الخاصّة بالفرع الهدف (destination_branch)"""

        # 1. جلب الـ Connection Pool أو الـ Connection الخاص بفرع الوصول
        # الاعتماد على destination_branch_id للوصول لقاعدة البيانات المطلوبة
        async with self.pool_manager.get_connection(
            destination_branch_id
        ) as conn:

            # 2. تنفيذ الاستعلام على قاعدة البيانات الخاصة بالفرع الهدف
            query = """
                INSERT INTO transfers (
                    item_code, 
                    quantity, 
                    source_id, 
                    destination_branch_id, 
                    source_type, 
                    status
                )
                VALUES ($1, $2, $3, $4, $5, $6)
                RETURNING id, item_code, quantity, source_id, destination_branch_id, source_type, status;
            """

            record = await conn.fetch_one(
                query,
                item_code,
                quantity,
                source_id,
                destination_branch_id,
                source_type,
                TransferStatus.PENDING.value,
            )

            return TransferEntity(
                id=str(record["id"]),
                item_code=record["item_code"],
                quantity=record["quantity"],
                source_id=record["source_id"],
                destination_branch_id=record["destination_branch_id"],
                source_type=record["source_type"],
                status=TransferStatus(record["status"]),
            )

    async def update_status(
        self,
        transfer_id: str,
        destination_branch_id: str,
        status: TransferStatus,
    ) -> None:
        """تحديث حالة النقل في قاعدة بيانات فرع الوصول"""
        async with self.pool_manager.get_connection(
            destination_branch_id
        ) as conn:
            query = "UPDATE transfers SET status = $1 WHERE id = $2"
            await conn.execute(query, status.value, transfer_id)
