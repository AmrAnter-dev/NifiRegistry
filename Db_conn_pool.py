# customer_agent/db/connection.py
"""
إدارة الاتصال بـ PostgreSQL باستخدام Connection Pool.
الهدف: عدم فتح اتصال جديد لكل استعلام (مكلف جداً في بيئة Production)،
بل الاعتماد على Pool مُدار ومشترك بين كل الـ Repositories.
"""
import os
import logging
from contextlib import contextmanager
from psycopg2 import pool
from psycopg2.extras import RealDictCursor

logger = logging.getLogger("db_connection")


class PostgresConnectionPool:
    _instance: "PostgresConnectionPool | None" = None

    def __new__(cls, *args, **kwargs):
        # Singleton: نضمن وجود Pool واحد فقط طوال عمر التطبيق
        if cls._instance is None:
            cls._instance = super().__new__(cls)
        return cls._instance

    def __init__(self, minconn: int = 2, maxconn: int = 10):
        if hasattr(self, "_pool"):
            return  # الـ __init__ اتنفذ قبل كده (Singleton)

        self._pool = pool.ThreadedConnectionPool(
            minconn,
            maxconn,
            host=os.getenv("DB_HOST", "localhost"),
            port=os.getenv("DB_PORT", "5432"),
            dbname=os.getenv("DB_NAME", "customer_agent"),
            user=os.getenv("DB_USER", "postgres"),
            password=os.getenv("DB_PASSWORD", ""),
        )
        logger.info("PostgreSQL connection pool initialized (min=%s, max=%s)", minconn, maxconn)

    @contextmanager
    def get_cursor(self, commit: bool = False):
        """
        Context manager بيرجع Cursor جاهز ويتأكد من إرجاع الاتصال للـ Pool
        حتى لو حصل Exception أثناء الاستعلام.
        """
        conn = self._pool.getconn()
        try:
            cursor = conn.cursor(cursor_factory=RealDictCursor)
            yield cursor
            if commit:
                conn.commit()
        except Exception:
            conn.rollback()
            raise
        finally:
            cursor.close()
            self._pool.putconn(conn)

    def close_all(self):
        self._pool.closeall()
        logger.info("PostgreSQL connection pool closed")


# كائن مشترك يُستخدم في كل الـ Repositories
db_pool = PostgresConnectionPool()
