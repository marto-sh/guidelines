# ADR Template Reference

**Note:** This is a reference showing the structure of ADR templates. The `adrs` tool automatically generates templates when you create a new ADR using `adrs new "Title"`. You don't need to manually copy this template.

---

# [Number]. [Short title of decision in imperative form]

Date: YYYY-MM-DD

## Status

[Proposed | Accepted | Rejected | Deprecated | Superseded by [ADR-NNNN](NNNN-filename.md)]

## Context

[Describe the context and problem statement. What forces are at play? What are the constraints and requirements? State this in value-neutral language. 2-3 paragraphs.]

## Decision Drivers

* [Driver 1 - e.g., "Must support 10,000 concurrent users"]
* [Driver 2 - e.g., "Team has strong Python expertise"]
* [Driver 3 - e.g., "Budget constraint of $X/month for infrastructure"]

## Considered Options

* [Option 1 - e.g., "PostgreSQL"]
* [Option 2 - e.g., "MongoDB"]
* [Option 3 - e.g., "DynamoDB"]

## Decision

[Describe the decision in 1-2 paragraphs. What did we choose and why? Write in full sentences with active voice.]

### Rationale

[Explain why this option was chosen over the alternatives. Reference the decision drivers explicitly.]

## Consequences

### Positive

* [Consequence 1 - What becomes easier or better]
* [Consequence 2]

### Negative

* [Consequence 1 - What becomes harder, costs, or risks introduced]
* [Consequence 2]

### Neutral

* [Consequence 1 - Other changes that are neither good nor bad]

## Validation

[How will we know this decision was correct? What metrics will we monitor? When will we evaluate?]

* Success criterion 1
* Success criterion 2
* Evaluation timeline: [e.g., "Review after 3 months in production"]

## Pros and Cons of the Options

### [Option 1]

* Good, because [argument a]
* Good, because [argument b]
* Bad, because [argument c]
* Bad, because [argument d]

### [Option 2]

* Good, because [argument a]
* Good, because [argument b]
* Bad, because [argument c]
* Bad, because [argument d]

### [Option 3]

* Good, because [argument a]
* Good, because [argument b]
* Bad, because [argument c]
* Bad, because [argument d]

## Related Decisions

* [ADR-NNNN] - [Related decision title]

## References

* [Link to relevant documentation]
* [Link to technical research]
* [Link to benchmarks or comparisons]
