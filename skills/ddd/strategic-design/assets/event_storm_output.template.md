# Event Storming Output

This document captures the output of a text-based Event Storming session.

## 1. Domain Events

*List all significant business events that occur in the system. Use past tense.*

- OrderPlaced
- PaymentProcessed
- OrderShipped
- ItemAddedToCart
- CustomerRegistered

## 2. Commands

*For each event, list the command that triggered it.*

- **PlaceOrder** -> OrderPlaced
- **ProcessPayment** -> PaymentProcessed
- **ShipOrder** -> OrderShipped
- **AddItemToCart** -> ItemAddedToCart
- **RegisterCustomer** -> CustomerRegistered

## 3. Aggregates

*Group events and commands around the business object (Aggregate) they apply to. This helps identify consistency boundaries.*

- **Order Aggregate**
  - Events: OrderPlaced, OrderShipped
  - Commands: PlaceOrder, ShipOrder
- **Cart Aggregate**
  - Events: ItemAddedToCart
  - Commands: AddItemToCart
- **Customer Aggregate**
  - Events: CustomerRegistered
  - Commands: RegisterCustomer

## 4. Emergent Bounded Contexts

*Look for natural groupings or seams in the event timeline. These often represent different business capabilities and can become your Bounded Contexts.*

- **Sales / Ordering Context**
  - Aggregates: Order, Cart
- **Customer Management Context**
  - Aggregates: Customer
- **Shipping / Fulfillment Context**
  - Aggregates: Order (A different view of Order, focused on shipping details)
