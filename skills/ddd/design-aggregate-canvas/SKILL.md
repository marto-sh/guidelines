---
name: ddd/design-aggregate-canvas
description: Guides the detailed design of a single Aggregate using a structured canvas format.
---

# Skill: ddd/design-aggregate-canvas

## When to use

Activate this skill when you have identified a key Aggregate within your Core Domain and need to flesh out its behavior, rules, and boundaries in detail. It's a focused tool for tactical design, best used after initial strategic design is underway.

## Instructions

1.  **Explain the Goal.** Inform the user that this skill will guide them through designing an Aggregate, and the output will be a detailed `[AggregateName]_CANVAS.md` file.

2.  **Identify the Aggregate.**
    *   Ask the user: "**What is the name of the Aggregate Root?**" (e.g., "Order", "Product").
    *   Ask the user: "**Provide a brief, one-sentence description of this aggregate's purpose.**"

3.  **Define Invariants.**
    *   Ask the user: "**What are the fundamental business rules (invariants) that this aggregate must always protect, no matter what?**"
    *   Prompt the user to list them. Example: "An order's total cost can never be negative," or "A product must always have a name."

4.  **Detail Commands and Events (Iterative).**
    *   Explain that you will now loop through the commands this aggregate handles.
    *   Start the loop by asking: "**What is the name of a command this aggregate should handle?** (e.g., `PlaceOrder`, `AddLineItem`). Type 'done' when you have no more commands."
    *   For each command name provided:
        *   Ask: "**What is its description and what parameters does it need?**"
        *   Ask: "**If this command succeeds, what Domain Event(s) does it produce?** (e.g., `OrderPlaced`, `LineItemAdded`)."
        *   Ask: "**What are the potential reasons this command might fail?** (e.g., 'If payment is declined', 'If product is out of stock')."
    *   Repeat this loop until the user types 'done'.

5.  **Generate the Document.**
    *   Read the template file from `skills/ddd/design-aggregate-canvas/assets/aggregate_canvas_template.md`.
    *   Replace `[Aggregate Root Name]` and the description with the user's answers.
    *   Populate the "Invariants" section with the list of rules.
    *   For each command the user detailed, create a populated "Command" block in the document.
    *   Use the `write_file` tool to create a new file named `[AggregateName]_CANVAS.md` (e.g., `Order_CANVAS.md`) with the completed content.
    *   Inform the user that the canvas document has been created.
