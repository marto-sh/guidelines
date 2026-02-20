---
number: 11
title: Distill Active Decisions into Agent Instructions
status: proposed
date: 2026-02-17
---

# Distill Active Decisions into Agent Instructions

## Context and Problem Statement

These guidelines produce Architecture Decision Records (ADRs) that capture significant technical and process decisions. Each ADR documents context, alternatives, trade-offs, and consequences — optimized for human review and future reference. However, AI coding agents — the primary consumers of these guidelines ([ADR 0006](0006-design-processes-and-tools-for-multi-agent-collaboration.md)) — need a different artifact: a concise set of actionable rules they can apply immediately without parsing hundreds of lines of deliberation across multiple files.

Today, `AGENT.md` does not reference any ADR. An agent starting a session has no way to discover that it should use Conventional Commits ([ADR 0004](0004-use-conventional-commits.md)), merge feature PRs with `--no-ff` ([ADR 0009](0009-use-a-tiered-commit-and-pr-structure.md)), or design for multi-agent collaboration ([ADR 0006](0006-design-processes-and-tools-for-multi-agent-collaboration.md)) — unless it independently reads all ADR files. This wastes context window tokens, risks agents missing or misinterpreting decisions, and produces inconsistent behavior across sessions.

How should active architectural decisions be communicated to agents so they can apply the rules efficiently and reliably?

## Decision Drivers

