# Reference: Aggregates

An Aggregate is a cluster of domain objects (Entities and Value Objects) that can be treated as a single unit. It forms a transactional consistency boundary. The `Aggregate Root` is a specific entity within the aggregate that acts as the sole entry point for any modification to the objects inside it.

## Key Rules of an Aggregate

1.  **The Root is a Global Entity:** The Aggregate Root has a globally unique identity. Internal entities have identities that are only unique within the Aggregate.

2.  **Protect Business Invariants:** The primary job of an Aggregate is to enforce business rules (invariants) across all the objects within its boundary. For example, in an `Order` aggregate, the root can ensure the total number of line items does not exceed a certain limit.

3.  **Reference Other Aggregates by ID Only:** An object inside one aggregate should not hold a direct object reference to another aggregate's root. Instead, it should hold a reference to the other aggregate's ID. This helps maintain decoupling and avoids large, tangled object graphs.

    ```pseudocode
    // GOOD: Reference by ID
    class Order {
      private CustomerId customerId;
    }

    // BAD: Direct object reference
    class Order {
      private Customer customer; // This pulls the entire Customer object into memory
    }
    ```

4.  **Access is Through the Root Only:** External objects are only allowed to hold a reference to the Aggregate Root. They cannot access the internal entities of the aggregate directly. This allows the root to maintain control and enforce its invariants.

5.  **One Transaction per Aggregate:** All changes to any object within a single Aggregate boundary should be committed in a single transaction. This ensures that the aggregate is always in a consistent state.

## Rust Example

```rust
use uuid::Uuid;

// The Aggregate Root
pub struct Order {
    id: OrderId,
    customer_id: CustomerId,
    line_items: Vec<LineItem>,
    // other fields...
}

// Public-facing behavior
impl Order {
    // 1. Factory for creation, enforcing invariants
    pub fn create(customer_id: CustomerId) -> Result<Self, &'static str> {
        if customer_id.is_nil() {
            return Err("An order must have a valid customer.");
        }
        Ok(Self {
            id: OrderId(Uuid::new_v4()),
            customer_id,
            line_items: Vec::new(),
        })
    }

    // 2. Behavior method that modifies internal state
    pub fn add_line_item(&mut self, product_id: ProductId, price: Money, quantity: u32) -> Result<(), &'static str> {
        if self.line_items.len() >= 10 {
            return Err("An order cannot have more than 10 line items.");
        }
        if quantity == 0 {
            return Err("Cannot add a line item with zero quantity.");
        }

        let new_item = LineItem::new(self.id, product_id, price, quantity);
        self.line_items.push(new_item);
        // self.recalculate_totals();
        // self.add_domain_event(LineItemAdded { ... });
        Ok(())
    }

    // Read-only access to properties
    pub fn id(&self) -> OrderId {
        self.id
    }

    pub fn line_items(&self) -> &Vec<LineItem> {
        &self.line_items
    }
}

// The internal Entity
#[derive(Debug, PartialEq, Eq)]
pub struct LineItem {
    id: LineItemId,
    order_id: OrderId, // Reference back to the root
    product_id: ProductId,
    price: Money,
    quantity: u32,
}

impl LineItem {
    // Constructor is internal to the crate (`pub(crate)`)
    // It can only be called by the Order aggregate root.
    pub(crate) fn new(order_id: OrderId, product_id: ProductId, price: Money, quantity: u32) -> Self {
        Self {
            id: LineItemId(Uuid::new_v4()),
            order_id,
            product_id,
            price,
            quantity,
        }
    }
}

// Example ID types (Value Objects)
#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub struct OrderId(Uuid);

#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub struct CustomerId(Uuid);

impl CustomerId {
    pub fn is_nil(&self) -> bool {
        self.0.is_nil()
    }
}


#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub struct ProductId(Uuid);

#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub struct LineItemId(Uuid);

#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub struct Money(i64); // Representing money in cents
```
