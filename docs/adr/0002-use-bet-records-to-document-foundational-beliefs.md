---
number: 2
title: Use Bet Records to document foundational beliefs
status: accepted
date: 2026-01-29
---

# Use Bet Records to document foundational beliefs

## Context and Problem Statement

This repository needs a way to document foundational beliefs ("bets") about the future that guide decisions and priorities. Unlike ADRs which record specific technical choices, bets capture worldview assumptions that shape everything else. For example: "Agents will code better than humans" is a bet that influences why this entire repository exists.

We need a format that:
- Captures beliefs clearly so agents can reference and challenge them
- Prevents "goalpost moving" by freezing evaluation criteria
- Enables accountability through regular review
- Shows how thinking evolves over time

## Decision Drivers

* Bets must be crystal clear for both humans and AI agents to reference
* Evaluation criteria must be immutable to prevent goalpost moving (e.g., we define criteria for AGI, achieve them, then claim "that's not really AGI")
* Status tracking needed: unproven, right, or wrong
* Must support superseding (beliefs evolve, but history is preserved)
* Should integrate with ADRs (bets can inform decision drivers)
* Review cadence must be explicit

## Considered Options

* Option A: Minimal format (Long Bets inspired) - just belief, criteria, falsification
* Option B: Structured format (Preregistration inspired) - adds reasoning, review schedule, relations
* Option C: Full format (ADR-like rigor) - adds alternatives considered, implications

## Decision Outcome

Chosen option: "Option C: Full format", because it provides the rigor needed for accountability while capturing the full context that helps agents challenge future decisions effectively. The additional sections (Alternatives Considered, Implications) mirror ADR patterns the repository already uses.

### Consequences

* Good, because agents have full context to challenge consistency between bets and decisions
* Good, because "Alternatives Considered" forces deeper thinking about competing worldviews
* Good, because "Implications" makes explicit what follows from the bet, enabling accountability
* Good, because immutable content with superseding preserves intellectual history
* Bad, because more overhead than a simple belief statement
* Neutral, because requires discipline to revisit on schedule

### Confirmation

Compliance can be confirmed by:
- Checking that new bet files follow the template structure
- Verifying evaluation criteria are specific and measurable
- Ensuring superseded bets link to their replacements

## Pros and Cons of the Options

### Option A: Minimal format

Inspired by [Long Bets](https://longbets.org/) - prediction statement, evaluation criteria, falsification conditions.

* Good, because low friction to create
* Good, because focuses on the essential: belief + how to judge it
* Bad, because no reasoning captured - agents can't understand *why* you believe this
* Bad, because no explicit review schedule
* Bad, because no connection to other bets or ADRs

### Option B: Structured format

Inspired by [scientific preregistration](https://aspredicted.org/) - adds reasoning, review schedule, and relations.

* Good, because "Because" section captures reasoning for future reference
* Good, because review schedule makes accountability explicit
* Good, because relations connect bets to ADRs and other bets
* Neutral, because moderate overhead
* Bad, because doesn't capture rejected alternative beliefs

### Option C: Full format

ADR-like rigor with alternatives considered and implications.

* Good, because "Alternatives Considered" shows you thought through other worldviews
* Good, because "Implications" makes downstream effects explicit and testable
* Good, because mirrors ADR patterns already familiar in this repository
* Bad, because highest overhead to create
* Bad, because some bets may not have meaningful alternatives to consider

## More Information

### The Bet Record Template

```markdown
# Bet: [Short statement]

Status: unproven | right | wrong
Created: YYYY-MM-DD
Supersedes: [Bet ID, if applicable]

## Belief
[Clear statement of what you believe will be true]

## Because
[Reasoning and evidence supporting this belief]

## Evaluation
### Right when
[Specific, frozen criteria for success]

### Wrong when
[Specific, frozen criteria for failure]

## Alternatives Considered
[Other beliefs you rejected and why]

## Implications
[What decisions follow from this bet being true?]

## Review Schedule
[When to revisit: quarterly / on specific events]

## Related
- ADRs: [list]
- Bets: [list]
```

### Key Principles

1. **Immutability**: Once a bet is accepted, its content is frozen. If your thinking evolves, create a new bet that supersedes the old one.

2. **No goalpost moving**: Evaluation criteria are locked at creation time. Even if future-you thinks the criteria were naive, the original bet is judged by its original criteria.

3. **Status lifecycle**: `unproven` → `right` or `wrong`. A bet cannot be edited to avoid being wrong.

4. **Superseding**: When beliefs evolve, the new bet links to and supersedes the old one, preserving intellectual history.

### References

- [Long Bets](https://longbets.org/) - Arena for accountable predictions
- [AsPredicted](https://aspredicted.org/) - Scientific preregistration platform
- [Hypothesis-Driven Development](https://barryoreilly.com/explore/blog/how-to-implement-hypothesis-driven-development/) - "We believe X will result in Y" format
