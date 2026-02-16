---
number: 6
title: Design Processes and Tools for Multi-Agent Collaboration
status: proposed
date: 2026-02-02
---

# Design Processes and Tools for Multi-Agent Collaboration

## Context and Problem Statement

These guidelines aim to optimize codebases for agent-assisted development. [Bet 0001](../bets/0001-agents-reliably-make-atomic-changes.md) establishes that with appropriate setup, AI agents can reliably make atomic code changes. A key strength of agents is scalability—unlike human developers, we can run multiple agents in parallel. However, this potential remains untapped if our processes and tools are designed only for single-agent or human workflows.

Just as organizations develop processes and tools that enable efficient human team collaboration (code review, branching strategies, CI/CD), we should deliberately design processes that enable efficient multi-agent collaboration—and collaboration between agents and humans.

Three challenges motivate this decision:

1. **Wasted resources**: Agents may produce conflicting outputs, requiring rework or human arbitration. Without explicit design for multi-agent work, we lose the efficiency gains that parallelization should provide.

2. **Context discontinuity**: When one agent's output needs to become another agent's input (e.g., Agent A writes code, Agent B reviews it), ad-hoc handoffs create friction and lose context.

3. **Coordination overhead**: Human-mediated coordination doesn't scale. If humans must orchestrate every multi-agent interaction, the benefits of agent parallelization are offset by coordination costs.

## Decision Drivers

* **Resource efficiency** — agents should not waste compute and tokens on conflicts or rework; parallelization should yield proportional throughput gains
* **Quality synergy** — multiple agents working together should produce better output than agents working alone (e.g., review, verification, diverse approaches)
* **Context portability** — outputs from one agent should flow naturally as inputs to another without manual translation
* **Isolation** — agents should be able to work independently without stepping on each other's toes
* **Measurability** — multi-agent effectiveness should be quantifiable through metrics like throughput, conflict rate, and human oversight cost
* **Alignment with Bet 0001** — investment in multi-agent infrastructure is amortized across all future parallel work (setup as force multiplier)

## Considered Options

* **Single-agent focus** — optimize purely for individual agent workflows, handle multi-agent scenarios ad-hoc
* **Human-mediated coordination** — humans orchestrate all agent coordination rather than building it into processes
* **Agent-agnostic processes** — use standard human collaboration patterns without agent-specific adaptations
* **Multi-agent first design** — explicitly design processes and tools to support parallel agent work from the start

## Decision Outcome

Chosen option: **Multi-agent first design**, because the leverage from reliable atomic changes (Bet 0001) multiplies with parallelization. Designing for multi-agent collaboration from the start avoids retrofitting processes later and ensures we capture the full efficiency potential of agent-assisted development.

This means:

1. **Evaluate processes for multi-agent impact**: When designing or adopting any process, explicitly ask: "How does this work with multiple agents in parallel?"

2. **Favor isolation over coordination**: Where possible, structure work so agents can operate independently rather than requiring synchronization.

3. **Design for context flow**: Ensure outputs are machine-readable and provide sufficient context for downstream agents without human translation.

4. **Measure multi-agent metrics**: Track throughput scaling, conflict rates, and human oversight costs as first-class metrics.

### Consequences

* **Good**, because we capture efficiency gains from parallelization that would otherwise be lost to conflicts
* **Good**, because context portability enables agent-to-agent workflows (e.g., one agent writes, another reviews) with minimal friction
* **Good**, because upfront design is cheaper than retrofitting processes after they've created coordination debt
* **Good**, because measurable metrics enable continuous improvement of multi-agent effectiveness
* **Bad**, because multi-agent considerations add complexity to process design—some processes may be over-engineered for current single-agent use
* **Bad**, because isolation-first thinking may miss opportunities for beneficial tight coupling within a unit of work (e.g., pair debugging, rubber duck review)
* **Neutral**, because this ADR establishes principles rather than prescribing specific implementations—follow-up ADRs will address concrete mechanisms

### Confirmation

This decision will be validated through:

1. **Throughput metrics**: When running N agents in parallel on independent tasks, achieve >80% of theoretical Nx throughput
2. **Conflict rate**: <5% of multi-agent sessions require human intervention to resolve agent conflicts
3. **Handoff success**: Agent-to-agent workflows (e.g., write then review) complete without manual context translation
4. **Process adoption**: Each new process ADR includes a "Multi-agent considerations" section
5. **6-month review**: Evaluate whether multi-agent first design is justified by actual multi-agent usage

