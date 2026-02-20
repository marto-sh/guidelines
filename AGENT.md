# Agent Instructions

This repository provides a set of guidelines, skills, and documentation to facilitate a robust and efficient agentic development process. It is designed to be included in other repositories to standardize and improve the performance of AI agents working on those codebases.

## Cross-Provider Compatibility

The guidelines and skills in this repository are designed to be cross-provider compatible. They should work with various AI agents and CLIs, including Gemini, OpenCode, Claude, Mistral's Vibe CLI, and others. The goal is to create a universal set of instructions that any capable agent can follow.

## Core Development Process

The development process heavily emphasizes Behavior-Driven Development (BDD) and Domain-Driven Design (DDD).

*   **BDD:** Please refer to the BDD skills located in `skills/bdd/` for authoring and implementing features.
*   **DDD:** For domain modeling and strategic design, consult the DDD skills in `skills/ddd/`.
*   **Development Process:** A detailed explanation of the development process can be found in `DEVELOPMENT_PROCESS.md`.

## Clarifying Requirements

When requirements are unclear or ambiguous, always seek clarification from the human user before proceeding. Do not make assumptions about the user's intent. Ask specific questions to ensure you understand:

*   The desired outcome and acceptance criteria
*   Any constraints or preferences
*   Edge cases or scenarios that need to be handled

**Use structured questions with multiple-choice options.** When clarification is needed, present questions with 2-4 clear choices and brief descriptions. Always allow for a custom response in case none of the options fit. Use your platform's dedicated tool if available (e.g., `AskUserQuestion` in Claude Code, `ask_user_question` in Mistral Vibe). If no dedicated tool exists, present numbered options in your text output.

**Group related questions into a single form.** When you have multiple related clarifications, group them (up to 4) into one form rather than asking them across separate responses. This:

*   Reduces back-and-forth overhead
*   Lets the user see the full scope of decisions needed
*   Keeps related choices together for coherent decision-making

**Keep questions focused and sequential.** If you have more than 4 questions, or if later questions depend heavily on earlier answers, split them across multiple form submissions. Ask the first batch, wait for answers, then ask follow-ups informed by those answers.

It is better to ask for clarification upfront than to deliver something that does not match the user's expectations.

## Research Before Recommending

Before designing experiments, proposing solutions, or making significant recommendations, conduct deep research on the topic:

*   **Search for existing work:** Use `WebSearch` to find academic papers, industry benchmarks, and prior art related to the problem domain. Someone may have already studied this question.
*   **Learn from established methodologies:** Look for standard approaches, common metrics, and known pitfalls in the relevant field.
*   **Share findings proactively:** Summarize relevant research for the user (e.g., "I found three papers studying this exact question..."). This grounds the conversation in evidence rather than speculation.
*   **Cite sources:** When research informs your recommendations, reference the sources so the user can evaluate them.

This research phase is especially important for:
*   Experiment design (avoid reinventing methodology)
*   Architecture decisions (learn from others' experiences)
*   Technology comparisons (find existing benchmarks)
*   Novel problem domains (understand the state of the art)

## Security Rules

The following rules are non-negotiable and apply to every task:

- **NEVER commit credentials.** API keys, tokens, passwords, private keys, and any other secrets must never appear in committed files. Use environment variables, shell profiles, or a secrets manager instead. If a file contains a credential (even a placeholder), do not stage or commit it.

## Skill Authoring

To maintain a high standard of skills, a dedicated skill for authoring new skills is available. Please refer to `skills/skill/authoring/SKILL.md` when you are tasked with creating a new skill. Adhering to this guide will ensure that new skills are well-defined, effective, and consistent with the existing skill set.

Before starting any task, please familiarize yourself with the relevant guidelines and skills in this repository.
