---
number: 14
title: Use Dual-Structure Format for Research Literature Reviews
status: proposed
date: 2026-02-22
---

# Use Dual-Structure Format for Research Literature Reviews

## Context and Problem Statement

[ADR 0013](0013-use-three-layer-research-process-for-exploratory-learning.md) established a three-layer research process (index + literature review + brief) for exploratory learning. However, it left the format of the literature review undefined — what sections should it contain, how should information be organized, and what makes a review useful for both agent retrieval and human comprehension?

Literature reviews in academia follow established traditions (systematic reviews with PRISMA, scoping reviews with PRISMA-ScR, state-of-the-art reviews, narrative reviews), but our use case is distinct: reviews are **produced by agents**, consumed by **both agents and humans**, and must serve as a **durable, queryable knowledge base** rather than a standalone academic publication. We need a format that borrows from established practice where it fits and adapts where it doesn't.

The format choice is consequential — it determines how agents conduct research, how findings are stored and retrieved, how documents age, and how useful they are when consulted for follow-up questions months later.

## Decision Drivers

* **Agent retrievability** — concepts and themes must be independently queryable, not scattered across unrelated sections
* **Grounded knowledge over prior knowledge** — the review provides sourced facts agents draw on instead of training data
* **Epistemic honesty** — explicit about what is known, unknown, and uncertain
* **Actionability** — research bridges to existing processes (experiments, ADRs, BETs)
* **High rigor, low overhead** — search methodology documented once (in the research skill), not repeated per document
* **Source auditability** — track what was visited, not just what was cited
* **Context efficiency** — agents should load only what they need (progressive disclosure within the artifact)
* **Freshness awareness** — provenance and staleness signals built into the format

## Considered Options

* **Option A: Thematic Landscape** — flat thematic sections, each analyzing a cross-cutting pattern
* **Option B: Concept-Map** — self-contained concept entries with fixed fields and a synthesis section
* **Option C: Landscape + Synthesis** — thematic sections plus a dedicated synthesis and implications layer
* **Option D: Findings-Led** — prioritized key findings first, supporting thematic analysis second
* **Option E: Dual-Structure (Concepts + Themes)** — concepts and themes as dual first-class sections, with synthesis, gaps, and implications

## Decision Outcome

Chosen option: **"Option E: Dual-Structure (Concepts + Themes)"**, because it is the only option that makes both concepts and themes independently retrievable. Options A, C, and D scatter concepts across themes. Option B scatters themes across concepts. Option E resolves this symmetrical problem by giving both dimensions their own sections.

The format emerged from iteratively exploring the other four options and identifying what each does well:

- From Option A: the "Gaps & Open Questions" section for epistemic honesty
- From Option B: first-class concept entries with structured fields for agent retrieval
- From Option C: dedicated Synthesis and Implications sections for deeper analysis and actionability
- From Option D: an Abstract as cached synthesis (retrieval optimization for agents, quick overview for humans)

### Consequences

* Good, because agents can retrieve individual concepts (definitions, current state) without scanning the entire document
* Good, because cross-cutting themes (trends, convergences, tensions) have their own retrievable sections rather than being fragmented across concept entries
* Good, because the Abstract provides cached synthesis — agents don't need to re-process the full document for summary questions
* Good, because Gaps & Open Questions makes the limits of knowledge explicit, preventing agents from presenting findings with false confidence
* Good, because Implications bridges research to action (experiments, ADRs, BETs), integrating with existing processes
* Good, because the companion sources log keeps the main document focused while preserving the full audit trail
* Bad, because the format has more sections than any single academic tradition — higher production overhead per document
* Bad, because maintaining consistency between Concepts, Themes, and Synthesis requires discipline — the same information could drift across sections
* Bad, because the dual-structure is novel — there is no established tradition to draw on for guidance when edge cases arise
* Neutral, because the format is more complex than a simple thematic review, but agents producing the documents can handle the complexity

### Confirmation

Compliance can be confirmed by:
- Checking that literature review files contain all required sections (Abstract, Concepts, Themes, Synthesis, Gaps & Open Questions, Implications, References)
- Verifying that each concept entry includes the required fields (Definition, Current state, Key sources, Relates to)
- Confirming that a companion `sources-log.md` exists alongside each literature review
- Validating YAML frontmatter includes provenance fields (date, last_updated, produced_by, freshness, methodology_version)

A future validation tool (similar to `adrs doctor`) could automate these checks.

## Pros and Cons of the Options

### Option A: Thematic Landscape

Flat thematic sections, each analyzing a cross-cutting pattern with inline citations. Followed by Gaps & Open Questions. Inspired by traditional narrative and scoping reviews.

