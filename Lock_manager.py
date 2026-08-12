import asyncio
import uuid
from contextlib import asynccontextmanager
from redis.asyncio import Redis


class LockAcquisitionError(Exception):
    """يتم رفع هذا الاستثناء عندما يتطابق طلبان في نفس الوقت ويرفض القفل الطلب الثاني"""

    pass


class RedisLockManager:

    def __init__(self, redis_client: Redis):
        self.redis = redis_client

    @asynccontextmanager
    async def acquire_lock(
        self,
        lock_key: str,
        timeout_seconds: int = 10,
        wait_timeout: float = 2.0,
        retry_interval: float = 0.1,
    ):
        identifier = f"lock:{lock_key}"
        token = str(uuid.uuid4())  # المعرف الفريد للمالك الحالي للقفل
        acquired = False
        start_time = asyncio.get_running_loop().time()

        try:
            while not acquired:
                acquired = await self.redis.set(
                    identifier, token, ex=timeout_seconds, nx=True
                )
                if acquired:
                    break

                # التحقق من انتهاء وقت الانتظار لمنع الـ Infinite Loop
                if (
                    asyncio.get_running_loop().time() - start_time
                ) >= wait_timeout:
                    raise LockAcquisitionError(
                        "Could not acquire lock due to concurrent requests."
                    )

                await asyncio.sleep(retry_interval)

            yield acquired

        finally:
            if acquired:
                # Lua Script لضمان عدم حذف قفل ممتلك من قبل طلب آخر
                release_script = """
                if redis.call("get", KEYS[1]) == ARGV[1] then
                    return redis.call("del", KEYS[1])
                else
                    return 0
                end
                """
                await self.redis.eval(release_script, 1, identifier, token)
