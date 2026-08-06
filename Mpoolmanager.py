from __future__ import annotations

import asyncio
from dataclasses import dataclass

import asyncpg


@dataclass(frozen=True, slots=True)
class BranchDBConfig:
    host: str
    port: int
    database: str
    user: str
    password: str


class BranchDBManager:

    def __init__(
        self,
        configs: dict[str, BranchDBConfig],
    ) -> None:
        self._configs = configs
        self._pools: dict[str, asyncpg.Pool] = {}

        # Prevent two concurrent requests from creating
        # two pools for the same branch.
        self._lock = asyncio.Lock()

    async def get_pool(
        self,
        branch_name: str,
    ) -> asyncpg.Pool:

        # Fast path
        pool = self._pools.get(branch_name)

        if pool is not None:
            return pool

        # Slow path
        async with self._lock:

            # Double-check after acquiring the lock.
            pool = self._pools.get(branch_name)

            if pool is not None:
                return pool

            config = self._configs.get(branch_name)

            if config is None:
                raise ValueError(
                    f"Unknown branch: {branch_name!r}"
                )

            pool = await asyncpg.create_pool(
                host=config.host,
                port=config.port,
                database=config.database,
                user=config.user,
                password=config.password,
                min_size=1,
                max_size=5,
            )

            self._pools[branch_name] = pool

            return pool
        async def close_all(self) -> None:
      """Close all created connection pools gracefully on application shutdown."""
     


          async with self._lock:
               for branch_name, pool in self._pools.items():
                  await pool.close()
                   self._pools.clear()
