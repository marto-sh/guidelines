# Ubiquitous Language

The Ubiquitous Language is a shared, well-defined vocabulary used by all team members—developers, domain experts, and stakeholders—within a specific Bounded Context. Its purpose is to eliminate ambiguity and ensure everyone understands the domain concepts in the same way.

## How to Use This Document

This document serves as a living glossary for the Ubiquitous Language within our domain. It should be continuously updated as our understanding of the domain evolves.

- **Define terms clearly**: Each entry should have a precise, unambiguous definition.
- **Include synonyms/antonyms**: Note any common misunderstandings or similar terms to clarify distinctions.
- **Provide examples**: Illustrate how the term is used in context.
- **Identify Bounded Context**: Specify which Bounded Context the term belongs to if the system has multiple contexts.

## Glossary

### Entry Template

```
### [Term]

**Definition**: [A precise and unambiguous explanation of the term.]

**Bounded Context**: [Optional: The specific Bounded Context where this term is valid. E.g., "Order Management", "Customer Support".]

**Synonyms/Related Terms**: [Optional: Other terms that are often confused with this one, or closely related concepts.]

**Examples**: [Optional: Illustrative sentences or scenarios demonstrating the term's usage.]
```

---

### Customer

**Definition**: An individual or entity that purchases or uses our products/services. In the context of our e-commerce platform, a Customer typically has an associated account and order history.

**Bounded Context**: Sales, Order Fulfillment, Customer Service

**Synonyms/Related Terms**: User (more generic), Buyer

**Examples**:

- "The Customer completed their purchase."
- "We need to update the Customer's shipping address."

---

### Order

**Definition**: A request made by a Customer for products or services. An Order has a unique identifier and transitions through various states (e.g., Pending, Confirmed, Shipped, Delivered, Cancelled).

**Bounded Context**: Sales, Order Fulfillment, Inventory

**Synonyms/Related Terms**: Purchase, Transaction

**Examples**:

- "The system created a new Order for the items in the shopping cart."
- "The Order status is currently 'Shipped'."

---

### Product

**Definition**: A distinct item or service offered for sale to Customers. Each Product has a unique SKU (Stock Keeping Unit), price, and description.

**Bounded Context**: Catalog, Inventory, Sales

**Synonyms/Related Terms**: Item, Service Offering

**Examples**:

- "The customer added a Product to their cart."
- "We need to update the price of this Product."
