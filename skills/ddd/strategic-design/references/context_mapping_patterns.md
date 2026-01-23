# Reference: Context Mapping Patterns

A Context Map is a document that shows the relationships between different Bounded Contexts. Defining these relationships is critical for managing team dependencies and ensuring data flows correctly and consistently across the system.

## Key Patterns

### Upstream / Downstream

This is the basic vocabulary for a relationship. The **Upstream** context is the one that influences or provides services to another. The **Downstream** context is the one that is influenced by or consumes services from another.

---

### Patterns for Collaboration

1.  **Partnership:**
    - Two contexts/teams are mutually dependent and must work together to succeed. They rise and fall together.
    - **Use when:** The success of a single feature requires coordinated changes in both contexts.

2.  **Shared Kernel:**
    - Two or more contexts share a small, common subset of the domain model (e.g., a library of shared Value Objects).
    - **Use with caution:** This creates tight coupling. The shared code should be very stable and well-tested, and changes must be coordinated between the teams.

### Patterns for Consumption

3.  **Customer-Supplier:**
    - An Upstream team provides a "product" or service to a Downstream team (the "customer"). The Downstream team has influence and can make requests, but the Upstream team has the final say and manages their own priorities.
    - **Use when:** One context serves the needs of another, but must also serve other contexts or its own needs.

4.  **Conformist:**
    - A Downstream context blindly conforms to the model of an Upstream context. The downstream team has little to no influence over the upstream model.
    - **Use when:** The upstream model is from a large, well-established team or a third-party vendor, and it's not worth the cost of building a translation layer.

5.  **Anti-Corruption Layer (ACL):**
    - A Downstream context builds a defensive layer to protect its own model from being "corrupted" by the model of an Upstream context. The ACL acts as a translator, converting the upstream model into a format that makes sense for the downstream domain.
    - **Use when:** The upstream model is messy, complex, or doesn't align with your own domain's needs. This is a very common and valuable pattern for integrating with legacy systems or external APIs.

### Other Patterns

6.  **Separate Ways:**
    - The two contexts have no connection and no dependency. They are completely separate.
    - **Use when:** There is no business reason for the two contexts to integrate.

7.  **Open Host Service (OHS):**
    - An Upstream context defines a clear, well-documented API (the "host service") for other contexts to consume. This is the foundation of a microservices architecture.
    - The API is "open" in that it's designed to be used by any authorized consumer.
