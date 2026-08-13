import asyncio
import json
from typing import Dict

class TransferEventWaiter:
    def __init__(self):
        # قاموس يحفظ الـ Futures النشطة: { transfer_id: asyncio.Future }
        self._pending_transfers: Dict[str, asyncio.Future] = {}

    async def wait_for_status(self, transfer_id: str, timeout_seconds: int) -> TransferStatus:
        loop = asyncio.get_running_loop()
        future = loop.create_future()
        self._pending_transfers[transfer_id] = future

        try:
            # الانتظار حتى يتم حل الـ Future من دالة الـ Callback أو ينتهي الـ Timeout
            return await asyncio.wait_for(future, timeout=timeout_seconds)
        finally:
            # تنظيف القاموس بعد انتهاء العملية (سواء بنجاح أو Timeout)
            self._pending_transfers.pop(transfer_id, None)

    def notify_status_received(self, transfer_id: str, new_status: TransferStatus):
        # هذه الدالة تناديها الـ Callback عندما يصل الإشعار من الداتا بيز
        if transfer_id in self._pending_transfers:
            future = self._pending_transfers[transfer_id]
            if not future.done():
                future.set_result(new_status)




