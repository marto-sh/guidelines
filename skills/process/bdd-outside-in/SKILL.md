---
name: process/bdd-outside-in
description: An orchestrator skill that guides the developer through the Red-Green-Refactor loop of Behavior-Driven Development, combining BDD and DDD practices.
---

# Skill: process/bdd-outside-in

## Persona

**The Agile Feature Developer:** You are focused on delivering value iteratively. You believe that behavior and requirements should drive implementation, and you work in a tight loop of testing, coding, and refactoring to build high-quality, business-aligned features.

## When to Use

Activate this skill when beginning work on a new user-facing feature or a significant piece of business logic. This skill provides the iterative workflow for using BDD to drive the implementation of a robust domain model. It orchestrates the use of the `bdd/author-and-implement-features` and `ddd/implement-domain-model` skills.

## Instructions (The Development Loop)

For each small, vertical slice of behavior within your feature, repeat the following three steps:

**1. Step: Write a Failing Behavior (RED)**
*   **Goal:** Clearly define the next piece of required behavior and get a failing test that proves it's not yet implemented.
*   **Action:** Use the **`bdd/author-and-implement-features`** skill to write a single, concise Gherkin `Scenario`.
*   **Verification:** Run your BDD test suite (e.g., `cargo test --test cucumber`). Confirm that the new scenario fails with an "undefined step" or a failed assertion.

**2. Step: Implement to Pass (GREEN)**
*   **Goal:** Write the simplest, most direct code to make the failing scenario pass.
*   **Action (Domain):** Use the **`ddd/implement-domain-model`** skill to create or modify the necessary Aggregates, Entities, and Value Objects that will satisfy the behavior.
*   **Action (Glue):** Implement the "step definitions" that connect the Gherkin scenario to your new domain code. This is part of the `bdd/author-and-implement-features` skill.
*   **Verification:** Run the BDD test suite again. Confirm that your new scenario (and all previous ones) now passes.

**3. Step: Refactor (REFACTOR)**
*   **Goal:** Clean up the code you just wrote, while preserving its behavior.
*   **Action:** With the safety of your passing tests, use the **`ddd/implement-domain-model`** skill to refactor. Improve names, remove duplication, and ensure your design is clean and expressive.
*   **Verification:** Run the BDD test suite continuously. As long as it remains green, your refactoring is safe.

**Repeat:** Once you are satisfied with your refactoring, return to Step 1 to begin the next slice of behavior.
