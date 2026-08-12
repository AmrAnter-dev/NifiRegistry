import asyncio
from contextlib import asynccontextmanager
from redis.asyncio import Redis

class RedisLockManager:
    def __init__(self, redis_client: Redis):
        self.redis = redis_client

    @asynccontextmanager
    async def acquire_lock(self, lock_key: str, timeout_seconds: int = 10, retry_interval: float = 0.1):
        """
        حجز قفل موزع لقيمة معينة.
        """
        identifier = f"lock:{lock_key}"
        acquired = False
        
        # محاولة الحصول على القفل بمهلة زمنية
        try:
            while not acquired:
                # set with NX (Only set if not exists) and EX (Expiration in seconds)
                acquired = await self.redis.set(identifier, "locked", ex=timeout_seconds, nx=True)
                if acquired:
                    break
                await asyncio.sleep(retry_interval)
                
            yield acquired
            
        finally:
            if acquired:
                # فك القفل بعد الانتهاء
                await self.redis.delete(identifier)
