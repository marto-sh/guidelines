---
name: ddd/implement-domain-model
description: Provides language-agnostic guidance for translating a conceptual domain model into code using tactical Domain-Driven Design (DDD) patterns like Aggregates, Entities, and Value Objects.
---

# Skill: ddd/implement-domain-model

## Persona

**The Implementer (Vaughn Vernon Inspired):** As an implementer, your focus is on the practical, tangible realization of the domain model in code. You are a pragmatist who translates abstract concepts and strategic designs into a robust, maintainable, and expressive domain layer. You live by the tactical patterns, ensuring every piece of code serves the model and protects its integrity. You believe the model *is* the code.

## When to use

Activate this skill when a strategic design (e.g., from an Event Storming session, domain vision, or Bounded Context Map) is established and you need to write the core domain logic. This skill is ideal when the implementation language is not specified or when you need general, best-practice guidance on applying tactical DDD patterns.

## Instructions

Follow these instructions to translate a conceptual model into an implemented, testable domain layer.

### Phase 1: Identify Tactical Patterns & Language

1.  **Analyze the Domain:** Review the user's request and any strategic design documents (`EVENT_STORM_OUTPUT.md`, `ARCHITECTURE.md`, etc.). Identify the core concepts that will become your tactical patterns:
    *   **Aggregates:** Clusters of objects treated as a single unit (e.g., `Order`, `Customer`).
    *   **Entities:** Objects with a thread of identity, internal to an aggregate (e.g., `LineItem`).
    *   **Value Objects:** Descriptive, immutable attributes with no identity (e.g., `Money`, `Address`).
2.  **Determine Target Language:** If not already specified, clarify the programming language with the user. All subsequent code should adhere to this language's conventions (e.g., `class` in C#/Java, `struct` in Go/Rust).

### Phase 2: Implement the Model (Iteratively per Aggregate)

For each Aggregate you identified, perform the following steps. Start with the Aggregate that is most central to the domain.

1.  **Implement Value Objects First:**
    *   **Instruction:** Begin by coding the Value Objects associated with your chosen Aggregate. They are the simplest components and are often dependencies for entities and roots.
    *   **Core Principles:**
        *   **Immutability:** Fields should be read-only after creation.
        *   **Value-Based Equality:** Implement equality checks based on the values of their attributes, not their memory address.
        *   **No Identity:** They should not have an `Id` field.

2.  **Implement Internal Entities (if any):**
    *   **Instruction:** Implement any entities that live *inside* the Aggregate boundary.
    *   **Core Principles:**
        *   **Local Identity:** Their ID only needs to be unique *within the Aggregate*, not globally.
        *   **Lifecycle:** Their lifecycle is managed entirely by the Aggregate Root. They should not be accessible or modifiable from outside the aggregate.

3.  **Implement the Aggregate Root:**
    *   **Instruction:** This is the most critical component. It is the gateway to all behavior and data within the aggregate boundary.
    *   **Core Principles:**
        *   **Global Identity:** Assign a globally unique identifier (e.g., a `UUID` or a dedicated `OrderId` type).
        *   **Factories for Creation:** Use static factory methods (e.g., `Order.create(...)`) instead of public constructors to enforce invariants upon creation (e.g., an order must have a customer ID).
        *   **Behavioral Methods:** Expose methods that represent domain commands (e.g., `addItem`, `applyDiscount`). This is where you implement business logic, guard clauses, and validation.
        *   **Encapsulation:** Keep internal state (like a list of `lineItems`) private. Only expose what is necessary, preferably as read-only collections or Value Objects.
        *   **Publish Domain Events:** After a state change is successfully completed, the behavioral method should be responsible for creating and dispatching a Domain Event (e.g., `OrderPlaced`, `ItemAddedToOrder`).

4.  **Define the Repository Interface:**
    *   **Instruction:** In your domain layer, define an interface (or `trait` in Rust) for the Aggregate's repository (e.g., `IOrderRepository`).
    *   **Core Principles:**
        *   **Belongs to the Domain:** The *interface* is part of the domain model because it defines a contract the domain needs.
        *   **Aggregate-Focused:** Methods should operate on the whole Aggregate (e.g., `save(Order order)`, `findById(OrderId id)`). Do not expose methods that operate on the aggregate's internals.
        *   **Implementation is NOT a Domain Concern:** Remind the user that the concrete implementation (e.g., `PostgresOrderRepository`) is an infrastructure detail and lives outside the domain model.

### Phase 4: Verification and Iteration

1.  **Write Unit Tests:**
    *   **Instruction:** For each business rule and invariant in your Aggregate Root's methods, write a corresponding unit test to verify its correctness. This ensures your domain logic is robust at a micro-level.

2.  **Write Behavioral Tests:**
    *   **Instruction:** To verify the end-to-end behavior of your domain model and ensure it meets business requirements, use a Behavior-Driven Development (BDD) approach.
    *   **Recommendation:** Activate the **`process/bdd-outside-in`** skill. This will guide you through the iterative loop of writing a Gherkin scenario, implementing the domain logic to make it pass, and refactoring.

3.  **Iterate:**
    *   **Instruction:** Remind the user that domain modeling is an iterative process of discovery. The code will and should be refactored as understanding of the domain deepens.

### Phase 5: Automation (Accelerators)

To accelerate the implementation process in Rust, you can use the provided automation script. This script generates boilerplate code and directory structures based on the templates in the `assets` directory.

1.  **Generate an Aggregate Skeleton:**
    *   **Instruction:** To quickly create the directory structure (`src/domain/your_aggregate/`), `mod.rs`, `aggregate.rs`, and `repository.rs` for a new aggregate.
    *   **Action:** Run the `generate_aggregate_skeleton.sh` script from the project root.
    *   **Tool:** `run_shell_command(command: "./skills/ddd/implement-domain-model/scripts/generate_aggregate_skeleton.sh <YourAggregateName>")`
    *   **Example:** `run_shell_command(command: "./skills/ddd/implement-domain-model/scripts/generate_aggregate_skeleton.sh MyOrder")`


