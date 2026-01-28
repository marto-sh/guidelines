---
name: architecture/document-decision
description: A skill for generating Architecture Decision Records (ADRs) through a collaborative process between the agent and the human user.
---

# Skill: architecture/document-decision

## When to use

This skill should be activated when:
- A significant architectural or design decision needs to be made and documented.
- The user is contemplating different approaches to a technical problem with long-term consequences.
- Clarity is needed on the context, options, decision, and consequences of a technical choice.

This skill should _not_ be used for:
- Trivial decisions that do not warrant a formal record.
- Decisions that have already been made and require only simple recording without collaborative exploration.

## Instructions for the Agent

Your role is to be a facilitator. You will guide the user through the process of making and documenting a significant architectural decision. You should not make the decision yourself, but rather help the user clarify their thoughts, explore the available options, and document the outcome.

<h3>Step 1: Propose the ADR Process</h3>

When you identify that the user is contemplating a significant design or architectural choice, propose using this process.

**Agent:** "This sounds like an important decision. To ensure we think it through and document it properly, I suggest we create an Architecture Decision Record (ADR). Would you like to start that process?"

<h3>Step 2: Define the Context and Problem</h3>

Collaborate with the user to fill out the `Context` and `Problem Statement` sections of the ADR. Ask probing questions to ensure clarity, identifying all relevant factors.

**Agent prompts:**
- "First, let's set the stage. What is the context here? What is the core problem we are trying to solve?"
- "What are the key functional and non-functional requirements (e.g., performance, security, scalability) that this decision must address?"
- "Are there any critical user journeys (CUJs) that will be impacted by this decision?"
- "What are the existing constraints, and what happens if we don't solve this problem?"

<h3>Step 3: Brainstorm and Document Options</h3>

Work with the user to identify and list at least two or three viable options. For each option, document a brief description, its pros, and its cons. Encourage detailed comparisons.

**Agent prompts:**
- "What are the different ways we could approach this? Let's list and briefly describe each viable option."
- "For each option, what are the main advantages and disadvantages? Consider technical feasibility, cost, complexity, and how it aligns with our existing architecture."
- "Can we do a quick feature comparison or cost/benefit analysis for each option?"
- "Have we considered any alternative technologies or simpler approaches that might fit?"

<h3>Step 4: Evaluate and Decide</h3>

Facilitate the user's decision-making process. The user is the final decider. Once they have chosen, document the choice and the comprehensive reasoning.

**Agent prompts:**
- "Now that we've thoroughly explored the options, which one do you believe is the best path forward?"
- "Let's articulate *why* this option was chosen. What makes it more suitable than the others, and why were the other options rejected?"
- "How does this decision align with our broader architectural principles and goals?"

<h3>Step 5: Analyze the Consequences</h3>

Prompt the user to think deeply about the future impact of this decision, covering all angles. Remind them that once accepted, ADRs are immutable and significant changes will require a new ADR to supersede this one. The ADR should be concise, ideally 1-2 pages.

**Agent prompts:**
- "What are the expected positive outcomes and benefits of this decision?"
- "What are the potential negative consequences, trade-offs, or new complexities we are accepting?"
- "Are there any risks associated with this decision, and if so, what are the mitigation strategies?"

<h3>Step 6: Generate the ADR File</h3>

Once all sections have been discussed, and the content is concise and clear:
1.  Ask the user for a short, descriptive title for the decision (e.g., "Use PostgreSQL for the primary database").
2.  Determine the next sequential ADR number by inspecting the `docs/design/DECISIONS/` directory.
3.  Create the filename in the format `NNNN-title-in-kebab-case.md` (e.g., `0002-use-postgresql-for-primary-database.md`).
4.  Assemble the information gathered in the previous steps into the ADR template, ensuring all relevant fields are populated including `Status`, `Date`, and `Author`.
5.  Write the final ADR content to the new file in `docs/design/DECISIONS/`.

**Agent:** "I have everything I need, and the content reflects our discussion. I will now generate the ADR document and save it to `docs/design/DECISIONS/`.