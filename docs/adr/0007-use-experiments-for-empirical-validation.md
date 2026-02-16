---
number: 7
title: Use Experiments for Empirical Validation
status: proposed
date: 2026-02-02
---

# Use Experiments for Empirical Validation

## Context and Problem Statement

BETs document foundational beliefs that guide our decisions, and ADRs record the decisions themselves. However, both can rest on untested assumptions. For example, [Bet 0001](../bets/0001-agents-reliably-make-atomic-changes.md) asserts that with good tooling, agents can reliably make atomic changes. [ADR 0003](0003-use-rust-as-the-primary-programming-language.md) chose Rust partly for its type safety benefits for agent-assisted development. But we haven't empirically validated whether Rust actually yields better agent outcomes than other languages.

This gap matters for several reasons:

1. **Uncertainty**: We make decisions based on assumptions that could be tested but aren't.
2. **Evolving landscape**: What's true with one AI architecture may not hold with the next. Conclusions need periodic revalidation.
3. **Continuous improvement**: Without empirical feedback, we can't systematically improve our processes and tools for agent-assisted development.
4. **Knowledge loss**: Failed approaches and inconclusive investigations go undocumented, leading to repeated exploration of dead ends.

## Decision Drivers

* **Reduce uncertainty** — decisions should be informed by evidence, not just intuition
* **Support AI research** — the framework should enable rigorous, reproducible experiments
* **Automation-first** — experiments should be runnable by agents with minimal human involvement
* **Reproducibility** — experiments must be re-runnable as the AI landscape evolves
* **Document all outcomes** — successful, unsuccessful, and inconclusive experiments all have value
* **Quantitative preference** — measurable outcomes are preferred; qualitative assessments should be automatable when possible

## Considered Options

* **Ad-hoc validation** — test assumptions informally without structured documentation
* **Extend BETs with validation sections** — add experiment results directly to BET documents
* **Extend ADRs with validation sections** — add experiment results directly to ADR documents
* **Dedicated Experiments framework** — create a separate document type for empirical validation

## Decision Outcome

Chosen option: **Dedicated Experiments framework**, because experiments have distinct lifecycle, structure, and purpose from BETs and ADRs. Experiments are reproducible procedures with multiple runs over time, while BETs and ADRs are point-in-time decisions.

This means:

1. **New document type**: Experiments live in `docs/experiments/` with their own structure and lifecycle.

2. **Clear relationships**: Experiments can provide evidence toward BETs, validate ADR assumptions, test feature ideas, or stand alone. Both successful and unsuccessful experiments can trigger actions.

3. **Reproducible by design**: Each experiment has a stable definition with a `runs/` subdirectory tracking execution history. Experiments can be re-run as AI models and tools evolve.

4. **Automation-ready**: Experiments are designed to be executed by agents via a single command, with human review required before execution.

### Consequences

* **Good**, because empirical evidence improves decision quality
* **Good**, because reproducibility enables revalidation as AI evolves
* **Good**, because documenting all outcomes (including failures) prevents repeated dead ends
* **Good**, because automation-first design aligns with agent-assisted development philosophy
* **Good**, because separation from BETs/ADRs keeps each document type focused
* **Bad**, because adds another document type to maintain
* **Bad**, because requires discipline to actually run experiments rather than just documenting hypotheses
* **Neutral**, because value depends on actually using the framework—an unused framework provides no benefit

### Confirmation

This decision will be validated through:

1. **Framework usage**: At least 3 experiments created within 3 months of adoption
2. **Re-run execution**: At least 1 experiment re-run after an AI model update
3. **Decision impact**: At least 1 ADR or BET influenced by experiment results
4. **Inconclusive tracking**: Framework captures at least 1 inconclusive or negative result
5. **6-month review**: Evaluate whether the framework is providing value or just adding overhead

## Pros and Cons of the Options

### Ad-hoc validation

Test assumptions informally without structured documentation.

