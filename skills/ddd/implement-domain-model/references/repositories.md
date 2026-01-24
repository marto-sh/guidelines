# Reference: Repositories

A Repository is an object that mediates between the domain layer and the data mapping (persistence) layers. It provides a "collection-like" interface for accessing domain objects, hiding the complexities of the database from the domain model.

## Key Principles

1.  **The Interface Belongs to the Domain:** The repository's contract (the `trait` in Rust) is defined in the domain layer. It dictates the methods the domain needs to find and store its aggregates.

2.  **The Implementation is Infrastructure:** The concrete implementation of the repository `trait` is an infrastructure concern. It lives outside the domain layer (e.g., in a separate `infrastructure` or `persistence` crate). This is how the domain remains pure and decoupled from specific database technologies.

3.  **Operate on Aggregates:** Repositories should only work with Aggregate Roots. You should not have a repository for an internal entity of an aggregate (e.g., no `LineItemRepository`). The methods should return and accept whole aggregates.

4.  **Emulate a Collection:** The naming of methods should be simple and reflect the idea of a collection (e.g., `add`, `get`, `remove`).

5.  **Don't Expose Database Concerns:** The repository interface should not expose any implementation details. Methods should not return a `Result` that leaks database-specific error types. The implementation should handle the mapping of database errors to domain-specific errors.

## Rust Example

Here, the `OrderRepository` trait is defined in the domain. The actual `PostgresOrderRepository` would be implemented in another crate.

```rust
use uuid::Uuid;
// --- In the `domain` crate ---

// Assuming Order and OrderId are defined in the domain
use crate::domain::aggregates::{Order, OrderId};
use crate::domain::errors::DomainError;

// This trait is the contract defined by the domain.
// It knows nothing about SQL, databases, or ORMs.
#[async_trait] // Using async_trait for async methods in traits
pub trait OrderRepository {
    async fn find_by_id(&self, id: OrderId) -> Result<Option<Order>, DomainError>;
    async fn save(&self, order: &Order) -> Result<(), DomainError>;
    async fn delete(&self, id: OrderId) -> Result<(), DomainError>;
}


// --- In the `infrastructure` crate ---

// use crate::domain::OrderRepository;
// use crate::domain::aggregates::{Order, OrderId};
// use crate::domain::errors::DomainError;
// use sqlx::PgPool; // Example using sqlx for PostgreSQL

// pub struct PostgresOrderRepository {
//     pool: PgPool,
// }

// impl PostgresOrderRepository {
//     pub fn new(pool: PgPool) -> Self {
//         Self { pool }
//     }
// }

// #[async_trait]
// impl OrderRepository for PostgresOrderRepository {
//     async fn find_by_id(&self, id: OrderId) -> Result<Option<Order>, DomainError> {
//         // Logic to query PostgreSQL and map rows to an Order aggregate.
//         // Map sqlx::Error to DomainError.
//         // ...
//         unimplemented!()
//     }

//     async fn save(&self, order: &Order) -> Result<(), DomainError> {
//         // Logic to perform an INSERT or UPDATE in PostgreSQL.
//         // Map sqlx::Error to DomainError.
//         // ...
//         unimplemented!()
//     }

//     async fn delete(&self, id: OrderId) -> Result<(), DomainError> {
//         // Logic to perform a DELETE in PostgreSQL.
//         // ...
//         unimplemented!()
//     }
// }
```
