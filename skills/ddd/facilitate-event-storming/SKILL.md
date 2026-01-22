---
name: ddd/facilitate-event-storming
description: Guides the preparation and digitization of outputs from an Event Storming workshop, facilitating a deep understanding of complex business domains.
---

# Skill: ddd/facilitate-event-storming

## When to use

Activate this skill when you need to understand a complex business domain, identify core domain events and processes, bridge communication gaps between technical and non-technical teams, or discover potential Bounded Contexts. This skill helps you prepare for and capture the results of a collaborative Event Storming workshop.

## Instructions

This skill will guide you through the process of setting up, running (conceptually), and digitizing the output of an Event Storming workshop.

### Phase 1: Workshop Preparation & Setup (Conceptual Guide)

This skill *does not run the workshop for you*. It guides you through the process of *preparing for* and *digitizing the output from* a real-world, collaborative Event Storming session.

1.  **Understand Event Storming.** Event Storming is a collaborative, workshop-based technique created by Alberto Brandolini. It uses color-coded sticky notes on a large modeling surface to map out the flow of events within a business process.
    *   **Goal:** To achieve a shared understanding of a complex domain, identify events, commands, aggregates, policies, and ultimately, discover Bounded Contexts.

2.  **Identify Roles & Participants.**
    *   **Facilitator (Crucial):** An experienced person to guide the session, manage discussions, and ensure everyone participates. This will be you, the user, in this process.
    *   **Participants (6-15 people):** A diverse group including domain experts, product owners, developers, business analysts, and testers. Ensure you have people who truly understand the business.

3.  **Gather Materials.**
    *   **Modeling Space:** A large wall with a roll of paper, or a collaborative virtual whiteboard (e.g., Miro, Mural). Ample space is critical.
    *   **Sticky Notes (Key Artifacts - by color):**
        *   **Orange:** **Domain Event** ("something happened," always past tense, e.g., `Order Placed`).
        *   **Blue:** **Command** (an intention to do something, e.g., `Place Order`).
        *   **Small Yellow/Gray:** **Actor** (who or what issues a command, e.g., `Customer`, `Scheduler`).
        *   **Large Yellow:** **Aggregate** (a cluster of domain objects, a transactional consistency boundary, e.g., `Order`).
        *   **Lilac:** **Policy/Reaction** (automated reaction to an event, e.g., "When `Order Placed`, then `Send Confirmation Email`).
        *   **Green:** **Read Model** (information needed for a decision, e.g., `Product Catalog`).
        *   **Pink:** **External System** (third-party integration, e.g., `Payment Gateway`).
        *   **Red:** **Hot Spot/Issue** (problems, questions, areas of concern).
    *   **Markers:** Plenty of markers for everyone.

4.  **Set Workshop Objectives.** Clearly define what you want to achieve from the session. Is it a "Big Picture" overview, a "Process Modeling" deep dive, or "Software Design" focus?

5.  **Conduct the Workshop.** **At this point, you, the user, need to physically or virtually run the Event Storming workshop.** Guide your participants through the following steps on your modeling surface:
    *   **Storm Domain Events (Orange):** Start by asking "What happened in the system?" Write down all domain events in past tense.
    *   **Enforce Timeline:** Arrange events chronologically from left to right. Discuss and resolve any inconsistencies.
    *   **Add Commands (Blue):** For each event, identify the command that caused it and place it before the event.
    *   **Identify Actors (Small Yellow/Gray):** Determine who or what triggered each command.
    *   **Identify Aggregates (Large Yellow):** Group related commands and events around the Aggregates they belong to.
    *   **Add Supporting Elements (Lilac, Green, Pink):** Add policies, read models, and external systems where relevant.
    *   **Identify Hot Spots (Red):** Mark any questions, problems, or areas requiring further investigation.
    *   **Identify Bounded Contexts:** Draw boundaries around cohesive areas that emerge.

### Phase 2: Digitizing the Output (After the Workshop)

Once your physical/virtual Event Storming board is complete, this skill will help you transfer its key findings into a structured, version-controllable `EVENT_STORM_OUTPUT.md` file.

1.  **Explain the Goal.** Inform the user that you will now digitize the board. The output will be an `EVENT_STORM_OUTPUT.md` file in the current directory.

2.  **Gather Event Details (Iterative).**
    *   You will be asked to describe each major Domain Event block from your board, moving chronologically.
    *   Start the loop by asking: "**What is the name of the first (or next) Domain Event you want to digitize from your board?** (e.g., `OrderPlaced`). Type 'done' when you have digitized all relevant events."
    *   For each event name provided:
        *   Ask: "**Provide a brief description of what this event signifies.**"
        *   Ask: "**What is the name of the Command that triggered this event?**"
        *   Ask: "**Who or what is the Actor that issued this command?**"
        *   Ask: "**What is the name of the Aggregate that processed this command and produced the event?**"
        *   Ask: "**List any Policies or Reactions that are directly triggered by this event.** (Provide a comma-separated list, or 'None')."
    *   Repeat this loop until the user types 'done'.

3.  **Generate the Document.**
    *   Read the template file from `skills/ddd/facilitate-event-storming/assets/event_storm_board_template.md`.
    *   For each event block the user detailed, populate a new section in the markdown document.
    *   Use the `write_file` tool to create a new file named `EVENT_STORM_OUTPUT.md` in the current directory with the completed content.
    *   Inform the user that the `EVENT_STORM_OUTPUT.md` has been created, capturing the essence of their Event Storming session.
