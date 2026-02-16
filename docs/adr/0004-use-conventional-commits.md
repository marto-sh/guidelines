---
number: 4
title: Use Conventional Commits
status: accepted
date: 2026-01-30
---

# Use Conventional Commits

## Context and Problem Statement

These guidelines aim to optimize codebases for agent-assisted development. [Bet 0001](../bets/0001-agents-reliably-make-atomic-changes.md) establishes that with appropriate setup—including explicit context, LLM-friendly specs, and proper tooling—AI agents can reliably make atomic code changes. A key question is: what commit message format best supports this goal?

Commit messages serve two purposes: searching history to understand past changes, and writing new commits. In both cases, predictability reduces cognitive load. When formats are consistent, agents (and humans) spend less effort parsing or deciding how to write messages. Inconsistent commit styles force agents to infer conventions or make arbitrary choices—both sources of potential errors.

A structured commit format also enables deterministic tooling: linters can validate messages before they're committed, and generators can produce conforming messages automatically. This shifts correctness from probabilistic (hoping the agent gets it right) to deterministic (tooling guarantees it).

## Decision Drivers

* **Predictability reduces agent cognitive load** — consistent formats mean less effort parsing or deciding how to write messages (see [Bet 0001](../bets/0001-agents-reliably-make-atomic-changes.md))
* **Training corpus prevalence** — LLMs have been trained on more Conventional Commits data than alternatives, improving generation accuracy
* **Machine parseability** — structured format enables automated changelog generation and semantic versioning
* **Deterministic validation** — tooling can guarantee correctness rather than relying on probabilistic LLM output
* **Reduced decision space** — fewer arbitrary choices means fewer opportunities for errors

## Considered Options

* Conventional Commits v1.0.0
* Gitmoji
* Jira Smart Commits
* Free-form with guidelines

## Decision Outcome

Chosen option: "Conventional Commits v1.0.0", because it is the most widely adopted structured commit convention, maximizing LLM training data exposure while enabling deterministic tooling for validation and generation.

### Consequences

* Good, because agents can reliably generate conforming commit messages
* Good, because commit history becomes machine-parseable for automated tooling
* Good, because validation can be deterministic via commit hooks and CI
* Bad, because it requires initial tooling setup (linter, hooks, CI workflow)
* Bad, because contributors must learn the convention (though tooling can assist)

### Confirmation

Compliance is enforced using [Cocogitto](https://docs.cocogitto.io/), a Rust-native Conventional Commits toolbox. This aligns with [ADR 0003](0003-use-rust-as-the-primary-programming-language.md) (Rust as primary language) and provides a single dependency-free binary.

Cocogitto enforces compliance through two mechanisms:

1. **Commit hooks**: A `commit-msg` hook validates messages locally before commits are created
2. **CI validation**: The Cocogitto GitHub Action validates all commit messages in pull requests, preventing merges of non-conforming commits

## Pros and Cons of the Options

### Conventional Commits v1.0.0

Format: `type(scope): description` (e.g., `feat(auth): add OAuth2 login`)

See [conventionalcommits.org](https://www.conventionalcommits.org/en/v1.0.0/)

* Good, because it is the most widely adopted structured format
* Good, because extensive tooling ecosystem for linting, validation, and automation
* Good, because LLMs have significant training data on this format
* Good, because machine-parseable for automated changelog generation
* Neutral, because requires learning the type vocabulary (feat, fix, docs, etc.)
* Bad, because adds friction for quick, informal commits

### Gitmoji

Format: `emoji description` (e.g., `🐛 Fix login bug`)

See [gitmoji.dev](https://gitmoji.dev/)

* Good, because visually scannable commit history
* Good, because intuitive for non-technical stakeholders
* Bad, because emoji selection adds cognitive overhead for agents
* Bad, because less machine-parseable than text-based formats
* Bad, because smaller training corpus for LLMs

### Jira Smart Commits

Format: `PROJ-123 #action description` (e.g., `AUTH-456 #done Add login`)

* Good, because tight integration with Jira issue tracking
* Good, because can trigger workflow transitions automatically
* Bad, because tightly coupled to Jira tooling
* Bad, because less readable without Jira context
* Bad, because limited adoption outside Jira-centric teams

### Free-form with guidelines

Format: Informal prose with documented conventions

* Good, because low friction for contributors
* Good, because flexible for edge cases
* Bad, because difficult to validate automatically
* Bad, because inconsistent in practice
* Bad, because agents must infer conventions from examples

## More Information

### Implementation

This decision requires:

1. Installing Cocogitto (`cargo install cocogitto` or via package manager)
2. Initializing Cocogitto in the repository (`cog init`)
3. Installing the `commit-msg` hook (`cog install-hook commit-msg`)
4. Adding the Cocogitto GitHub Action to validate PR commits

### Related Decisions

* [Bet 0001: Agents Reliably Make Atomic Changes](../bets/0001-agents-reliably-make-atomic-changes.md) — establishes the foundational belief that motivates this decision
* [ADR 0003: Use Rust as the Primary Programming Language](0003-use-rust-as-the-primary-programming-language.md) — Cocogitto chosen as tooling to align with Rust-first approach

### References

* [Conventional Commits Specification v1.0.0](https://www.conventionalcommits.org/en/v1.0.0/)
* [Cocogitto Documentation](https://docs.cocogitto.io/)