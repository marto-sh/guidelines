# Agent Instructions

This repository provides a set of guidelines, skills, and documentation to facilitate a robust and efficient agentic development process. It is designed to be included in other repositories to standardize and improve the performance of AI agents working on those codebases.

## Cross-Provider Compatibility

The guidelines and skills in this repository are designed to be cross-provider compatible. They should work with various AI agents and CLIs, including Gemini, OpenCode, Claude, Mistral's Vibe CLI, and others. The goal is to create a universal set of instructions that any capable agent can follow.

## Core Development Process

The development process heavily emphasizes Behavior-Driven Development (BDD) and Domain-Driven Design (DDD).

*   **BDD:** Please refer to the BDD skills located in `skills/bdd/` for authoring and implementing features.
*   **DDD:** For domain modeling and strategic design, consult the DDD skills in `skills/ddd/`.
*   **Development Process:** A detailed explanation of the development process can be found in `DEVELOPMENT_PROCESS.md`.

## Project Decisions

These rules are distilled from Architecture Decision Records in `docs/adr/`. For full context and rationale, read the linked ADR. See [ADR 0011](docs/adr/0011-distill-active-decisions-into-agent-instructions.md) for why and how this section is maintained.

### Language

*From [ADR 0003](docs/adr/0003-use-rust-as-the-primary-programming-language.md)*

*   Use **Rust** as the primary programming language for all new code
*   Leverage the compiler as a feedback loop — fix all compiler errors and Clippy warnings before considering a change complete
*   Prefer Rust-native crates when available; Python interop is permitted for ML/AI when no Rust alternative exists

### Commits

*From [ADR 0004](docs/adr/0004-use-conventional-commits.md)*

*   Use **Conventional Commits** format: `type(scope): description`
*   Valid types: `feat`, `fix`, `docs`, `style`, `refactor`, `perf`, `test`, `build`, `ci`, `chore`, `revert`
*   Commit messages are validated by Cocogitto hooks and CI — non-conforming commits will be rejected

### Git Workflow

*From [ADR 0009](docs/adr/0009-use-a-tiered-commit-and-pr-structure.md)*

*   **Atomic commits**: each commit is one logical change, describable without the word "and." Every commit must leave the codebase in a passing state (compiles, tests pass)
*   **Logical PRs**: a coherent, reviewable unit of work composed of atomic commits. When a logical PR merges, its atomic commits are **squashed** into a single commit
*   **Feature PRs**: the top-level PR merging into main. Composed of logical-level commits. Merged with **`--no-ff`** (merge commit)
*   Use **stacked PRs** when a feature requires multiple logical PRs
*   Navigate history: `git log --first-parent` for feature-level view, `git log <merge>^1..<merge>^2` for logical-level view

### Multi-Agent Collaboration

*From [ADR 0006](docs/adr/0006-design-processes-and-tools-for-multi-agent-collaboration.md)*

*   **Favor isolation over coordination**: structure work so agents can operate independently rather than requiring synchronization
*   **Design for context flow**: ensure outputs are machine-readable and provide sufficient context for downstream agents without human translation
*   When designing or evaluating a process, ask: can multiple agents execute this simultaneously without conflicts? What boundaries prevent interference? How does output become input for the next agent?

## Clarifying Requirements

When requirements are unclear or ambiguous, always seek clarification from the human user before proceeding. Do not make assumptions about the user's intent. Ask specific questions to ensure you understand:

*   The desired outcome and acceptance criteria
*   Any constraints or preferences
*   Edge cases or scenarios that need to be handled

**Use structured questions with multiple-choice options.** When clarification is needed, present questions with 2-4 clear choices and brief descriptions. Always allow for a custom response in case none of the options fit. Use your platform's dedicated tool if available (e.g., `AskUserQuestion` in Claude Code, `ask_user_question` in Mistral Vibe). If no dedicated tool exists, present numbered options in your text output.

**Always use the structured question tool.** When asking questions, always use the platform's dedicated tool (e.g., `AskUserQuestion` in Claude Code). Never dump multiple questions as inline text — use the form-based interface so the user can respond to each question individually with options and notes.

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