## Pros and Cons of the Options

### Single-agent focus

Optimize for individual agent workflows. Handle multi-agent scenarios as edge cases.

* Good, because simplest approach—no coordination overhead to design
* Good, because matches current usage pattern (single-agent development)
* Neutral, because can be extended to multi-agent later if needed
* Bad, because misses efficiency gains from parallelization
* Bad, because ad-hoc multi-agent coordination creates inconsistent patterns
* Bad, because technical debt accumulates as multi-agent usage grows

### Human-mediated coordination

Let humans handle all agent coordination. Agents work independently; humans manage handoffs.

* Good, because humans can handle nuanced coordination decisions
* Good, because no need to encode coordination logic into processes
* Neutral, because works for low-frequency multi-agent scenarios
* Bad, because doesn't scale—human coordination becomes bottleneck
* Bad, because defeats purpose of agent efficiency if humans must intervene constantly
* Bad, because coordination knowledge stays tacit rather than encoded in processes

### Agent-agnostic processes

Use standard human collaboration patterns (Git, PR reviews, CI/CD) without agent-specific adaptations.

* Good, because leverages proven patterns that work for human teams
* Good, because no additional process design effort
* Good, because agents can follow human processes to some degree
* Neutral, because some patterns (async code review) translate well to agents
* Bad, because human processes assume capabilities agents lack (nuanced judgment, implicit context)
* Bad, because human processes may include unnecessary friction for agents (waiting for approval, manual steps)
* Bad, because misses agent-specific opportunities (perfect parallelization, instant context sharing)

### Multi-agent first design

Explicitly design processes and tools to support parallel agent work.

* Good, because captures parallelization efficiency that is agents' key advantage
* Good, because context portability enables sophisticated agent pipelines
* Good, because measurable metrics enable continuous improvement
* Good, because aligns with Bet 0001's investment-in-setup philosophy
* Neutral, because requires upfront design effort that may not pay off immediately
* Bad, because adds complexity to process design
* Bad, because may over-optimize for multi-agent scenarios not yet realized

## More Information

### Evaluation Metrics

Multi-agent friendly processes should be evaluated on:

| Metric | Definition | Target |
|--------|------------|--------|
| **Throughput scaling** | Tasks completed per hour with N agents vs 1 agent | >80% linear (4 agents = 3.2x throughput) |
| **Conflict rate** | % of multi-agent sessions requiring human conflict resolution | <5% |
| **Handoff friction** | Manual steps required to pass work between agents | 0 (automated) |
| **Human oversight cost** | Human hours spent coordinating per agent hour | <10% |
| **Context loss** | Information lost in agent-to-agent handoffs | Minimal (qualitative) |

### Multi-Agent Considerations Checklist

When designing or evaluating a process, ask:

1. **Parallelization**: Can multiple agents execute this process simultaneously without conflicts?
2. **Isolation**: What boundaries prevent agents from interfering with each other?
3. **Context flow**: How does output from this process become input for the next?
4. **Failure isolation**: If one agent fails, does it affect others?
5. **Metrics**: How do we measure this process's multi-agent effectiveness?

### Connection to Existing Decisions

* **[Bet 0001](../bets/0001-agents-reliably-make-atomic-changes.md)**: Multi-agent collaboration amplifies the value of reliable atomic changes. If one agent can reliably complete a task, N agents can complete N independent tasks.
* **[ADR 0003 - Rust](0003-use-rust-as-the-primary-programming-language.md)**: Strong typing catches conflicts at compile time, providing a safety net for merging multi-agent outputs.
* **[ADR 0004 - Conventional Commits](0004-use-conventional-commits.md)**: Consistent commit format enables automated tracking of multi-agent contributions.
* **[ADR 0005 - Nix Devcontainers](0005-use-nix-based-devcontainers-for-development-environments.md)**: Reproducible environments ensure all agents operate identically.

### Note on Tight Coupling

While this ADR favors isolation, tight coupling between agents may be appropriate within a unit of work:

* **Pair debugging**: One agent proposes, another critiques
* **Review workflows**: One agent writes, another reviews
* **Rubber duck**: One agent explains its reasoning to another

The principle is isolation between *independent* work units, not within collaborative tasks.
