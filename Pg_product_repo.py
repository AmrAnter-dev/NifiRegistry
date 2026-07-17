# customer_agent/repositories/postgres_product_repository.py
"""
التطبيق الفعلي لـ BaseProductRepository باستخدام PostgreSQL.
يفترض الـ Schema التالي (راجع sql/schema.sql):

    products(product_id TEXT PK, name TEXT, price NUMERIC)
    stock(product_id TEXT FK, quantity INT)

الاعتماد على db_pool المشترك بدل فتح اتصال منفصل لكل Repository.
"""
import logging
from typing import List, Dict, Any, Optional

from repositories.base import BaseProductRepository
from db.connection import db_pool

logger = logging.getLogger("postgres_product_repository")


class PostgresProductRepository(BaseProductRepository):
    def search_by_name(self, query: str) -> List[Dict[str, Any]]:
        """
        بحث بالاسم باستخدام ILIKE (case-insensitive) مع حد أقصى للنتائج
        لتفادي إرجاع آلاف الصفوف للـ LLM.
        """
        sql = """
            SELECT product_id, name, price
            FROM products
            WHERE name ILIKE %s
            ORDER BY name
            LIMIT 20
        """
        try:
            with db_pool.get_cursor() as cur:
                cur.execute(sql, (f"%{query}%",))
                rows = cur.fetchall()
                return [dict(row) for row in rows]
        except Exception as e:
            logger.error("search_by_name failed for query='%s': %s", query, e)
            return []

    def get_stock(self, product_id: str) -> Optional[int]:
        sql = """
            SELECT quantity
            FROM stock
            WHERE product_id = %s
        """
        try:
            with db_pool.get_cursor() as cur:
                cur.execute(sql, (product_id,))
                row = cur.fetchone()
                return row["quantity"] if row else None
        except Exception as e:
            logger.error("get_stock failed for product_id='%s': %s", product_id, e)
            return None
