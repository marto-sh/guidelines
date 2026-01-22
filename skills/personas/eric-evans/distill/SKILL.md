---
name: eric-evans/distill
description: Analyzes a software problem using the thought process of Domain-Driven Design's founder, Eric Evans. It guides the user through collaborative knowledge-crunching, distilling a domain model, and applying strategic design principles.
---

# Skill: eric-evans/distill

## When to use

Activate this skill when starting a new project, tackling a complex feature, or considering a significant refactoring. Use it to ensure the software design is deeply and deliberately aligned with the core business needs, rather than being driven by purely technical decisions. This skill is most valuable when the problem domain is complex and not fully understood.

## Instructions

This skill guides you through an analysis process that mirrors the philosophy of Eric Evans, leveraging other specialized skills to facilitate a deeper, more structured distillation of your domain.

### Phase 0: Vision Setting (Orchestrated by `ddd/write-domain-vision`)

1.  **Establish a Domain Vision.** Before diving into the details, it's crucial to align on the high-level purpose and value of the domain.
    - **Instruction:** Activate the `ddd/write-domain-vision` skill to collaboratively create a concise Domain Vision Statement.
    - **Tool:** `activate_skill(name='ddd/write-domain-vision')`

### Phase 1: Deep Domain Discovery (Orchestrated by `ddd/facilitate-event-storming`)

2.  **Conduct Event Storming for Knowledge Crunching.** This collaborative workshop is the primary tool for deep knowledge acquisition and building the Ubiquitous Language. It will help surface Domain Events, Commands, Actors, Aggregates, Policies, and initial Bounded Contexts.
    - **Instruction:** Activate the `ddd/facilitate-event-storming` skill to guide you through preparing for and digitizing the output of an Event Storming session. This process directly contributes to identifying your Ubiquitous Language and initial domain model concepts.
    - **Tool:** `activate_skill(name='ddd/facilitate-event-storming')`

3.  **Refine Ubiquitous Language.** Building upon the Event Storming output, continue to develop and formalize your Ubiquitous Language.
    - **Instruction:** Populate your `ubiquitous-language.md` file (which can be initialized by `eric-evans/distill/scripts/init_ubiquitous_language.sh` if not already present from previous steps, or populated directly from Event Storming notes). The definition for each term must be:
        - clear
        - unambiguous
        - agreed upon by both developers and domain experts.

### Phase 2: Strategic Design & Context Mapping (Leveraging `ddd/create-architecture-overview`)

4.  **Find the Core Domain.** Based on the insights from Event Storming, differentiate the core from the supporting parts:
    - "**What is the unique, valuable, and complex part of this business problem?**" This is the **Core Domain**.
    - "What parts are necessary but not specific to this business (e.g., user authentication, sending emails)?" These are **Generic Subdomains**.
    - "What parts support the core business but are not the central complexity?" These are **Supporting Subdomains**.
    - State that the team's primary modeling effort should be focused on the Core Domain.

5.  **Identify and Map Bounded Contexts.** The Event Storming session should have provided strong indicators for Bounded Contexts. Refine these boundaries.
    - **Instruction:** Use the `ddd/create-architecture-overview` skill to map these Bounded Contexts and their relationships visually.
    - **Tool:** `activate_skill(name='ddd/create-architecture-overview')`

6.  **Explore and Experiment with Models.** Remind the user that the first model is rarely the best. Encourage exploration. Suggest the following:
    - "Let's explore a few different ways to model this. Don't worry about finding the perfect model immediately. Even a 'bad' model can teach us something valuable."
    - "Let's try to sketch out a key scenario. How would the objects interact?"

### Phase 3: Tactical Design & Model Validation (Leveraging `ddd/design-aggregate-canvas` and others)

7.  **Model a Key Aggregate.** To make the model concrete, dive into a single, core concept. This is about testing the model's expressive power.
    - **Instruction:** Activate the `ddd/design-aggregate-canvas` skill to guide the detailed design of a selected Aggregate, defining its invariants, commands, and events.
    - **Tool:** `activate_skill(name='ddd/design-aggregate-canvas')`

8.  **Catalog Domain Events and Business Rules (As needed).**
    - **Instruction (Optional):** If warranted by the complexity or need for shared reference, consider activating the `ddd/create-domain-event-catalog` or `ddd/create-business-rule-catalog` skills for a specific Bounded Context or Aggregate.
    - **Tool (Example):** `activate_skill(name='ddd/create-domain-event-catalog')`
    - **Tool (Example):** `activate_skill(name='ddd/create-business-rule-catalog')`

9.  **Review and Refine.** End the process by emphasizing the iterative nature of DDD.
    - Summarize the findings, drawing from the output of the various skills used.
    - Conclude with this advice: "**This model is a starting point. It is a living artifact that must be challenged, refined, and continuously improved through close collaboration with domain experts as our understanding deepens.**"
