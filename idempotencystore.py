import json
import uuid
from typing import Any, Awaitable, Callable, Optional

from redis.asyncio import Redis


# ============================================================
# Exceptions
# ============================================================

class DuplicateExecutionError(Exception):
    """
    العملية اتنفذت قبل كده.
    النتيجة الأصلية موجودة في .result
    """

    def __init__(self, result: Any):
        self.result = result
        super().__init__("Operation already completed.")


class ExecutionInProgressError(Exception):
    """
    نفس العملية قيد التنفيذ حاليًا بواسطة request آخر.
    """

    pass


class IdempotencyOwnershipError(Exception):
    """
    الـexecution الحالي لم يعد مالكًا للـidempotency key.
    """

    pass


# ============================================================
# Idempotency Store
# ============================================================

class IdempotencyStore:

    def __init__(
        self,
        redis_client: Redis,
        default_result_ttl: int = 86400,  # 24 hours
        default_lock_ttl: int = 60,
    ):
        self.redis = redis_client
        self.default_result_ttl = default_result_ttl
        self.default_lock_ttl = default_lock_ttl

        # ----------------------------------------------------
        # Atomic COMPLETE
        #
        # لا يحدث complete إلا لو الـtoken الحالي
        # هو نفس token صاحب العملية.
        # ----------------------------------------------------

        self._complete_script = self.redis.register_script(
            """
            local current = redis.call("GET", KEYS[1])

            if not current then
                return -1
            end

            local data = cjson.decode(current)

            if data["status"] ~= "IN_PROGRESS" then
                return -2
            end

            if data["token"] ~= ARGV[1] then
                return -3
            end

            local result = ARGV[2]
            local ttl = ARGV[3]

            local payload = cjson.encode({
                status = "COMPLETED",
                result = cjson.decode(result)
            })

            redis.call("SET", KEYS[1], payload, "EX", ttl)

            return 1
            """
        )

        # ----------------------------------------------------
        # Atomic FAIL
        #
        # لا يتم حذف الـkey إلا لو الـtoken
        # ما زال مالك العملية.
        # ----------------------------------------------------

        self._fail_script = self.redis.register_script(
            """
            local current = redis.call("GET", KEYS[1])

            if not current then
                return 0
            end

            local data = cjson.decode(current)

            if data["status"] ~= "IN_PROGRESS" then
                return -2
            end

            if data["token"] ~= ARGV[1] then
                return -3
            end

            redis.call("DEL", KEYS[1])

            return 1
            """
        )

    # ========================================================
    # Key
    # ========================================================

    @staticmethod
    def _get_key(key: str) -> str:
        return f"idempotency:{key}"

    # ========================================================
    # Check
    # ========================================================

    async def check(self, key: str) -> Optional[dict]:

        data = await self.redis.get(
            self._get_key(key)
        )

        if not data:
            return None

        if isinstance(data, bytes):
            data = data.decode("utf-8")

        return json.loads(data)

    # ========================================================
    # Start
    # ========================================================

    async def start(
        self,
        key: str,
        lock_ttl: Optional[int] = None,
    ) -> Optional[str]:

        full_key = self._get_key(key)

        token = str(uuid.uuid4())

        payload = json.dumps({
            "status": "IN_PROGRESS",
            "token": token,
        })

        ttl = (
            lock_ttl
            if lock_ttl is not None
            else self.default_lock_ttl
        )

        acquired = await self.redis.set(
            full_key,
            payload,
            nx=True,
            ex=ttl,
        )

        if not acquired:
            return None

        return token

    # ========================================================
    # Complete
    # ========================================================

    async def complete(
        self,
        key: str,
        token: str,
        result: Any,
        result_ttl: Optional[int] = None,
    ) -> None:

        full_key = self._get_key(key)

        ttl = (
            result_ttl
            if result_ttl is not None
            else self.default_result_ttl
        )

        result_json = json.dumps(
            result,
            default=str,
        )

        result_code = await self._complete_script(
            keys=[full_key],
            args=[
                token,
                result_json,
                ttl,
            ],
        )

        if result_code == -1:
            raise IdempotencyOwnershipError(
                "Idempotency key no longer exists."
            )

        if result_code == -2:
            raise IdempotencyOwnershipError(
                "Operation is no longer IN_PROGRESS."
            )

        if result_code == -3:
            raise IdempotencyOwnershipError(
                "This execution no longer owns the idempotency key."
            )

    # ========================================================
    # Fail
    # ========================================================

    async def fail(
        self,
        key: str,
        token: str,
    ) -> None:

        full_key = self._get_key(key)

        result_code = await self._fail_script(
            keys=[full_key],
            args=[token],
        )

        if result_code == -3:
            # Execution قديم ولم يعد owner
            return

        if result_code == -2:
            # العملية اتقفلت بالفعل
            return

    # ========================================================
    # Execute
    # ========================================================

    async def execute(
        self,
        key: str,
        operation: Callable[[], Awaitable[Any]],
        lock_ttl: Optional[int] = None,
        result_ttl: Optional[int] = None,
    ) -> Any:

        # ----------------------------------------------------
        # 1. Check existing operation
        # ----------------------------------------------------

        existing = await self.check(key)

        if existing:

            status = existing.get("status")

            if status == "COMPLETED":
                raise DuplicateExecutionError(
                    existing.get("result")
                )

            if status == "IN_PROGRESS":
                raise ExecutionInProgressError(
                    "Operation is already in progress."
                )

        # ----------------------------------------------------
        # 2. Atomic start
        # ----------------------------------------------------

        token = await self.start(
            key=key,
            lock_ttl=lock_ttl,
        )

        if token is None:

            # حصل race condition:
            # request آخر سبقنا وعمل start

            existing = await self.check(key)

            if existing:

                if existing.get("status") == "COMPLETED":
                    raise DuplicateExecutionError(
                        existing.get("result")
                    )

                if existing.get("status") == "IN_PROGRESS":
                    raise ExecutionInProgressError(
                        "Operation is already in progress."
                    )

            raise ExecutionInProgressError(
                "Another execution is already processing this operation."
            )

        # ----------------------------------------------------
        # 3. Execute business operation
        # ----------------------------------------------------

        try:

            result = await operation()

        except Exception:

            # يسمح بإعادة المحاولة
            await self.fail(
                key=key,
                token=token,
            )

            raise

        # ----------------------------------------------------
        # 4. Save result atomically
        # ----------------------------------------------------

        await self.complete(
            key=key,
            token=token,
            result=result,
            result_ttl=result_ttl,
        )

        return result