* Good, because simple and flat — low ceremony, easy to scan
* Good, because themes naturally capture cross-cutting patterns and trends
* Good, because familiar to anyone who has read a scoping review
* Bad, because concepts are scattered across themes — not independently retrievable
* Bad, because assumes the reader already knows the domain vocabulary
* Bad, because an agent needing a specific concept definition must scan all themes to find it

### Option B: Concept-Map

Self-contained concept entries with fixed internal structure (Definition, Current state, Key sources, Relates to), plus a Synthesis section connecting them. Inspired by knowledge graphs and Zettelkasten.

* Good, because concepts are first-class and independently retrievable
* Good, because definitions are explicit and sourced — no reliance on prior knowledge
* Good, because easy to update incrementally — add or modify one concept without touching the rest
* Good, because "Relates to" links create a navigable structure
* Neutral, because fixed fields per concept may not always fit — some concepts are better explained as narratives
* Bad, because cross-cutting themes (trends, convergences) have no natural home — they get scattered across concept entries or dumped into Synthesis
* Bad, because "Relates to" is shallow — states that things relate but not how

### Option C: Landscape + Synthesis

Thematic landscape sections for depth, plus dedicated Synthesis and Gaps & Implications sections. An extension of Option A with more analytical structure.

* Good, because the Synthesis section forces articulation of what it all means together
* Good, because Gaps & Implications bridges research to action
* Good, because thematic sections capture cross-cutting patterns well
* Bad, because same concept-retrieval problem as Option A — concepts scattered across themes
* Bad, because Synthesis can be redundant with well-written thematic sections
* Neutral, because adds analytical depth at the cost of a longer document

### Option D: Findings-Led

Prioritized key findings first, supporting thematic analysis second. Inspired by intelligence briefings and executive summaries ("bottom line up front").

* Good, because prioritization is built into the structure — most important things come first
* Good, because Key Findings section is almost a brief already — useful for generating the human-facing brief
* Good, because a reader or agent scanning the document gets conclusions immediately
* Bad, because same concept-retrieval problem as Options A and C
* Bad, because prioritization is context-dependent — what's "most important" depends on why you're consulting the review, making it less durable over time
* Neutral, because the "abstract as cached synthesis" idea can be adopted independently of the findings-led structure

### Option E: Dual-Structure (Concepts + Themes)

Concepts and themes as dual first-class sections, with Abstract, Synthesis, Gaps & Open Questions, Implications, and References. Combines strengths of all previous options.

* Good, because both concepts and themes are independently retrievable — resolves the symmetrical scatter problem
* Good, because concepts provide grounded vocabulary, themes provide cross-cutting narrative
* Good, because Abstract serves as cached synthesis for retrieval optimization
* Good, because Gaps & Open Questions provides epistemic honesty
* Good, because Implications bridges to experiments, ADRs, BETs
* Bad, because most complex format — seven sections in the main document plus a companion file
* Bad, because novel structure with no established tradition to guide edge cases
* Bad, because potential for information drift between Concepts, Themes, and Synthesis

## More Information

### Literature Review Template

```markdown
---
date: YYYY-MM-DD
last_updated: YYYY-MM-DD
produced_by: [model identifier, e.g., claude-opus-4-6]
freshness: current | stale | needs-update
methodology_version: [integer, references the search methodology version in the research skill]
---
# [Topic]

## Abstract
[Pre-computed synthesis of key findings. Self-contained — readable without the
rest of the document. Serves as cached summary for agents and quick overview
for humans.]

## Concepts

### [Concept A]
**Definition:** [Sourced definition — what this concept means]
**Current state:** [Where things stand today with this concept]
**Key sources:** [1], [2]
**Relates to:** [Concept B], [Concept C]

### [Concept B]
**Definition:** ...
**Current state:** ...
**Key sources:** [3]
**Relates to:** [Concept A]

## Themes

### [Theme 1]
[Cross-cutting analysis that references and connects multiple concepts.
Trends, patterns, convergences, tensions.]

### [Theme 2]
[...]

## Synthesis
[Meta-analysis connecting themes to each other. Patterns across themes,
tensions and contradictions between themes, emerging macro-trends.]

## Gaps & Open Questions
[What is not yet known. Active areas of investigation. Contradictions or
shortcomings in current research. Questions that remain unanswered.]

## Implications
[Actionable bridge to existing processes. Potential experiments to run,
ADRs to create, BETs to propose. What follows from this research.]

## References
[Cited sources with standard citation format. Full audit trail of all
visited sources lives in the companion sources-log.md file.]
```

### Sources Log (Companion File)

Each literature review is accompanied by a `sources-log.md` that tracks every source visited during research, not just those cited. This serves as an audit trail — implicitly, everything not in the log wasn't visited.

