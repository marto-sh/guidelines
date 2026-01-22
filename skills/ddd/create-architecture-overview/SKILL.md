---
name: ddd/create-architecture-overview
description: Helps generate an Architectural Overview Diagram using Mermaid syntax to map Bounded Contexts and their relationships.
---

# Skill: ddd/create-architecture-overview

## When to use

Activate this skill after you have identified the primary Bounded Contexts for your system using a process like the `eric-evans/distill` skill. This skill is ideal for creating a high-level, version-controllable diagram of your system's strategic design.

## Instructions

1.  **Explain the Goal.** Inform the user that this skill will help them create a `ARCHITECTURE.md` file containing a Mermaid diagram of their Bounded Contexts. Present them with the standard DDD relationship patterns:
    *   **Upstream/Downstream (U/D):** One context influences the other.
    *   **Shared Kernel (SK):** Two contexts share a small, common model.
    *   **Customer/Supplier (C/S):** An upstream 'Supplier' context provides services to a downstream 'Customer' context.
    *   **Conformist (CF):** A downstream context adheres to the model of an upstream context without sharing code.
    *   **Anti-Corruption Layer (ACL):** A downstream context creates a translation layer to protect its model from an upstream context.

2.  **Gather Bounded Contexts.** Ask the user to list the names of all the Bounded Contexts they have identified (e.g., "Sales", "Shipping", "Identity").

3.  **Gather Relationships.**
    *   Iterate through the list of contexts. For each context, ask the user if it has a relationship with any other context.
    *   For each relationship the user identifies, ask them to specify the two contexts and the type of relationship (using the abbreviations like `U/D`, `SK`, `ACL`).
    *   Example prompt: "**Describe a relationship:** `ContextA, ContextB, U/D` (where Sales is Upstream of Shipping)". Keep prompting until the user has no more relationships to add.

4.  **Generate the Diagram Definition.**
    *   Read the template from `skills/ddd/create-architecture-overview/assets/architecture_overview_template.md`.
    *   **Contexts:** In the `%% CONTEXTS %%` section of the template, add a line for each context (e.g., `    Sales["Sales Context"]`).
    *   **Relationships:** In the `%% RELATIONSHIPS %%` section, translate the user's input into Mermaid syntax (e.g., `Sales -- "U/D" --> Shipping`).
    *   **Styling (Optional):** In the `%% STYLING %%` section, you could add styling for core contexts, e.g., `style CoreContext fill:#f9f,stroke:#333,stroke-width:4px`.

5.  **Generate the Document.**
    *   Use the `write_file` tool to create a new file named `ARCHITECTURE.md` in the current directory.
    *   The content should include a title and the completed Mermaid diagram block.
    *   Inform the user that the `ARCHITECTURE.md` file has been created and that they can render the diagram using any Mermaid-compatible viewer.
