# Example ADRs

This directory contains curated example Architecture Decision Records demonstrating best practices for quality, depth, and honest documentation.

> **Note:** The `adrs` tool auto-generates templates. These examples are **references for content quality**, not templates to copy.

## Examples Included

* [0005-use-postgresql-for-primary-database.md](0005-use-postgresql-for-primary-database.md) - **Comprehensive Example**
* [0014-use-microservices-from-day-one.md](0014-use-microservices-from-day-one.md) - **Rejected ADR**
* [0008-use-rest-for-microservice-communication.md](0008-use-rest-for-microservice-communication.md) - **Superseded ADR**

## Why These Examples Matter

### Comprehensive Example (PostgreSQL)
**Purpose:** Shows what thorough, honest decision documentation looks like.

**Key takeaways:**
- **Honest trade-offs:** Clearly states both pros and cons, including negative consequences
- **Multiple options:** Evaluates 4 alternatives fairly without predetermined bias
- **Context-rich:** Explains constraints, requirements, and why the decision matters
- **Concrete validation:** Specific metrics and timeline for evaluating the decision
- **Decision drivers:** Explicitly prioritizes factors that influenced the choice
- **Detailed analysis:** Pros/cons for each option from technical, operational, and business perspectives

**Learn from this:**
- How to document negative consequences honestly
- How to evaluate multiple options fairly
- How to provide enough context for future readers
- How to set validation criteria

### Rejected ADR (Microservices)
**Purpose:** Demonstrates the value of documenting decisions NOT to adopt something.

**Key takeaways:**
- **Prevents rediscussion:** Team won't revisit microservices prematurely
- **Shows thoughtfulness:** Demonstrates the option was seriously considered, not dismissed
- **Sets triggers:** Defines clear criteria for when to reconsider
- **Preserves context:** Future readers understand the constraints at decision time
- **Honest reasoning:** Explains why the appealing option was wrong for this context

**Learn from this:**
- Why documenting "what NOT to do" is valuable
- How to reject popular choices with sound reasoning
- How to set conditions for revisiting a rejected decision
- How to explain why premature optimization was avoided

### Superseded ADR (REST → gRPC)
**Purpose:** Shows how decisions evolve and the ADR lifecycle works.

**Key takeaways:**
- **Preserves history:** Original content remains intact, showing what changed
- **Links forward:** Points to the replacement ADR
- **Explains change:** Briefly states why it was superseded
- **Shows evolution:** Demonstrates that good decisions can become wrong as context changes
- **Immutability in action:** The ADR wasn't edited; it was superseded

**Learn from this:**
- How to properly supersede an ADR
- Why immutability preserves valuable context
- How decisions that were right at one scale become wrong at another
- How to link related ADRs

## What Makes These Examples Good?

### 1. Honest Trade-off Documentation
All examples include **negative consequences**, not just positive ones. This demonstrates intellectual honesty and helps future readers understand the full impact of decisions.

### 2. Multiple Options Considered
Each example shows at least 3 options were evaluated, not just the chosen one vs. a strawman. This proves due diligence was done.

### 3. Context Preservation
Enough background is provided that someone unfamiliar with the project can understand:
- What problem needed solving
- What constraints existed
- Why this decision mattered
- What forces were at play

### 4. Future-Focused
Examples include validation criteria and conditions for revisiting decisions, showing they're not set-in-stone pronouncements but thoughtful choices that can evolve.

## How to Use These Examples

**DO:**
- ✓ Use them to understand what quality looks like
- ✓ Reference them when calibrating depth of analysis
- ✓ Learn the structure and sections to include
- ✓ See how to document negative consequences
- ✓ Understand how to evaluate options fairly

**DON'T:**
- ✗ Copy them verbatim
- ✗ Use them as templates (the `adrs` tool provides templates)
- ✗ Treat them as the only valid format
- ✗ Skip the iterative process the skill guides you through

## Beyond the Examples

The `create-adr` skill will guide you through an iterative process that:
- Challenges your assumptions
- Researches alternatives
- Questions your reasoning
- Ensures honest documentation

These examples show the **destination**. The skill provides the **journey**.
