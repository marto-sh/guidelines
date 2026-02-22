---
number: 13
title: Use Three-Layer Research Process for Exploratory Learning
status: proposed
date: 2026-02-21
---

# Use Three-Layer Research Process for Exploratory Learning

## Context and Problem Statement

Our decision framework includes ADRs for architectural decisions, BETs for foundational beliefs, and experiments for empirical validation. However, there is a recurring need for open-ended, curiosity-driven research — exploring the state of the art on a topic without a specific hypothesis or decision to make. For example: "Research the state of embeddings: universal embedding spaces for language, vision, audio, and reasoning."

This type of exploratory research doesn't fit existing formats. ADRs document decisions already made. Experiments test specific hypotheses. BETs record foundational beliefs. Research is pre-decisional and pre-hypothesis — its outcome is uncertain. It might lead to an experiment, an ADR, or nothing actionable at all.

Without a defined process, research either doesn't happen, happens in ephemeral conversations that are lost, or produces ad-hoc documents with no consistent structure. Agents are capable of conducting thorough research, but their output needs a format that serves both agents (as a retrieval source for follow-up queries) and humans (as a digestible synthesis).

## Decision Drivers

* **Dual-audience usability** — artifacts must serve both agents (deep retrieval) and humans (quick comprehension)
* **Durability and buildability** — research should persist and be built upon across sessions, not lost
* **Navigability at scale** — as topics accumulate, the collection must remain browsable without reading individual documents
* **Low human effort** — agents do the heavy lifting (production and maintenance); human effort is limited to reading briefs and asking follow-ups
* **Freshness** — documents should be maintainable over time, with signals for when they need updating
* **Clear lifecycle** — research should have a defined flow from questions through to potential experiments/ADRs
* **Cohesion with existing processes** — should complement (not duplicate) experiments, ADRs, and BETs

## Considered Options

* **Three-layer progressive disclosure** — index + literature review + research brief
* **Evergreen notes / Zettelkasten** — atomic, interlinked concept notes
* **Conversational research (no artifact)** — agents research on demand, no persistent documents

## Decision Outcome

Chosen option: **Three-layer progressive disclosure**, because it best satisfies the dual-audience requirement while remaining navigable at scale. The index provides routing for both agents and humans, the literature review serves as a comprehensive retrieval source, and the research brief gives humans a concise synthesis without requiring them to read the full review.

Agents produce all three layers. Humans primarily interact with the brief and ask follow-up questions, which agents answer by drawing on the literature review. This aligns with the progressive disclosure pattern: index for routing, brief for understanding, review for depth.

### Consequences

* Good, because agents can produce comprehensive research without burdening humans with reading it all
* Good, because the brief gives humans a quick synthesis optimized for their attention
* Good, because the literature review serves as a durable, queryable knowledge base for agents
* Good, because the index keeps the collection navigable as topics accumulate
* Good, because the lifecycle (questions → research → possibly experiment/ADR) integrates naturally with existing processes
* Good, because research that leads nowhere is still documented and discoverable, preventing repeated exploration of the same ground
* Bad, because adds another document type (and three layers per topic) to maintain
* Bad, because requires dedicated skills to produce consistent output
* Bad, because literature reviews can become stale — a comprehensive document that's outdated may be worse than no document
* Neutral, because there is some overlap with experiments (standalone experiments can also serve curiosity-driven learning)

## Pros and Cons of the Options

### Three-layer progressive disclosure

Index/registry + comprehensive literature review + concise research brief, living in `guidelines/research/`.

* Good, because optimized for both audiences — agents get depth, humans get synthesis
* Good, because the index provides navigability without reading individual documents
* Good, because the literature review is a durable retrieval source for follow-up questions
* Good, because clear structure enables dedicated skills for consistent production
* Good, because progressive disclosure is an established pattern for managing information at different levels of detail
* Neutral, because three layers per topic is more structure than some topics may warrant
* Bad, because highest maintenance burden — three artifacts per topic plus the index
* Bad, because staleness risk increases with document volume

### Evergreen notes / Zettelkasten

Atomic, concept-oriented notes that accumulate organically. Notes are interlinked, forming a knowledge network. Hub notes serve as entry points to thematic clusters.

* Good, because atomic notes are easy to write, read, and update individually
* Good, because cross-linking enables unexpected connections across topics
* Good, because low staleness risk — small notes are easy to update or discard
* Good, because organic growth requires less upfront structure
* Neutral, because better suited for creative synthesis than structured domain learning
* Bad, because harder for agents to use as a deep retrieval source — knowledge is distributed across many small notes
* Bad, because the network requires sustained curation to stay coherent
* Bad, because linking and curation are difficult to automate
* Bad, because no clear lifecycle — notes accumulate without a defined flow toward action

### Conversational research (no artifact)

