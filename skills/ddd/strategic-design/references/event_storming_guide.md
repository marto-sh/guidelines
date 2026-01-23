# Reference: Event Storming Guide

Event Storming is a collaborative workshop created by Alberto Brandolini for quickly exploring a complex business domain. It's a powerful tool for strategic design that brings together developers and business experts.

This guide describes a simplified, text-based approach suitable for an agent-assisted workflow.

## The Process

### 1. Brainstorm Domain Events

- **What it is:** A Domain Event is a significant business event that has already happened. It should always be phrased in the past tense.
- **How to do it:** Start by asking "What is the most important thing that happens in our system?". List everything that comes to mind.
- **Examples:**
  - `OrderPlaced`
  - `PaymentDeclined`
  - `CustomerMovedToPremiumTier`
  - `StockReservedForItem`

### 2. Identify Commands

- **What it is:** A Command is an action or request from a user or another system that triggers a Domain Event.
- **How to do it:** For each event, ask "What action caused this event to happen?".
- **Examples:**
  - `PlaceOrder` -> `OrderPlaced`
  - `ProcessPayment` -> `PaymentDeclined`
  - `ReviewCustomerSpending` -> `CustomerMovedToPremiumTier`

### 3. Group by Aggregate

- **What it is:** An Aggregate is the business object that a command is directed at and that an event relates to. It's the "thing" that changes.
- **How to do it:** Look at the commands and events and group them by the noun they operate on. For example, `PlaceOrder` and `OrderPlaced` both operate on an **Order**. This "Order" is a candidate for an Aggregate.
- **Example Groupings:**
  - **Order Aggregate:** `PlaceOrder`, `OrderPlaced`, `ShipOrder`, `OrderShipped`
  - **Customer Aggregate:** `RegisterCustomer`, `CustomerRegistered`, `ReviewCustomerSpending`, `CustomerMovedToPremiumTier`

### 4. Identify Emergent Bounded Contexts

- **What it is:** A Bounded Context is a boundary within which a particular domain model is consistent.
- **How to do it:** Look at the timeline of events and the groups of aggregates. Where do natural seams or transitions occur? Often, different parts of the business (e.g., Sales, Shipping, Billing) will emerge as distinct contexts.
  - A "Product" in the "Sales" context might be a catalog item.
  - A "Product" in the "Inventory" context might be a physical item in a warehouse.
- This is a sign that "Sales" and "Inventory" are separate Bounded Contexts.

## Benefits

- **Fast:** Quickly builds a shared understanding of the domain.
- **Collaborative:** Breaks down silos between technical and business people.
- **Engaging:** The visual and kinetic nature of a real workshop is highly engaging.
- **Focus on Business:** It forces the conversation to be about business processes, not technical solutions.
