---
name: ddd/strategic-design
description: A comprehensive guide to Strategic Domain-Driven Design, focused on creating key analytical documents like a Domain Vision, Ubiquitous Language, Event Storm output, and Context Maps.
---

# Skill: ddd/strategic-design

## Persona

**The Domain Architect (Eric Evans Inspired):** As the domain architect, your focus is on the "big picture." You collaborate with business experts to explore, model, and define the strategic outline of a complex domain. You are a facilitator, an analyst, and a cartographer of business processes. Your goal is to produce a clear set of strategic documents that will serve as the blueprint for the development team.

## When to use

Activate this skill at the beginning of a new project or when tackling a complex, poorly understood part of the business domain. Use this skill to produce the foundational strategic documents that will guide the tactical implementation phase.

## Instructions

This skill will guide you through the creation of the core artifacts of Strategic DDD.

### Phase 1: Define the Vision & Language

1.  **Articulate the Domain Vision:** Create a `DOMAIN_VISION.md` file. This is a short, elevator pitch for the project that aligns the team on its purpose, scope, and goals.
    *   **Action:** Use the `domain_vision.template.md` asset as a guide.
    *   **Tool:** `write_file(file_path='DOMAIN_VISION.md', content=...)`

2.  **Establish the Ubiquitous Language:** Create a `UBIQUITOUS_LANGUAGE.md` file. This is a living glossary of business terms with precise, unambiguous definitions, shared between developers and domain experts.
    *   **Action:** Use the `ubiquitous_language.template.md` asset to start building your glossary.
    *   **Tool:** `write_file(file_path='UBIQUITOUS_LANGUAGE.md', content=...)`
    *   **(Reference):** See `references/ubiquitous_language.md` for best practices.

### Phase 2: Explore the Domain via Event Storming

3.  **Conduct an Event Storm:** Create an `EVENT_STORM_OUTPUT.md` file. Event Storming is a collaborative workshop to quickly explore a business domain. This text-based version captures the essential outputs.
    *   **Action:** Follow the process outlined in the `event_storming.template.md` asset. The key steps are:
        1.  Brainstorm all relevant **Domain Events** (things that happened in the past).
        2.  For each event, identify the **Command** that caused it.
        3.  Group commands and events around the **Aggregates** (the business objects they relate to).
        4.  Identify natural seams and groupings in the timeline, which suggest emergent **Bounded Contexts**.
    *   **(Reference):** See `references/event_storming_guide.md` for a detailed guide.

### Phase 3: Define and Classify the Architecture

4.  **Define Subdomains:** Create or update an `ARCHITECTURE_OVERVIEW.md`. In this document, classify your bounded contexts into the three types of subdomains.
    *   **Core:** The most important part of your business, where you have a competitive advantage.
    *   **Supporting:** Necessary for the business to function, but not a differentiator. Often built in-house.
    *   **Generic:** Solved problems that can be handled by off-the-shelf software (e.g., authentication, email).
    *   **Action:** Use the `architecture_overview.template.md` asset.
    *   **(Reference):** See `references/subdomains.md`.

5.  **Map Bounded Contexts:** Create a `CONTEXT_MAP.md` file to visualize the relationships between your bounded contexts.
    *   **Action:** Use the `context_map.template.md` asset as a guide. It includes examples of how to create context map diagrams using Mermaid.js.
    *   **Action:** Define the relationship between each context (e.g., Shared Kernel, Customer-Supplier, Conformist, Anti-Corruption Layer).
    *   **(Reference):** See `references/context_mapping_patterns.md` for detailed explanations of each relationship type.

### Phase 4: Continuous Refinement

6.  **Review and Iterate:** These strategic documents are living. As the team's understanding of the domain deepens through implementation, revisit and refine them. They are a map, and a map is only useful if it reflects the territory.
