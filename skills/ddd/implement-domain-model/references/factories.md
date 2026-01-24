# Reference: Factories

A Factory is an object or method responsible for encapsulating the complex logic of creating other objects. In DDD, they are most often used for creating Aggregates and sometimes complex Value Objects.

## When to Use a Factory

1.  **Complex Creation Logic:** When creating an object is more than just a simple `new()` call. The creation might involve setting multiple properties, creating child objects, or consulting other services.
2.  **Hiding Internal Structure:** A Factory can hide the internal implementation details of an Aggregate from the client. The client doesn't need to know how to assemble the Aggregate; it just asks the Factory for one.
3.  **Reconstituting from Persistence:** Factories are crucial for rebuilding an Aggregate from its stored state (e.g., from database rows or a JSON document). This "reconstitution" factory is different from a creation factory, as it typically doesn't run business rules but simply re-establishes the object's last known state.

## Types of Factories

1.  **Factory Method:** A static method directly on the Aggregate Root itself. This is the most common approach for simple creation. The `Order::create(...)` method seen in the Aggregates reference is a Factory Method.

2.  **Factory Service:** A standalone object (a service) that is dedicated to creation. This is useful when the creation process is very complex, requires access to other services (like a Repository or a remote API), or needs to create different types of related objects.

## Rust Example

### 1. Factory Method (Most Common)

This is the preferred approach. The `create` function is a factory method on the `Order` aggregate itself.

```rust
// On the Order Aggregate Root
impl Order {
    // This `create` function is a Factory Method.
    // It encapsulates the logic of creating a valid Order.
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
}
```

### 2. Factory Service (For More Complex Scenarios)

Imagine you are creating a `ForumThread` aggregate, and creating it requires checking if the user is allowed to post in that forum, which requires accessing a `ForumRepository`.

```rust
use std::sync::Arc;

// --- In the domain layer ---

pub trait ForumRepository {
    // ... methods to find a forum
}

pub trait UserRepository {
    // ... methods to find a user
}

// The Factory Service holds dependencies needed for creation
pub struct ThreadFactory {
    forum_repo: Arc<dyn ForumRepository>,
    user_repo: Arc<dyn UserRepository>,
}

impl ThreadFactory {
    pub fn new(forum_repo: Arc<dyn ForumRepository>, user_repo: Arc<dyn UserRepository>) -> Self {
        Self { forum_repo, user_repo }
    }

    pub async fn create_thread(
        &self,
        author_id: UserId,
        forum_id: ForumId,
        title: String,
        content: String,
    ) -> Result<ForumThread, &'static str> {
        
        let forum = self.forum_repo.find_by_id(forum_id).await
            .map_err(|_| "Database error")?
            .ok_or("Forum not found")?;

        let author = self.user_repo.find_by_id(author_id).await
            .map_err(|_| "Database error")?
            .ok_or("Author not found")?;

        // Business rule: Check if the user has permission to post
        if !forum.can_user_post(&author) {
            return Err("User does not have permission to post in this forum.");
        }

        // If all rules pass, create the aggregate
        let thread = ForumThread::new(author_id, forum_id, title, content);
        
        Ok(thread)
    }
}
```
