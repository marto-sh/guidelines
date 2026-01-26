# Our Development Process: From Strategy to Code

This document outlines the development methodology we use to build robust, business-aligned software. Our process combines the high-level analysis of **Strategic Domain-Driven Design (DDD)** with the iterative, behavior-focused workflow of **Behavior-Driven Development (BDD) in an "Outside-In" fashion**.

The core philosophy is simple:
1.  **Understand the business domain first.**
2.  **Let user-facing behavior drive development.**
3.  **Build a rich, expressive domain model at the core of the application.**

---

## Phase 1: Strategic Design - Understanding the Big Picture

Before writing a single line of feature code, we invest time in understanding the business domain. This "big picture" view ensures we are solving the right problems and structuring our software in a way that aligns with the business structure. This phase is guided by the **`ddd/strategic-design`** skill and produces a set of living documents that serve as our architectural blueprint.

### 1. Articulate the Domain Vision
We start by creating a `DOMAIN_VISION.md`. This is a concise, high-level summary that aligns the team and stakeholders on the purpose, scope, and goals of the project.

### 2. Establish the Ubiquitous Language
We create and maintain a `UBIQUITOUS_LANGUAGE.md`. This is a shared glossary of terms, co-developed by domain experts and developers. Using this language in all conversations, documents, and code is non-negotiable and critical for eliminating ambiguity.

### 3. Explore the Domain via Event Storming
We conduct Event Storming workshops to collaboratively explore the business domain. The output, captured in `EVENT_STORM_OUTPUT.md`, is a timeline of **Domain Events** (things that happened). This process reveals key business processes, commands, and the business objects (Aggregates) that are central to the domain.

### 4. Define Bounded Contexts and the Context Map
The insights from Event Storming allow us to identify natural seams in the domain, which we define as **Bounded Contexts**. Each Bounded Context has its own Ubiquitous Language and model. We classify these contexts into **Core**, **Supporting**, or **Generic** subdomains in our `ARCHITECTURE_OVERVIEW.md`.

Finally, we create a `CONTEXT_MAP.md` to visualize the relationships and integration patterns between these contexts (e.g., Shared Kernel, Anti-Corruption Layer).

---

## Phase 2: Tactical Implementation - The BDD Outside-In Loop

With a strategic foundation in place, we begin implementing features. This entire phase is orchestrated by the **`process/bdd-outside-in`** skill, which guides us through an iterative cycle focused on building one small piece of user-visible behavior at a time. The loop has three steps: **Red**, **Green**, and **Refactor**.

### Step 1: Write a Failing Behavior (RED)
*   **Goal:** Define the next piece of behavior and create a failing test that proves it's not yet implemented.
*   **Action:** We use the `bdd/author-and-implement-features` skill to write a **Gherkin `Scenario`** in a `.feature` file. This scenario is written from the user's perspective, using the Ubiquitous Language.
*   **Result:** Running the test suite shows a failing test (RED).

### Step 2: Implement to Pass (GREEN)
*   **Goal:** Write the simplest code possible to make the failing test pass.
*   **Action (Outside):** We first implement the "glue" code—the step definitions that connect the Gherkin scenario to the application code.
*   **Action (Inside):** As we work inward, the test will force us to create or modify the core business logic. At this point, we use the `ddd/implement-domain-model` skill. We create the necessary **Aggregates**, **Entities**, and **Value Objects** to satisfy the required behavior. The logic within these domain objects makes the test pass.
*   **Result:** Running the test suite again shows all tests passing (GREEN).

### Step 3: Refactor for Clarity (REFACTOR)
*   **Goal:** Clean up the code just written, while keeping the tests green.
*   **Action:** With the safety net of our passing tests, we refactor the domain model and surrounding code. We improve names, remove duplication, and ensure the code clearly expresses the concepts from our Ubiquitous Language.
*   **Result:** The tests remain GREEN, and the code is cleaner, more expressive, and easier to maintain.

We repeat this Red-Green-Refactor loop for every slice of behavior required to complete a feature.

---

## A Deeper Look at Implementation Skills

### Skill: `bdd/author-and-implement-features`
This is the engine of our BDD cycle. It covers both the "authoring" of `.feature` files with business-readable scenarios and the "implementation" of the Rust step definitions that bind those scenarios to executable test code.

### Skill: `ddd/implement-domain-model`
This skill is applied during the "Green" and "Refactor" steps of the BDD loop. When a feature requires genuine business logic, we don't put that logic in scripts or services. We use this skill to:
*   Create **Value Objects** for descriptive, immutable attributes.
*   Define **Entities** for objects with a thread of identity.
*   Build **Aggregates** to act as transactional consistency boundaries, encapsulating business rules and invariants.
*   Define **Repository Interfaces** that the domain layer needs to persist and retrieve aggregates.

## Conclusion

This process creates a powerful feedback loop. The strategic design informs the implementation, and the act of implementing features with BDD refines our understanding of the domain, leading us to update and improve our strategic documents. It is an iterative journey of discovery that results in software that is both technically sound and perfectly aligned with the needs of the business.