```markdown
---
literature_review: [topic]
last_updated: YYYY-MM-DD
---
# Sources Log: [Topic]

## Included
| Source | URL | Date Accessed | Key Finding | Used In |
|--------|-----|---------------|-------------|---------|
| [Source 1] | ... | ... | ... | Concepts/[A], Themes/[1] |

## Excluded
| Source | URL | Date Accessed | Reason for Exclusion |
|--------|-----|---------------|---------------------|
| [Source X] | ... | ... | Out of scope — focuses on [Y] |

## Skimmed
| Source | URL | Date Accessed | Notes |
|--------|-----|---------------|-------|
| [Source Z] | ... | ... | Tangentially relevant, not deep enough |
```

The three dispositions are:
- **Included:** Source contributed to the literature review. Lists which sections it informed.
- **Excluded:** Source was reviewed but deliberately not included. Reason documented.
- **Skimmed:** Source was found but not deeply analyzed. Brief notes on why.

### Directory Structure Per Topic

```
docs/research/{topic}/
├── brief.md              # Human-oriented synthesis (format defined in a future ADR)
├── literature-review.md  # Agent-oriented comprehensive review (this ADR's format)
└── sources-log.md        # Audit trail: all visited sources with dispositions
```

### Search Methodology

Per the "high rigor, low overhead" principle, search methodology is documented **once** in the research skill, not repeated in every literature review. The `methodology_version` field in the frontmatter references which version of the search methodology was used, enabling traceability without per-document overhead.

When the search methodology changes (e.g., new databases added, different search strategies), the version is incremented and existing reviews can be flagged for potential re-research.

### Frontmatter Fields

| Field | Type | Description |
|-------|------|-------------|
| `date` | date | When the review was first produced |
| `last_updated` | date | When the review was last substantively updated |
| `produced_by` | string | Model identifier that produced or last updated the review (e.g., `claude-opus-4-6`). Enables provenance tracking — findings from less capable models may warrant re-investigation |
| `freshness` | enum | `current`, `stale`, or `needs-update`. Signal for whether the review's findings are still reliable |
| `methodology_version` | integer | References the search methodology version in the research skill |

### Relationship to ADR 0013

This ADR defines the **format** of one layer in ADR 0013's three-layer process:

```
ADR 0013: Three-layer research process (index + literature review + brief)
├── ADR 0014: Literature review format (this ADR)
├── Future ADR: Brief format
└── Research skill: Operationalizes the process, owns search methodology
```

### Academic Foundations

This format draws on several established traditions:

- **Scoping reviews (PRISMA-ScR)** — the Themes sections are analogous to scoping review "charting" and thematic analysis. The source audit trail mirrors the PRISMA flow diagram concept.
- **State of the Art reviews** — the emphasis on "current state" in concept entries and temporal awareness in themes follows the SotA tradition of tracking knowledge evolution.
- **Living systematic reviews** — the freshness metadata and methodology versioning are inspired by living review methodology, where documents are continually updated rather than published once.
- **Executive summaries** — the Abstract follows the established pattern of a self-contained summary that is ~10% the length of the full document.

The format departs from academic tradition by making both concepts and themes first-class — no established review type does this. It also offloads search methodology to the skill (rather than documenting it per-review) and uses a companion file for source auditing (rather than inline PRISMA flow diagrams).

### Related Decisions

* [ADR 0013](0013-use-three-layer-research-process-for-exploratory-learning.md) — Establishes the three-layer research process that this format serves
* [ADR 0007](0007-use-experiments-for-empirical-validation.md) — Experiments framework; research implications may trigger experiments
* [ADR 0002](0002-use-bet-records-to-document-foundational-beliefs.md) — BET records; research may inform new beliefs

### References

* [PRISMA 2020 Statement](https://www.prisma-statement.org/) — Reporting standard for systematic reviews (27-item checklist)
* [PRISMA-ScR for Scoping Reviews](https://www.prisma-statement.org/scoping) — Extension for scoping reviews (22-item checklist), closest academic format to our use case
* [State of the Art Reviews (University of Melbourne)](https://unimelb.libguides.com/whichreview/stateoftheartreview) — Temporal knowledge evolution reviews
* [Living Systematic Reviews (PMC)](https://pmc.ncbi.nlm.nih.gov/articles/PMC7542271/) — Methodology for continually updated reviews
* [Executive Summary Format (USC)](https://libguides.usc.edu/writingguide/executivesummary) — Established pattern for standalone summaries
* [Progressive disclosure for AI agents (honra.io)](https://www.honra.io/articles/progressive-disclosure-for-ai-agents) — Three-layer architecture for AI documentation (also referenced by ADR 0013)
* [RAG Knowledge Decay Problem](https://ragaboutit.com/the-knowledge-decay-problem-how-to-build-rag-systems-that-stay-fresh-at-scale/) — Staleness metrics and freshness management for knowledge bases