Agents research on demand in conversation. Insights are distilled into CLAUDE.md memory or spawn experiments/ADRs. No dedicated research documents.

* Good, because zero maintenance — nothing to keep fresh
* Good, because always current — agent re-researches each time
* Good, because no new document type or process to learn
* Good, because simplest possible approach
* Bad, because no durable knowledge base — research is lost between sessions
* Bad, because cannot build on prior research — each session starts from scratch
* Bad, because no way to share research findings across projects or over time
* Bad, because doesn't scale — repeated research on similar topics wastes agent effort

## More Information

### Directory Structure

Research artifacts live in the guidelines repository under `research/`:

```
guidelines/
├── docs/
│   ├── adr/              # Architecture Decision Records
│   ├── bets/             # Foundational beliefs
│   └── research/
│       ├── README.md     # Index: all topics with status, date, one-line summary
│       └── {topic}/
│           ├── literature-review.md   # Comprehensive, agent-oriented
│           └── brief.md               # Concise, human-oriented synthesis
└── skills/
    └── research/         # Dedicated skills for producing research artifacts
```

### Research Lifecycle

```
Human poses questions
  → Agent produces literature review (comprehensive) + brief (synthesis)
  → Index updated with new topic entry
  → Human reads brief, asks follow-up questions
    → Agent answers by drawing on the literature review, conducting additional research if needed
    → Literature review and brief updated with new findings
      → Eventually: experiment, ADR, or nothing
```

### Freshness and Maintenance

Literature reviews should include a date, a freshness signal, and agent provenance (which model produced or last updated the research). As agents improve, provenance allows weighing the credibility of older research — findings from a less capable model may warrant re-investigation by a more powerful one.

Ideally, reviews would be continually updated via:

* **Scheduled refresh** — e.g., every 3 months, agent re-researches and updates
* **Signal-driven refresh** — e.g., new papers appear, news articles mention relevant developments
* **Combination** — scheduled baseline with signal-triggered updates

The exact maintenance mechanism is a future concern.

### Relationship to Other Document Types

```
Research (exploratory learning)
 └── May trigger: Experiment (validate an intuition grounded by research, or test an idea it sparked)
 └── May trigger: ADR (decision informed by research findings)
 └── May trigger: BET (new foundational belief based on research)
 └── May trigger: Nothing (learning is the value)

Experiment (empirical validation)
 └── May draw on: Research (prior knowledge on the topic)
```

### Related Decisions

* [ADR 0007](0007-use-experiments-for-empirical-validation.md) — Experiments for empirical validation (complementary; some overlap with standalone experiments)
* [ADR 0002](0002-use-bet-records-to-document-foundational-beliefs.md) — BET records (research may inform new beliefs)
* [ADR 0008](0008-share-guidelines-across-projects.md) — Sharing guidelines across projects (research lives in guidelines repo; note: ADR 0008 amendment pending)

### Notes

Echoes of Google's "organize the world's information" — the index → brief → review layers mirror search results → snippet → full page.

### References

* Progressive disclosure for AI agents — [honra.io](https://www.honra.io/articles/progressive-disclosure-for-ai-agents). Directly informed the three-layer structure. Proposes a three-layer architecture for AI agent documentation: lightweight metadata/index, full content loaded on demand, deep-dive supporting materials. Key insight: "treat context as scarce currency — every token competes for attention." Recommends limiting to 2-3 layers max.
* Andy Matuschak on evergreen notes — [notes.andymatuschak.org](https://notes.andymatuschak.org/Evergreen_notes). Considered as an alternative. Defines five properties: atomic, concept-oriented, densely linked, associative over hierarchical, personally authored. Prioritizes *thinking development* over information capture. A two-year practitioner reflection found evergreen notes are not optimal for structured learning of a new domain — better suited for creative synthesis. This is why we chose against them for research, but they remain interesting for the broader knowledge management question.
* Google Design Docs — [industrialempathy.com](https://www.industrialempathy.com/posts/design-docs-at-google/). Validates the two-layer pattern at scale. Google's design docs implicitly follow it: summary sections (Goals/Non-Goals, Context/Scope) plus detailed sections (Actual Design, Alternatives Considered). Mini-docs (1-3 pages) coexist with full docs (10-20 pages) for the same system.
* Diataxis documentation framework — [diataxis.fr](https://diataxis.fr/). Background context. Splits documentation into four types along two axes (learning vs. doing, theoretical vs. practical): tutorials, how-to guides, reference, explanation. Our research artifacts are closest to "explanation" in Diataxis terms. Useful framing but didn't directly shape the decision.
* Research spikes in agile — [scaledagile.com/spikes](https://framework.scaledagile.com/spikes). Background context. Time-boxed investigations producing knowledge artifacts rather than customer-facing features. Key principle: results should be demonstrated to stakeholders even when not customer-facing. Informed the lifecycle thinking but we chose something more durable than a spike.
