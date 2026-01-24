# Reference: Value Objects

A Value Object is an object that represents a descriptive aspect of the domain with no conceptual identity. They are defined by their attributes and are treated as immutable.

## Key Characteristics

1.  **Attribute-Based Equality:** Two Value Objects are equal if all their individual attributes are equal. You don't care about *which* instance of a `Money` object you have, only that it represents "$5.00". In Rust, this is typically achieved by deriving the `PartialEq` and `Eq` traits.

2.  **Immutability:** Once a Value Object is created, it should not change. If you need a different value, you create a new instance. This makes them safe to pass around and reason about. In Rust, this means fields are not public and methods that "change" the value actually return a `new` instance.

3.  **No Identity:** They do not have an identifier field like an Entity.

4.  **Self-Validating:** The constructor or factory method for a Value Object should enforce its own invariants. For example, an `EmailAddress` object should not be creatable with an invalid email string.

## Rust Example

Here, `Money` is a Value Object. We don't care about a specific instance of `Money`, only its `amount` and `currency`. Its equality is based on these attributes, and it is immutable.

```rust
// Deriving PartialEq and Eq provides attribute-based equality.
// Deriving Clone allows for easy copying.
#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub enum Currency {
    USD,
    EUR,
}

#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub struct Money {
    amount: i64, // Store in cents to avoid floating point issues
    currency: Currency,
}

impl Money {
    // Factory method that enforces invariants
    pub fn new(amount: i64, currency: Currency) -> Self {
        Self { amount, currency }
    }

    // Methods that perform operations return a *new* instance,
    // preserving immutability.
    pub fn add(&self, other: &Self) -> Result<Self, &'static str> {
        if self.currency != other.currency {
            return Err("Cannot add money of different currencies.");
        }
        Ok(Self::new(self.amount + other.amount, self.currency))
    }

    // Provide read-only access to properties
    pub fn amount(&self) -> i64 {
        self.amount
    }

    pub fn currency(&self) -> &Currency {
        &self.currency
    }
}

// Usage:
// let five_dollars = Money::new(500, Currency::USD);
// let ten_dollars = Money::new(1000, Currency::USD);
//
// // Equality check
// assert_ne!(five_dollars, ten_dollars);
// assert_eq!(five_dollars, Money::new(500, Currency::USD));
//
// // Immutability
// let fifteen_dollars = five_dollars.add(&ten_dollars).unwrap();
// assert_eq!(fifteen_dollars.amount(), 1500);
// assert_eq!(five_dollars.amount(), 500); // Original is unchanged
```
