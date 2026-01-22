---
name: ddd/create-domain-event-catalog
description: Helps create a catalog of all Domain Events within a specific Bounded Context.
---

# Skill: ddd/create-domain-event-catalog

## When to use

Activate this skill when you are designing an event-driven system or have identified that events are a key part of your domain model. It's useful for creating a central, shared understanding of what events can occur, what they mean, and what data they carry.

## Instructions

1.  **Explain the Goal.** Inform the user that this skill will help them create a `DOMAIN_EVENTS.md` file that catalogs the Domain Events for a Bounded Context.

2.  **Identify the Bounded Context.**
    *   Ask the user: "**For which Bounded Context are we cataloging these events?**" (e.g., "Sales", "Shipping").

3.  **Detail Events (Iterative).**
    *   Explain that you will now loop through the events in this context.
    *   Start the loop by asking: "**What is the name of a Domain Event?** (e.g., `OrderPlaced`, `ItemShipped`). Type 'done' when you have no more events."
    *   For each event name provided:
        *   Ask: "**Provide a brief description of what this event signifies.**"
        *   Ask: "**What is the name of the Aggregate Root that produces this event?**"
        *   Ask: "**What are the key data points in its payload?** (Provide a comma-separated list, e.g., `orderId, customerId, amount`)."
    *   Repeat this loop until the user types 'done'.

4.  **Generate the Document.**
    *   Read the template file from `skills/ddd/create-domain-event-catalog/assets/domain_event_catalog_template.md`.
    *   Replace `[Context Name]` with the user's answer.
    *   For each event the user detailed, add a new row to the markdown table.
    *   Use the `write_file` tool to create a new file named `DOMAIN_EVENTS.md` in the current directory with the completed content.
    *   Inform the user that the catalog has been created.
