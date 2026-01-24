# Tactical DDD Patterns

This directory contains reference materials for the tactical patterns of Domain-Driven Design (DDD). These patterns provide the building blocks for creating a rich, expressive domain model that is aligned with the business.

## Core Patterns

- **[Value Objects](./value_objects.md):** Simple, immutable objects that describe a characteristic of the domain. Their equality is based on their value, not their identity (e.g., `Money`, `Address`).

- **[Entities](./entities.md):** Objects that have a distinct identity that remains the same throughout the lifecycle of the object, even as its attributes change (e.g., a `Customer` with a unique ID).

- **[Aggregates](./aggregates.md):** A cluster of related objects (Entities and Value Objects) that are treated as a single unit of consistency. The `Aggregate Root` is the single entry point to the cluster.

- **[Repositories](./repositories.md):** Provide the illusion of an in-memory collection of Aggregates, separating the domain model from persistence concerns.

- **[Domain Services](./domain_services.md):** Operations or logic that do not naturally fit within an Entity or Value Object. They are typically stateless.

- **[Factories](./factories.md):** Encapsulate the logic for creating complex objects or Aggregates, ensuring that clients do not need to know the intricate details of object creation.

- **[Behavior-Driven Development](./bdd/README.md):** A methodology for defining and testing the behavior of the domain model from the outside-in.
