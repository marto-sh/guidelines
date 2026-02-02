# Experiment Design Best Practices

This document summarizes best practices for designing rigorous, reproducible experiments based on scientific methodology and AI research standards.

## Core Principles

### 1. Falsifiability

A hypothesis must be capable of being proven false. If no possible outcome could invalidate your hypothesis, it's not testable.

**Bad:** "AI agents are useful"
**Good:** "AI agents complete coding tasks with fewer than 3 iterations on average"

### 2. Reproducibility

Anyone should be able to re-run your experiment and get comparable results. This requires:
- Documented environment and dependencies
- Fixed random seeds where applicable
- Version-controlled code and data
- Step-by-step protocol

### 3. Measurability

Outcomes must be observable and quantifiable. Prefer:
- Automated metrics over manual assessment
- Quantitative over qualitative measures
- Objective over subjective criteria

### 4. Control

Isolate the variable you're testing by controlling everything else:
- Same environment across conditions
- Randomized sample order
- Consistent evaluation criteria

## Hypothesis Formulation

### The SMART Framework for Hypotheses

- **Specific:** What exactly are you testing?
- **Measurable:** How will you quantify the outcome?
- **Achievable:** Can this experiment actually be run?
- **Relevant:** Does this inform a real decision?
- **Testable:** Can the hypothesis be falsified?

### Types of Hypotheses

1. **Comparative:** "A is better than B at X"
   - Requires direct comparison
   - Clear winner criteria needed

2. **Threshold:** "A achieves at least X"
   - Requires baseline or target
   - Pass/fail determination

3. **Exploratory:** "What is the effect of A on X?"
   - No predetermined direction
   - May generate follow-up hypotheses

### Common Pitfalls

- **Too vague:** "Rust is better" → Better at what? For whom?
- **Not falsifiable:** "This might help" → What would prove it doesn't?
- **Multiple variables:** "Rust with strict linting is better" → Is it Rust or the linting?

## Variables

### Types of Variables

1. **Independent Variable (IV):** What you manipulate
   - Example: Programming language (Rust vs Python)

2. **Dependent Variable (DV):** What you measure
   - Example: Error rate, completion time

3. **Control Variables:** What you keep constant
   - Example: Same AI model, same task complexity

4. **Confounding Variables:** What could interfere
   - Example: Task difficulty varying with language

### Operationalization

Define how abstract concepts become measurable:
- "Code quality" → Error count, test pass rate, cyclomatic complexity
- "Developer productivity" → Tasks completed per hour, lines of code
- "Agent reliability" → Success rate, iteration count, human intervention rate

## Sample Design

### Sample Size Considerations

- Larger samples = more statistical power
- Diminishing returns after sufficient power achieved
- Consider practical constraints (cost, time)

### Selection Methods

1. **Random sampling:** Best for generalizability
2. **Stratified sampling:** Ensures representation across categories
3. **Convenience sampling:** Practical but limits generalizability

### Avoiding Bias

- Don't cherry-pick favorable examples
- Document inclusion/exclusion criteria
- Report all results, not just favorable ones

## Experimental Design Patterns

### 1. A/B Comparison

Compare two conditions directly.

```
Group A: Condition 1 (e.g., Rust)
Group B: Condition 2 (e.g., Python)
Measure: Same outcome for both
```

**Strengths:** Simple, direct comparison
**Weaknesses:** Only two conditions, no baseline

### 2. Pre/Post Design

Measure before and after an intervention.

```
Baseline: Measure current state
Intervention: Apply change
Post-test: Measure new state
```

**Strengths:** Shows change over time
**Weaknesses:** Other factors may cause change

### 3. Factorial Design

Test multiple variables simultaneously.

```
Factor A: Language (Rust, Python)
Factor B: Linting (Strict, Relaxed)
Conditions: 2 × 2 = 4 combinations
```

**Strengths:** Reveals interactions between variables
**Weaknesses:** Complexity grows exponentially

### 4. Repeated Measures

Same subjects tested under all conditions.

```
Subject 1: Condition A, then Condition B
Subject 2: Condition B, then Condition A
```

**Strengths:** Controls for individual differences
**Weaknesses:** Order effects, learning effects

## Metrics and Measurement

### Metric Selection Criteria

1. **Validity:** Does it measure what you intend?
2. **Reliability:** Is it consistent across measurements?
3. **Sensitivity:** Can it detect meaningful differences?
4. **Practicality:** Can it be collected efficiently?

### Common Metrics for AI/Agent Experiments

