# Reference: Bounded Contexts

A Bounded Context is a central pattern in strategic DDD. It is a conceptual boundary within which a specific domain model is defined and consistent. Inside a bounded context, every term in the Ubiquitous Language has a specific, unambiguous meaning.

## Why Use Bounded Contexts?

1.  **Clarity and Precision:** The primary purpose is to eliminate ambiguity. For example, the word "Product" can mean very different things across a large business:
    *   In the **Sales Context**, a Product might be a catalog item with a price and description.
    *   In the **Inventory Context**, a Product might be a physical item with a location and stock level.
    *   In the **Shipping Context**, a Product might be an object with weight and dimensions.

    Instead of creating one giant, confusing "Product" class with dozens of optional fields, DDD advises creating three separate `Product` models, each consistent within its own Bounded Context.

2.  **Team Autonomy:** Bounded Contexts are often aligned with team organization. The "Sales" team can own and develop the "Sales" context model without needing to constantly coordinate with the "Inventory" team, as long as the integration between the contexts is clearly defined.

3.  **Model Integrity:** It prevents concepts from one part of the business from "leaking" into and corrupting the model of another part of the business. Each model can be optimized for its specific purpose.

## Identifying Bounded Contexts

- **Look for Language Differences:** When you hear a single term being used with different meanings by different people, that's a strong hint that you have multiple contexts.
- **Follow Organizational Seams:** How are the business departments and teams structured? Often, these align with bounded contexts.
- **Analyze Business Capabilities:** What are the distinct things the business *does*? "Marketing," "Sales," "Fulfillment," and "Support" are all business capabilities that are strong candidates for Bounded Contexts.
- **Event Storming:** The Event Storming process is an excellent way to discover emergent bounded contexts by looking for clusters of related events and aggregates.

Once you have identified your Bounded Contexts, the next step is to define the relationships between them using a **Context Map**.
