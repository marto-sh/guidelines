# Reference: Entities

An Entity is an object defined not by its attributes, but by its thread of continuity and identity. It has a unique identifier and a lifecycle; its properties can change over time, but it remains the "same" object.

## Key Characteristics

1.  **Identity:** An Entity has an identifier that is unique within a certain context.
    *   **Global Identity:** For Aggregate Roots, the ID must be globally unique.
    *   **Local Identity:** For entities that live inside an Aggregate, the ID only needs to be unique within that Aggregate's boundary.

2.  **Mutability:** Unlike Value Objects, the attributes of an Entity are expected to change over its lifecycle. An `Order` entity might have its status change from `PENDING` to `SHIPPED`.

3.  **Lifecycle:** Entities are created, modified, and can be removed. Their identity, however, persists through these changes.

## Entity vs. Value Object

This is one of the most fundamental decisions in tactical modeling.

| Feature         | Entity                                      | Value Object                               |
|-----------------|---------------------------------------------|--------------------------------------------|
| **Identity**    | Has a unique identifier (e.g., `CustomerId`) | No identity                                |
| **Equality**    | Based on its identifier                     | Based on the value of its attributes       |
| **Mutability**  | Mutable (its state can change)              | Immutable (its state cannot change)        |
| **Represents**  | A "thing" with continuity                   | A descriptive characteristic or attribute  |
| **Example**     | `Customer`, `Product`, `Order`              | `Money`, `Address`, `DateRange`            |

## Rust Example

In this example, `User` is an Entity. We care *which* user we are talking about, and their name can change over time. Its equality is based only on its `id`.

```rust
use uuid::Uuid;

#[derive(Debug, Clone)]
pub struct UserId(Uuid);

// The User Entity
#[derive(Debug)]
pub struct User {
    id: UserId,
    name: String,
    email: String, // In a real scenario, this would likely be a Value Object
}

impl User {
    // Constructor
    pub fn new(id: UserId, name: String, email: String) -> Self {
        Self { id, name, email }
    }

    // Behavior that changes the entity's state
    pub fn change_name(&mut self, new_name: String) -> Result<(), &'static str> {
        if new_name.is_empty() {
            return Err("Name cannot be empty.");
        }
        self.name = new_name;
        Ok(())
    }

    // Read-only access to the ID
    pub fn id(&self) -> &UserId {
        &self.id
    }
}

// Equality is based on ID, not other attributes.
// This needs to be implemented manually; deriving `PartialEq` would compare all fields.
impl PartialEq for User {
    fn eq(&self, other: &Self) -> bool {
        self.id.0 == other.id.0
    }
}

impl Eq for User {}
```
