import uuid
from dataclasses import dataclass
from enum import Enum
from typing import Any


class TransferStatus(str, Enum):
    PENDING = "PENDING"
    APPROVED = "APPROVED"
    REJECTED="REJECTED
    FAILED = "FAILED"


@dataclass
class TransferEntity:
    transfer_id: uuid
    item_code: str
    quantity: int
    source_id: str
    destination_branch_id: str
    source_type: str
    status: TransferStatus
    notes : str


class TransferRepository:

    def __init__(self, pool_manager: Any):
        """نمرر هنا الـ pool_manager لجلب الاتصالات ديناميكيًا بناءً على الفرع"""
        self.pool_manager = pool_manager

    async def create_transfer(
        self,
        item_code: str,
        quantity: int,
        source_id: int,
        destination_branch_id: int,
        source_type: str,
        notes : str | None = None
    ) -> TransferEntity:
        """إنشاء سجل تحويل في قاعدة بيانات الفرع المصدر (source_id)"""
        generated_uuid=str(uuid.uuid4())
        # 1. جلب الاتصال الخص بـ source_id من الـ pool_manager
        async with self.pool_manager.get_connection(branch_name) as conn:

            # 2. تنفيذ الاستعلام على قاعدة بيانات الفرع المصدر
            query = """
                INSERT INTO transfer.transfer (
                    transfer_id,
                    item_code, 
                    quantity, 
                    source_id, 
                    destination_branch_id, 
                    source_type, 
                    status,
                    notes
                )
                VALUES ($1, $2, $3, $4, $5, $6,$7,$8)
                RETURNING transfer_id, item_code, quantity, source_id, destination_branch_id, source_type, status,notes;
            """

            record = await conn.fetch_one(
                query,
                generated_uuid,
                item_code,
                quantity,
                source_id,
                destination_branch_id,
                source_type,
                TransferStatus.PENDING.value,
                notes
            )

            return TransferEntity(
                transfer_id=str(record["transfer_id"]),
                item_code=record["item_code"],
                quantity=record["quantity"],
                source_id=record["source_id"],
                destination_branch_id=record["destination_branch_id"],
                source_type=record["source_type"],
                status=TransferStatus(record["status"]),
                notes=record["notes"],
            )
            
async def update_status(
    self,
    transfer_id: str,
    branch_name: str,
    status: TransferStatus,
) -> TransferEntity:
    """
    تحديث حالة طلب التحويل في قاعدة بيانات الفرع المصدر
    """
    async with self.pool_manager.get_connection(branch_name) as conn:
        query = """
            UPDATE transfer.transfer
            SET status = $1,
                updated_at = NOW()
            WHERE id = $2
            RETURNING transfer_id, item_code, quantity, source_id, destination_branch_id, source_type, status;
        """
        
        record = await conn.fetch_one(
            query,
            status.value,  # تمرير القيمة النصية لـ Enum
            transfer_id, 
        )

        if not record:
            raise ValueError(f"Transfer with ID {transfer_id} not found in source {source_id}.")

        return TransferEntity(
            transfer_id=str(record["id"]),
            item_code=record["item_code"],
            quantity=record["quantity"],
            source_id=record["source_id"],
            destination_branch_id=record["destination_branch_id"],
            source_type=record["source_type"],
            status=TransferStatus(record["status"]),
        )
        
       
