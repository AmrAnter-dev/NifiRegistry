import logging
from typing import Dict, Any, Optional, List
from repositories.branch_repo import BranchRepository
from repositories.central_repo import CentralRepository
from models.models import Allocation, AvailabilityResult, AvailabilityStatus

logger = logging.getLogger("inventory_service")

# ============================================================
# 4. Inventory & Allocation Domain
# ============================================================

@dataclass(slots=True)
class Allocation:
    
    product_id: int 
    item_code: int = 0
    branch_id: int = 0
    expiry_date: Optional[datetime] =None
    quantity_available: float = 0.0


@dataclass(frozen=True, slots=True)
class AvailabilityResult:
    item_code: int
    requested_quantity: int
    local_quantity: int
    network_quantity: int
    allocations: list[Allocation]
    status: AvailabilityStatus

    @property
    def total_available(self) -> float:
        return sum(allocation.qty_available for allocation in self.allocations)

    def shortfall(self) -> float:
        return max(0.0, self.requested_quantity - self.total_available)


@dataclass(frozen=True, slots=True)
class InventoryAvailabilityResult:
    item_code: int
    requested_quantity: int
    local_quantity: int
    network_quantity: int
    status: AvailabilityStatus
    allocations: list[Allocation]

class InventoryService:
    def __init__(self, branch_repo: BranchRepository, central_repo: CentralRepository):
        self._branch_repo = branch_repo
        self._central_repo = central_repo

    async def get_stock(self, branch_name: str, item_code: int) -> Dict[str, Any]:
        """
        فحص المخزون المحلي مع الرجوع للمركزي عند العدم.
        """
        local_allocation: Optional[Allocation] = await self._branch_repo.get_stock(branch_name,item_code)

        if not local_allocation or local_allocation.quantity_available == 0:
            logger.info(f"المنتج {item_code} غير متوفر في الفرع المحلي {branch_name}. جاري استدعاء الـ Central Repository...")
            
            central_stock_result = await self._central_repo.get_stock_all_branches(item_code)

            return {
                "status": "CENTRAL_FALLBACK",
               
                "item_code": item_code,
                "local_qty": 0,
                "central_data": central_stock_result,
                "message": "المنتج غير متوفر محلياً وتم جلب البيانات من المخزون المركزي."
            }

        return {
            "status": "LOCAL_AVAILABLE",
            
            "item_code": item_code,
            "qty_available": local_allocation.quantity_available,
            "message": "المنتج متوفر في المخزون المحلي."
        }

    async def get_availability(
        self,
        *,
        branch_name: str,
        item_code: int,
        requested_quantity: int,
    ) -> AvailabilityResult:

        if requested_quantity <= 0:
            raise ValueError("requested_quantity must be greater than zero.")

        # 1. المخزون المحلي
        local_allocation = await self._branch_repo.get_stock(branch_name,item_code)
        local_quantity =min(
             local_allocation.quantity_available if local_allocation  else 0,
             requested_quantity
        )
        remaining_quantity = requested_quantity - local_quantity

        # 2. إذا كان المحلي يغطي بالكامل
        if local_quantity <= 0:
            return AvailabilityResult(
                item_code=item_code,
                requested_quantity=requested_quantity,
                local_quantity=local_quantity,
                network_quantity=local_quantity,
                allocations=[],
                status=AvailabilityStatus.LOCAL_AVAILABLE,
                fulfilles=True,
                message="المنتج متوفر في المخزون المحلي."
            )

        # 3. إحالة الفحص لباقي فروع الشبكة
        central_allocations = await self._central_repo.get_stock_all_branches(item_code=item_code)
        branch_id= await self._central_repo.get_branch_id(branch_name)
        # استبعاد الفرع المحلي لتجنب تكرار الخصم
        other_branches_allocations = [
            alloc for alloc in central_allocations if alloc.branch_id != branch_id
        ]

        # حساب إجمالي كمية الشبكة الكلية المتوفرة
        total_network_quantity = local_quantity + sum(
            max(0, alloc.quantity_available) for alloc in other_branches_allocations
        )

        # بناء التخصيصات المقسّمة على الفروع
        allocations_plan = self._build_allocations_plan(
            local_branch_id=branch_id,
            local_quantity=local_quantity,
            other_allocations=other_branches_allocations,
            requested_quantity=requested_quantity,
        )

        status = self._determine_status(
            requested_quantity=requested_quantity,
            local_quantity=local_quantity,
            network_quantity=total_network_quantity,
        )

        return AvailabilityResult(
            item_code=item_code,
            requested_quantity=requested_quantity,
            local_quantity=local_quantity,
            network_quantity=total_network_quantity,
            allocations=allocations_plan,
            status=status,
        )

    @staticmethod
    def _determine_status(
        *,
        requested_quantity: int,
        local_quantity: int,
        network_quantity: int,
    ) -> AvailabilityStatus:

        if local_quantity >= requested_quantity:
            return AvailabilityStatus.LOCAL_AVAILABLE

        if network_quantity >= requested_quantity:
            return AvailabilityStatus.NETWORK_AVAILABLE

        if network_quantity > 0:
            return AvailabilityStatus.PARTIALLY_AVAILABLE

        return AvailabilityStatus.UNAVAILABLE

    @staticmethod
    def _build_allocations_plan(
        *,
        local_branch_id: int,
        local_quantity: int,
        other_allocations: List[Allocation],
        requested_quantity: int,
    ) -> List[Allocation]:

        remaining = requested_quantity
        allocations: List[Allocation] = []

        # 1. التخصيص من الفرع المحلي أولاً
        if local_quantity > 0:
            local_used = min(local_quantity, remaining)
            allocations.append(
                Allocation(
                    branch_id=local_branch_id,
                    qty_available=local_used,
                )
            )
            remaining -= local_used

        if remaining <= 0:
            return allocations

        # 2. التخصيص من باقي الفروع بالتوالي
        for allocation in other_allocations:
            if remaining <= 0:
                break

            available = max(0, allocation.qty_available)
            if available <= 0:
                continue

            allocated = min(available, remaining)
            allocations.append(
                Allocation(
                    branch_name=allocation.branch_name,
                    qty_available=allocated,
                )
            )
            remaining -= allocated

        return allocations
    

