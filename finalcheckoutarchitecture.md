                    ┌──────────────────────┐
                    │    CheckoutService   │
                    │     Orchestrator     │
                    └──────────┬───────────┘
                               │
                               ▼
                    ShoppingCartService
                               │
                               ▼
                           Cart Items
                               │
                    asyncio.gather()
                               │
                               ▼
                    ┌──────────────────────┐
                    │   TransferService   │
                    └──────────┬───────────┘
                               │
             ┌─────────────────┼─────────────────┐
             ▼                 ▼                 ▼
      InventoryService   BranchService    TransferRepository
             │                 │
             │                 ▼
             │              PostGIS
             │
             ▼
       Stock Allocations
             │
             ▼
    Eligible Branch IDs
             │
             ▼
    Nearest Eligible Branch
             │
             ▼
       Create Transfer
             │
             ▼
    Debezium / CDC Events
             │
             ▼
       Wait 15 minutes
             │
        ┌────┴────┐
        │         │
    Fulfilled   Timeout
        │         │
        │         ▼
        │      Next Branch
        │         │
        │      15 minutes
        │         │
        │         ▼
        │      Warehouse
        │
        └─────────┬──────────────┐
                  ▼              ▼
              Fulfilled        Failed
                                  │
                                  ▼
                         RecommendationEngine
                                  │
                                  ▼
                           Customer Decision
                                  │
                     ┌────────────┴────────────┐
                     ▼                         ▼
              Separate Shipment           Wait For All
                     │                         │
                     └────────────┬────────────┘
                                  ▼
                             OrderService
