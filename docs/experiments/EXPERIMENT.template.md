---
id: YYYY-MM-short-description
title: "[Experiment Title]"
date: YYYY-MM-DD
authors:
  - Name <email>
progress_status: proposed  # proposed | designed | running | completed
outcome_status: null       # validated | invalidated | inconclusive (set after completion)
---

# [Experiment Title]

## Hypothesis & Rationale

**Hypothesis**: [Clear, testable statement of what you expect to be true]

**Rationale**: [Why this hypothesis matters. What decision or belief does it inform?]

## Protocol

### Prerequisites

- [Requirement 1]
- [Requirement 2]

### Setup

```bash
# Commands to prepare the environment
```

### Procedure

1. [Step 1 - be specific enough for an agent to execute]
2. [Step 2]
3. [Step 3]

### Execution

```bash
# Single command to run the experiment
```

### Cleanup

```bash
# Commands to clean up after the experiment (if needed)
```

## Success Criteria

### Primary Metrics

| Metric | Target | How Measured |
|--------|--------|--------------|
| [Metric 1] | [e.g., < 5%] | [Measurement method] |
| [Metric 2] | [e.g., > 80%] | [Measurement method] |

### Secondary Metrics (optional)

| Metric | Target | How Measured |
|--------|--------|--------------|
| [Metric 3] | [Target] | [Method] |

### Evaluation

[How will success/failure be determined? Statistical method, threshold comparison, etc.]

## Related Work

### Internal

- **BETs**: [Links to related BETs, if any]
- **ADRs**: [Links to related ADRs, if any]
- **Features**: [Links to related features, if any]

### External

- [Links to papers, articles, or other research]

## Conclusion

> This section is filled after the experiment completes, summarizing findings across all runs.

### Summary

[Overall findings from the experiment]

### Outcome

- [ ] Validated - hypothesis confirmed
- [ ] Invalidated - hypothesis disproven
- [ ] Inconclusive - results unclear

### Key Findings

1. [Finding 1]
2. [Finding 2]

### Recommendations

[What actions should be taken based on these results?]

### Impact

- **BETs**: [How does this affect related BETs?]
- **ADRs**: [Should any ADR be created, updated, or superseded?]
- **Backlog**: [What items should be added to the backlog?]