| Category | Metrics |
|----------|---------|
| **Accuracy** | Error rate, success rate, precision, recall |
| **Efficiency** | Completion time, iteration count, token usage |
| **Quality** | Test pass rate, code review score, bug density |
| **Cost** | API calls, compute time, human intervention rate |

### Setting Thresholds

- **Practical significance:** What difference actually matters?
- **Statistical significance:** Is the difference real or chance?
- **Effect size:** How large is the difference?

Rule of thumb: Define thresholds BEFORE running the experiment.

## Threats to Validity

### Internal Validity

*Could something else explain your results?*

- **History:** External events during experiment
- **Maturation:** Changes in subjects over time
- **Testing effects:** Measurement affects behavior
- **Selection bias:** Non-random group assignment

### External Validity

*Will results generalize?*

- **Population:** Does sample represent target population?
- **Setting:** Will results hold in different contexts?
- **Time:** Will results hold in the future?

### Construct Validity

*Are you measuring what you think?*

- **Operationalization:** Does your metric capture the concept?
- **Mono-method bias:** Using only one way to measure

### Mitigations

| Threat | Mitigation |
|--------|------------|
| Selection bias | Random assignment |
| Testing effects | Unobtrusive measures |
| History | Control group |
| Construct validity | Multiple measures |

## Protocol Design

### Step-by-Step Protocol Requirements

1. **Unambiguous:** No interpretation needed
2. **Complete:** All steps documented
3. **Atomic:** One action per step
4. **Reproducible:** Same steps = same setup

### Protocol Template

```markdown
### Prerequisites
What must be in place before the experiment can run (tools, access, data).

- [ ] Requirement 1
- [ ] Requirement 2

### Setup
Prepare the environment and initial state. These steps should be idempotent.

1. Step 1 (specific command)
2. Step 2 (specific command)

### Execution
Run the experiment. This is the core procedure being tested.

1. Run [specific command]

### Measurement
Collect outputs and compute metrics. Raw data should be preserved for later analysis.

1. Collect [specific output/data]
2. Calculate [specific metric]

### Cleanup
Restore the environment to a clean state for the next run.

1. Reset [specific state]
```

### Automation Guidelines

- Single command to execute entire experiment
- Automated data collection
- Machine-readable output format
- Idempotent setup (can run multiple times)

## Reporting and Documentation

### What to Document

1. **Hypothesis:** Exact statement tested
2. **Method:** Complete protocol
3. **Results:** All data, not just favorable
4. **Analysis:** How results were interpreted
5. **Limitations:** What the experiment doesn't tell us

### Handling Negative Results

Negative results (hypothesis invalidated) are valuable:
- Prevent others from wasting time
- Challenge assumptions
- Guide future research

Always document and publish negative results.

### Handling Inconclusive Results

When results are unclear:
1. Document what happened
2. Analyze why inconclusive
3. Propose modified experiment
4. Don't force a conclusion

## Replication and Re-running

### When to Re-run

- New AI model released
- Significant tooling changes
- Time-based validation (e.g., quarterly)
- Anomalous initial results

### Replication Requirements

- Exact same protocol
- Documented environment
- Version-controlled dependencies
- Accessible data and scripts

### Version Tracking

Track what changed between runs:
- AI model version
- Tool versions
- Environment changes
- Protocol modifications

## Ethical Considerations

### For AI Experiments

- **Resource usage:** Minimize unnecessary API calls
- **Reproducibility:** Share code and data where possible
- **Transparency:** Document limitations and failures
- **Bias:** Consider how training data affects results

### For Human-Involved Experiments

- Informed consent
- Privacy protection
- Right to withdraw
- Debriefing after participation

## Further Reading

### Scientific Method

- Popper, K. (1959). The Logic of Scientific Discovery
- Kuhn, T. (1962). The Structure of Scientific Revolutions

### Experimental Design

- Campbell, D. & Stanley, J. (1963). Experimental and Quasi-Experimental Designs for Research
- Shadish, Cook & Campbell (2002). Experimental and Quasi-Experimental Designs for Generalized Causal Inference

### AI/ML Research

- [Papers with Code - Methodology](https://paperswithcode.com/)
- [ML Reproducibility Checklist](https://www.cs.mcgill.ca/~jpineau/ReproducibilityChecklist.pdf)
- [Model Cards for Model Reporting](https://arxiv.org/abs/1810.03993)

### Statistics

- Cohen, J. (1988). Statistical Power Analysis for the Behavioral Sciences
- Effect Size Calculator: https://www.escal.site/