* Good, because zero overhead—just try things
* Good, because flexible—no process to follow
* Bad, because results are lost—no documentation of what was tried
* Bad, because not reproducible—can't re-run the same test
* Bad, because no accountability—easy to skip validation entirely
* Bad, because knowledge stays tacit rather than explicit

### Extend BETs with validation sections

Add experiment methodology and results directly to BET documents.

* Good, because keeps related information together
* Good, because no new document type to learn
* Neutral, because BETs are about beliefs, not empirical procedures
* Bad, because BETs become bloated with experimental data
* Bad, because multiple runs over time don't fit BET structure
* Bad, because standalone experiments (not tied to BETs) have no home

### Extend ADRs with validation sections

Add experiment methodology and results directly to ADR documents.

* Good, because validation is close to the decision it informs
* Good, because ADRs already have a "Confirmation" section
* Neutral, because some experiments may inform ADRs
* Bad, because ADRs are point-in-time decisions, experiments evolve over time
* Bad, because experiments that precede ADRs don't fit this model
* Bad, because standalone experiments have no home

### Dedicated Experiments framework

Create a separate document type with its own structure and lifecycle.

* Good, because experiments have unique needs (reproducibility, multiple runs, automation)
* Good, because keeps BETs and ADRs focused on their purpose
* Good, because supports standalone experiments not tied to other documents
* Good, because clear structure aids agent execution
* Neutral, because adds another document type to the ecosystem
* Bad, because requires learning a new format
* Bad, because relationships between documents must be maintained manually

## More Information

### Experiment Structure

Each experiment is a directory under `docs/experiments/` with date-based naming:

```
docs/experiments/
├── EXPERIMENT.template.md
└── 2024-02-rust-comparison/
    ├── EXPERIMENT.md       # Main document (YAML frontmatter + sections)
    ├── scripts/            # Automation (single command to run)
    ├── assets/             # Supporting materials
    └── runs/               # Execution history
        └── 2024-02-15-run.md
```

### Main Document Sections

1. **YAML Frontmatter**: id, title, date, authors, progress_status, outcome_status
2. **Hypothesis & Rationale**: What we're testing and why
3. **Protocol/Methodology**: Step-by-step procedure (for agent execution)
4. **Success Criteria**: Measurable outcomes (quantitative preferred)
5. **Prerequisites/Setup**: What's needed before running
6. **Related Work**: Links to BETs, ADRs, features, external research
7. **Conclusion**: Findings and recommendations (filled after runs)

### Status Lifecycle

**Progress status**: `proposed` → `designed` → `running` → `completed`

**Outcome status**: `validated` | `invalidated` | `inconclusive`

### Execution Model

1. Human designs experiment (with agent assistance)
2. Human reviews and approves
3. Agent executes via single command
4. Results recorded in `runs/` subdirectory
5. Experiment can be re-run when conditions change (new AI model, etc.)

### Relationship to Other Documents

```
BET (broad belief)
 └── Experiment (focused test) ──→ Evidence for/against BET
      └── May trigger: new ADR, updated BET, backlog item

ADR (decision)
 └── Experiment (validation) ──→ Confirms or challenges decision
      └── May trigger: ADR superseded, new ADR

Feature (capability)
 └── Experiment (feasibility) ──→ Should we build this?
      └── May trigger: proceed, pivot, or abandon

Standalone Experiment ──→ Learning/curiosity
 └── May trigger: new BET, new ADR, new feature idea
```

### Example: Rust vs Other Languages

An experiment to test whether Rust yields better agent outcomes:

- **Hypothesis**: Rust's type system reduces agent errors compared to Python
- **Protocol**: Same coding tasks executed by same agent in both languages, measuring error rate and iteration count
- **Success criteria**: ≥20% reduction in errors or iterations with Rust
- **Triggers**: Re-run when new Claude model releases
- **Outcome impact**: If invalidated, reconsider ADR 0003