* **Agent effectiveness** — agents must reliably apply project decisions without reading every ADR; wrong or missed decisions produce incorrect code
* **Token efficiency** — agent context windows are finite and costly; the format should minimize tokens while maximizing actionable content
* **Maintainability** — the summary must stay in sync with ADRs over time without becoming a burden or drifting silently
* **Cross-provider compatibility** — rules should work across Claude Code, Gemini CLI, Copilot, and other agents (aligns with [ADR 0006](0006-design-processes-and-tools-for-multi-agent-collaboration.md) and `AGENT.md`'s existing cross-provider stance)
* **Editorial quality over mechanical completeness** — rules should reflect what agents actually need, shaped by observed mistakes, not a mechanical dump of every ADR

## Considered Options

* Curated rules in AGENT.md with same-commit convention
* Auto-generated rules from structured ADR sections
* Separate decision register file
* Let agents read ADRs on demand

## Decision Outcome

Chosen option: "Curated rules in AGENT.md with same-commit convention", because it provides the best agent effectiveness through editorially curated, workflow-grouped rules while keeping sync lightweight and avoiding tooling complexity.

The approach has three components:

**1. A "Project Decisions" section in `AGENT.md`.** Active ADR decisions are distilled into imperative, bulleted rules grouped by workflow concern (e.g., all git-related rules together, regardless of which ADR produced them). Each rule group links back to its source ADR(s) for full context. The rules use imperative voice and concrete examples where applicable — the format research shows agents follow most reliably.

**2. Same-commit convention.** When an ADR is created, accepted, or modified in a way that changes its operational rules, the corresponding rules in `AGENT.md` must be updated in the same commit. This keeps the two artifacts in sync without tooling.

**3. CI-required manual confirmation.** A CI check triggers when files in `docs/adr/` are modified in a pull request. The check requires a reviewer to manually confirm that `AGENT.md` was considered and updated if needed. The reviewer may dismiss the check if the ADR change does not affect agent-facing rules (e.g., fixing a typo). This catches the one failure mode of the same-commit convention — forgetting — without constraining how the rules are written.

### Consequences

* Good, because agents get actionable rules in ~50 lines instead of parsing ~500+ lines across multiple ADR files
* Good, because rules are grouped by workflow concern (how agents think) rather than by ADR number (how decisions are organized)
* Good, because human curation ensures only operationally relevant rules reach agents, shaped by observed agent behavior
* Good, because `AGENT.md` is already the agent entry point — no new file to discover or maintain
* Good, because the CI manual confirmation check catches forgotten updates without adding tooling complexity
* Good, because each rule links back to its source ADR, preserving traceability for agents or humans who need full context
* Bad, because manual curation requires editorial judgment — what constitutes an "agent-facing rule" is subjective
* Bad, because the same-commit convention is a team discipline, not a guarantee — the CI check mitigates but does not eliminate drift risk
* Bad, because not all ADRs produce agent-facing rules, so the CI check will sometimes require reviewers to dismiss it for non-agent-facing ADR changes
* Neutral, because the approach scales well for the current number of ADRs (~10) but may need revisiting if the project grows to 50+ active ADRs

### Confirmation

Compliance is enforced through three mechanisms:

1. **Same-commit convention**: when an ADR is created or modified in a way that changes its operational rules, the corresponding `AGENT.md` section must be updated in the same commit
2. **Pre-commit hook**: a hook detects when files in `docs/adr/` are staged but `AGENT.md` is not. In interactive terminals (human), it prompts for explicit confirmation ("Did you verify that AGENT.md does not need updating? [y/N]"). In non-interactive environments (agent), it blocks the commit with instructions to either stage `AGENT.md` or set `AGENTMD_VERIFIED=1` to acknowledge no update is needed. This gives immediate local feedback before code ever reaches CI
3. **CI manual confirmation**: a CI check triggers on any PR that modifies files in `docs/adr/`. The check creates a required review status that a reviewer must manually approve, confirming that `AGENT.md` was considered. The reviewer dismisses the check if the ADR change has no agent-facing impact

## Pros and Cons of the Options

### Curated rules in AGENT.md with same-commit convention

Manually distill active ADR decisions into imperative rules in `AGENT.md`, grouped by workflow concern. Update both artifacts in the same commit. CI requires manual reviewer confirmation when ADR files change.

* Good, because editorial curation produces higher-quality agent context than mechanical extraction
* Good, because grouping by workflow concern matches how agents encounter decisions (during commits, during coding, etc.)
* Good, because `AGENT.md` is already loaded by all major agent platforms — no additional discovery mechanism needed
* Good, because static context outperforms dynamic retrieval for agent effectiveness (see More Information)
* Good, because CI manual check catches forgotten updates without constraining content
* Neutral, because requires editorial judgment about what to include — but this judgment is precisely what makes the output effective
* Bad, because two artifacts must be kept in sync manually
* Bad, because "agent-facing" is subjective — different editors may include or exclude different rules

### Auto-generated rules from structured ADR sections

Add a machine-readable section (e.g., `### Agent Rules`) to each ADR. A script or pre-commit hook extracts these sections and assembles them into `AGENT.md`.

* Good, because single source of truth — rules live in the ADR, no manual sync needed
* Good, because forces ADR authors to think about agent-facing rules at decision time
* Good, because deterministic — same input always produces same output
* Bad, because auto-generated text lacks editorial cohesion — reads like a dump, not curated guidance
* Bad, because rules from different ADRs cannot be grouped by workflow concern without a complex mapping layer
* Bad, because distillation inherently requires editorial judgment that a parser cannot provide
* Bad, because adds tooling complexity (script, hook, or CI step) that must be maintained
* Bad, because some ADRs produce zero agent rules, making the mandatory section feel forced

### Separate decision register file

Maintain a standalone `docs/adr/REGISTER.md` as a table with columns: ID, one-line decision, status. Agents read this file instead of individual ADRs.

* Good, because follows the arc42 Section 9 pattern — established in architecture documentation practice
* Good, because provides a quick overview of all decisions in one place
* Good, because useful for humans as well as agents
* Bad, because a register captures metadata (what was decided) but not operational rules (what to do)
* Bad, because ordered by ADR number, not by workflow concern — agents must scan the entire table to find relevant rules
* Bad, because introduces a third artifact (ADRs + AGENT.md + REGISTER.md) to keep in sync
* Bad, because one-line summaries are too terse to guide agent behavior — "Use Conventional Commits" doesn't tell an agent the format is `type(scope): description`

### Let agents read ADRs on demand

No summary file. Agents discover ADRs via `docs/adr/README.md` and read the relevant ones at runtime.

* Good, because ADRs are the single source of truth — no sync problem
* Good, because agents always see the full context and rationale
* Good, because zero maintenance overhead
* Bad, because agents consume 500+ tokens reading each ADR, most of which is rationale they don't need operationally
* Bad, because agents must decide which ADRs are relevant to their current task — a judgment call that may be unreliable
* Bad, because Spotify's research found static prompts outperform dynamic tool-based context retrieval for agent effectiveness
* Bad, because inconsistent — different sessions may read different subsets of ADRs, producing inconsistent behavior

## More Information

### Research Context

This decision is informed by recent research on context engineering for AI coding agents:

* **Anthropic** ([Effective Context Engineering for AI Agents](https://www.anthropic.com/engineering/effective-context-engineering-for-ai-agents)) recommends "minimal but complete" context — the smallest set of information that fully outlines expected behavior. Examples and imperative rules outperform prose explanations.
* **Spotify** ([Context Engineering for Background Coding Agents](https://engineering.atspotify.com/2025/11/context-engineering-background-coding-agents-part-2)) found that larger static prompts outperform dynamic tool-based context retrieval for predictability and quality. They recommend tailoring context to the agent and defining verifiable goals.
* **Martin Fowler / Birgitta Boeckeler** ([Context Engineering for Coding Agents](https://martinfowler.com/articles/exploring-gen-ai/context-engineering-coding-agents.html)) advise building rules incrementally based on real agent mistakes rather than front-loading everything. "There are no unit tests for context engineering."

### Formatting Guidelines

Based on the research, the "Project Decisions" section in `AGENT.md` should follow these formatting principles:

* **Imperative bullets** — "Use Conventional Commits: `type(scope): description`" not "We decided to adopt Conventional Commits because..."
* **Code examples where applicable** — agents follow demonstrated patterns more reliably than prose descriptions
* **Grouped by workflow concern** — all git/commit rules together, all coding rules together, regardless of source ADR
* **Link to source ADR** — each group references its ADR(s) for traceability
* **No rationale** — the rules section says what to do, not why; the ADR provides the why

### Why Not Auto-Generate

The core insight is the distinction between **sync** (keeping two representations of the same thing consistent) and **distillation** (extracting actionable essence from a richer source). Sync can be automated; distillation requires judgment. Key reasons:

* Rules from multiple ADRs may need to be combined under one workflow concern (e.g., git rules come from both ADR 0004 and ADR 0009)
* Some ADRs produce zero agent-facing rules (e.g., ADR 0001 "Record architecture decisions" is meta-process)
* The rules that matter operationally are shaped by observed agent behavior, not by ADR structure
* Effective agent context requires the "Goldilocks zone" between overly prescriptive and insufficiently specific — a balance that requires editorial judgment

### Relationship to Existing Decisions

* [ADR 0004: Use Conventional Commits](0004-use-conventional-commits.md) — an example of an ADR that produces concrete agent-facing rules (commit message format)
* [ADR 0006: Design Processes and Tools for Multi-Agent Collaboration](0006-design-processes-and-tools-for-multi-agent-collaboration.md) — establishes that processes should support multiple agents; this ADR ensures agents share a consistent understanding of project decisions
* [ADR 0008: Share Guidelines Across Projects](0008-share-guidelines-across-projects.md) — the distilled rules in `AGENT.md` travel with the guidelines repository when shared across projects
* [ADR 0009: Use a Tiered Commit and PR Structure](0009-use-a-tiered-commit-and-pr-structure.md) — an example of an ADR that produces multiple agent-facing rules (commit scope, merge strategy)

### Cross-Platform Compatibility

The `AGENT.md` file is already designed for cross-provider consumption. The emerging [AGENTS.md](https://agents.md/) standard (backed by the Linux Foundation's Agentic AI Foundation, supported by Claude Code, Copilot, Cursor, Gemini CLI, Codex, and others) validates the approach of consolidating agent instructions in a single, well-known file at the repository root.
