---
name: eric-evans/distill
description: Analyzes a software problem through a deep, collaborative dialogue inspired by Domain-Driven Design. The agent acts as a partner, conducting research, challenging assumptions, and co-creating a domain model with the user.
---

# Skill: eric-evans/distill

## When to use

Activate this skill when you need a deep thinking partner to tackle a complex software problem. It's ideal for starting a new project, designing a major feature, or refactoring a core part of your system. Use this skill to ensure your software design is deeply aligned with the business domain, moving beyond purely technical decisions.

## Instructions

This skill guides a one-on-one analytical dialogue between you (the domain expert) and the agent. The agent will proactively research your domain, help distill your knowledge into a robust model, and apply the strategic and tactical principles of DDD.

### Phase 1: Understand the Vision & The Business Landscape

1.  **Explore the Core Problem.** The first step is a conversation. The agent will ask probing questions to understand the business need, the "why" behind the software, and the value it's intended to deliver.
    - **Agent's Role:** Ask open-ended questions like: "What problem are we trying to solve?", "Who is this for?", "What makes this a valuable endeavor for the business?", "What would be a disaster if we get it wrong?".

2.  **Conduct Domain Research.** Armed with an initial understanding, the agent will perform deep research on the problem domain.
    - **Agent's Role:** Use `google_web_search` to find articles, academic papers, and existing software patterns related to the user's domain. Synthesize these findings and present them.
    - **Example Prompt:** "Based on our initial conversation about 'supply chain logistics,' I've researched common models. Many systems use concepts like 'Shipments,' 'Bills of Lading,' and 'Inventory Lots.' They often face challenges with 'customs clearance' and 'last-mile delivery.' Does this terminology resonate with you? Are these the hard parts of your domain?"

3.  **Establish a Domain Vision.** Collaboratively create a concise Domain Vision Statement to serve as a north star.
    - **Agent's Role:** Activate the `ddd/write-domain-vision` skill. Use the insights from the conversation and research to help the user articulate a powerful vision.
    - **Tool:** `activate_skill(name='ddd/write-domain-vision')`

### Phase 2: Distill the Language & Identify Key Concepts

4.  **Guided Knowledge-Crunching.** Instead of a formal workshop, the agent will facilitate a structured conversation to surface key business processes and knowledge.
    - **Agent's Role:** Guide the user by focusing on events. Ask: "Let's walk through a key process. What's the first significant thing that happens? We can call that a 'Domain Event.' For example, 'Customer Placed an Order.' What happens next?". Identify Events, Commands, and the people or systems (Actors) involved.

5.  **Build the Ubiquitous Language.** The agent and user will collaboratively define the core terms of the domain.
    - **Agent's Role:** Propose definitions for terms that arise, drawing from the conversation and prior research. The goal is to create a shared, unambiguous dictionary.
    - **Example dialogue:** "You mentioned the term 'Consignment' several times. From my research and our chat, it seems a 'Consignment' is not just the goods, but the entire legal agreement for shipping them. Is that accurate? Let's write that down as the official definition in our `ubiquitous-language.md`."

### Phase 3: Strategic Design & Context Mapping

6.  **Find the Core Domain.** The agent will help you differentiate the core, supporting, and generic parts of your domain.
    - **Agent's Role:** Ask clarifying questions based on the vision and knowledge gathered. "Of all the things we've discussed, what is the unique, complex part that gives your business its competitive advantage? That's our **Core Domain**. What parts are just 'plumbing' or solved problems, like sending notifications? We'll call those **Generic Subdomains**."

7.  **Sketch Bounded Contexts.** The agent will help you draw the boundaries for different parts of the model.
    - **Agent's Role:** Based on the language, identify where terms have different meanings. "It sounds like a 'Product' in the 'Sales' context is just a catalog item, but in 'Inventory' it's a physical object with a location. This suggests we have two Bounded Contexts here: 'Sales' and 'Inventory.' Let's map them out."
    - Activate `ddd/create-architecture-overview` to formalize this map.
    - **Tool:** `activate_skill(name='ddd/create-architecture-overview')`

### Phase 4: Tactical Modeling & Validation

8.  **Explore and Challenge Models.** The agent will act as a sounding board and a creative partner to explore different ways to model the Core Domain.
    - **Agent's Role:** Propose alternative designs. "We could model the 'Order' as one large object with all its data. Alternatively, what if we modeled it as a smaller object that just references a 'Customer' and a list of 'LineItems'? This might be more flexible. Let's sketch that out."

9.  **Make it Concrete with an Aggregate.** To test the model, the agent will guide you in designing a key Aggregate.
    - **Agent's Role:** Activate the `ddd/design-aggregate-canvas` skill to focus on one core concept. This will force a deeper look at the model's invariants (the rules it must protect), its commands, and its resulting events.
    - **Tool:** `activate_skill(name='ddd/design-aggregate-canvas')`

### Phase 5: Continuous Refinement

10. **Review and Iterate.** The agent will summarize the model developed so far and emphasize that it is a living artifact.
    - **Agent's Role:** Conclude with this advice: "**This model is a powerful starting point, but it's not final. It's a lens through which we can better understand the business. As our understanding deepens, we must challenge and refine this model together.**"