import logging 
from typing import Any, Optional 
from models.models import Allocation 
from database.db_pool_manager import BranchDBManager
from exceptions.exceptions import RepositoryError
from repositories.base import BaseBranchInventoryRepository


logger = logging.getLogger("branch_product_repository") 

class BranchRepository(BaseBranchInventoryRepository): 

    def __init__(
        self,
        db_manager: BranchDBManager) -> None: 
        """
        
       إنشاء نسخة خاصة بالفرع لتجنب تداخل الاتصالات
        """
        self._db_manager = db_manager 
        
    async def get_stock(self,branch_name : str,
                        item_code: int) -> Optional[Allocation]: 
        """جلب كمية المخزون للدواء بشكل غير متزامن باستخدام asyncpg""" 
        sql = """ 
            SELECT 
                product_id,
                item_code, 
                branch_id, 
                expiry_date,
                quantity_available, 
           
            FROM inventory.product_inventory
            WHERE item_code = $1 
        """ 
        try: 
            pool=await self._db_manager.get_pool(branch_name)
            async with pool.acquire() as conn: 
                row = await conn.fetchrow(sql, item_code) 
                if row: 
                    # تحويل الـ Record إلى Dictionary ثم تمريره لـ Allocation DTO
                    return Allocation(**dict(row)) 
                return None 
        except Exception as e: 
            logger.error( 
                "Branch get_stock failed for item_code='%s' in branch='%s': %s", 
                item_code, branch_name, e, exc_info=True
            ) 
            raise RepositoryError(f"Database error while fetching item {item_code}") from e
# repositories/product_repository.py 
import logging 
from typing import  List,Optional
import asyncpg
from models.models import  Allocation 
from exceptions.exceptions import RepositoryError
from repositories.base import BaseCentralInventoryRepository



logger = logging.getLogger("central_repository") 

class CentralRepository(BaseCentralInventoryRepository): 

    def __init__(self,
                 db_pool: asyncpg.Pool ) -> None: 
            """
            استقبال اسم الفرع وكلاس الـ Pool (مثل AsyncPostgresConnectionPool) 
            وإنشاء نسخة خاصة بالفرع لتجنب تداخل الاتصالات.
            """
            self._db_pool = db_pool
      

    async def get_stock_all_branches(self, item_code: int) -> List[Allocation]: 
        """جلب كمية المخزون من المستودع المركزي لكل الفروع التي تحتوي على المنتج""" 
        sql = """ 
             SELECT 
                product_id,
                item_code, 
                branch_id, 
                expiry_date,
                quantity_available, 
            
            FROM inventory.product_inventory
            WHERE item_code = $1 
            and quantity_available > 0 ;
        """ 
        try: 
            async with self._db_pool.acquire() as conn: 
                rows = await conn.fetch(sql, item_code) 
                if rows: 
                    # تحويل كل صف إلى Allocation DTO وإرجاع القائمة بكل الفروع المتاحة
                    return [Allocation(**dict(row)) for row in rows] 
                return [] 
        except Exception as e: 
            logger.error( 
                "Central get_stock failed for item_code='%s' in branch='%s': %s", 
                item_code, self.branch_name, e, exc_info=True
            ) 
            raise RepositoryError(f"Database error while fetching central stock for item {item_code}") from e
        
    async def get_branch_id(self,branch_name: str) ->Optional[int]:
        sql=" select branch_id from store.branch where branch_name = $1"
        try: 
            async with self._db_pool.acquire() as conn: 
                row = await conn.fetch(sql, branch_name) 
                if row: 
                    # تحويل كل صف إلى Allocation DTO وإرجاع القائمة بكل الفروع المتاحة
                    dicted_row = dict(row)
                    branch_id = dicted_row.get("branch_id","")
                    return branch_id
                return None
        except Exception as e: 
            logger.error( 
                "Central get_stock failed for branch_name='%s' : %s", 
                branch_name,e, exc_info=True
            ) 
            raise RepositoryError(f"Database error while fetching central stock for branch_name {branch_name}") from e   
