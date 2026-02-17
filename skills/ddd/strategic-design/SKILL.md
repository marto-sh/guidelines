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
    *   **Rules:**
        *   **Focus on current scope.** Do not include aspirational future states. This is a living document — expand it when the time comes. Bad: "small businesses, and eventually enterprises". Good: "small businesses".
        *   **"For"**: Who you are building for NOW.
        *   **"Who"**: Describe the FELT PAIN of the target users — what they actually experience. Do not project product philosophy or ideology here. Bad: "tired of vendor lock-in and proprietary platforms". Good: "tired of manually copying the same data into every new tool they try".
        *   **"The (product) is a"**: A short product category label, one line. Bad: "an AI-powered, cloud-native platform that automates invoicing". Good: "an invoicing tool".
        *   **"That"**: What the product does for the user. Do not include product philosophy or differentiation here.
        *   **"Unlike"**: Be factual about competitors, not harsh. Research actual competitors. Describe what each alternative lacks, not why they're bad. Bad: "bloated, overpriced legacy tools that trap your data". Good: "traditional invoicing software, which requires manual data entry and offers no API integration".
        *   **"Our product"**: Primary differentiation and product values. Do not repeat what's already in "That".
        *   **General:** Each section has a specific purpose — don't repeat information across sections. Prefer general terms over specific ones when the scope is broad. Bad: "job title, seniority level, and location". Good: "matching criteria". Challenge every word: "Is this the right word? Does it belong in THIS section?"

2.  **Establish the Ubiquitous Language:** Create a `UBIQUITOUS_LANGUAGE.md` file. This is a living glossary of business terms with precise, unambiguous definitions, shared between developers and domain experts.
    *   **Action:** Use the `ubiquitous_language.template.md` asset to start building your glossary.
    *   **Tool:** `write_file(file_path='UBIQUITOUS_LANGUAGE.md', content=...)`
    *   **(Reference):** See `references/ubiquitous_language.md` for best practices.
    *   **Rules:**
        *   **Definitions describe what things ARE, not product features.** A definition should be recognizable to anyone outside the project. Bad: "An invoice automatically generated and sent via email when payment is due". Good: "A document requesting payment for goods or services delivered".
        *   **Don't redefine common terms beyond recognition.** If a term has a universally understood meaning, keep the definition grounded. The product's behavior can differ from the definition. Bad: "An order is a real-time, AI-optimized fulfillment request". Good: "A customer's request to purchase one or more products".
        *   **Use defined terms to describe each other.** Once a term is in the glossary, use it consistently. Bad: "A Shipment contains the customer's purchased items". Good: "A Shipment contains the items from an Order".
        *   **Capitalize ubiquitous language terms** everywhere — in documents, descriptions, and eventually in code.
        *   **Domain principles can belong in the glossary** if they are core to the product identity, even if they won't map directly to a code construct.
        *   **Don't force terms to fit.** If a term keeps evolving or doesn't hold up to scrutiny, drop it and revisit later. The glossary is a living document.
        *   **No technical jargon.** Use business language. Bad: "an upserted entity at runtime". Good: "a record that is created or updated".

### Phase 2: Explore the Domain via Event Storming

3.  **Conduct an Event Storm:** Create an `EVENT_STORM_OUTPUT.md` file. Event Storming is a collaborative workshop to quickly explore a business domain. This text-based version captures the essential outputs.
    *   **Action:** Follow the process outlined in the `event_storming.template.md` asset. The key steps are:
        1.  Brainstorm all relevant **Domain Events** (things that happened in the past).
        2.  For each event, identify the **Command** that caused it.
        3.  Group commands and events around the **Aggregates** (the business objects they relate to).
        4.  Identify natural seams and groupings in the timeline, which suggest emergent **Bounded Contexts**.
    *   **(Reference):** See `references/event_storming_guide.md` for a detailed guide.
    *   **Rules:**
        *   **Be systematic when brainstorming events.** For each term in the Ubiquitous Language, ask: (1) What is its full lifecycle? (create/draft, evolve, end/archive) (2) How does it interact with every other term? This must be done unprompted, not after being asked.
        *   **Think bidirectionally.** Most flows work in both directions. Bad: only modeling "customer places order". Good: also considering "order is returned by customer", "supplier cancels order". Always ask: what happens in the other direction?
        *   **Model the full lifecycle.** If something can start, it can end. If something can be created, it might be updated or deleted. Bad: `OrderPlaced` with no `OrderCancelled` or `OrderCompleted`. Good: modeling the full lifecycle from creation to terminal states.
        *   **Look for redundant events.** If two events describe the same decision point through different paths, they may be the same mechanism. Bad: both `PaymentApproved` and `OrderPaymentConfirmed` for the same action. Good: one event with clear ownership.
        *   **Consider lifecycle states.** Entities may have meaningful intermediate states rather than simple create/update. Bad: `OrderCreated` then `OrderUpdated`. Good: `OrderDrafted`, `OrderSubmitted`, `OrderConfirmed` when those states carry distinct business meaning.
        *   **Use ubiquitous language terms consistently** and capitalize them throughout the document.
        *   **No technical jargon.** Use business language, not developer language. Bad: "the entity is persisted at runtime". Good: "the Order is saved".

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
