# Reference: Domain Services

A Domain Service is used when an operation or a piece of domain logic does not naturally fit within the responsibility of a single Entity or Value Object.

## When to Use a Domain Service

Use a Domain Service when:

1.  **The logic involves multiple domain objects:** For example, transferring money between two `Account` aggregates. This logic doesn't belong to a single `Account`, as it involves both.
2.  **The operation is a significant business process on its own.**
3.  **The logic feels out of place in an Aggregate Root:** Forcing a complex, multi-aggregate operation onto one of the aggregates can bloat it and break the "single responsibility" principle.

## Key Characteristics

1.  **Stateless:** A Domain Service should not have any state of its own. Its purpose is to orchestrate a process and act upon domain objects, not to store data. Any required data should be passed in as method arguments.
2.  **Domain-Centric Language:** The service's interface (its methods and parameters) should be defined purely in terms of the Ubiquitous Language of the domain. It should accept and return domain objects (Aggregates, Entities, Value Objects), not primitive types or data transfer objects.
3.  **Clear Name:** The service should be named after the action it performs (e.g., `FundTransferService`, `InvoiceGenerationService`).

## Rust Example

Imagine a scenario where a discount needs to be calculated based on a `Customer`'s history and a `Product`'s category. This logic might not belong to the `Customer` or the `Product` alone.

```rust
// In the domain layer

// Assuming Customer and Product are defined aggregates
// and Money is a Value Object.
use crate::domain::aggregates::{Customer, Product};
use crate::domain::value_objects::Money;

// The Domain Service is just a struct with an associated function,
// or it could even be a standalone function in a module.
pub struct DiscountService;

impl DiscountService {
    // This is a stateless operation. All required data is passed in.
    // It coordinates logic between Customer and Product.
    pub fn calculate_discount_for(
        &self,
        customer: &Customer,
        product: &Product,
    ) -> Money {
        let mut total_discount = Money::zero(product.price().currency());

        // Example Rule 1: Loyal customers get a 10% discount
        if customer.is_loyal() {
            total_discount = total_discount.add(product.price().percentage(10));
        }

        // Example Rule 2: Certain product categories have a fixed discount
        if product.category() == &ProductCategory::Clearance {
            total_discount = total_discount.add(Money::new(500, product.price().currency())); // $5 fixed discount
        }

        total_discount
    }
}
```
