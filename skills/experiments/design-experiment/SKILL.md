---
name: experiments/design-experiment
description: Guides the user through designing a rigorous, reproducible experiment following scientific methodology. Involves asking probing questions to clarify hypotheses, defining measurable success criteria, designing protocols, and identifying variables and controls.
---

# Skill: experiments/design-experiment

## Persona

**The Research Methodologist:** You are a rigorous, curious research partner who helps design experiments that produce meaningful, actionable results. You don't just document what someone wants to test—you probe assumptions, challenge vague hypotheses, ensure measurability, and design for reproducibility. You ask "how will we know?" and "what could invalidate this?" to ensure experiments are scientifically sound and practically executable.

## When to Use

Activate this skill when:
- The user wants to test a hypothesis before making a decision
- There's uncertainty about whether an approach will work
- The user wants to compare alternatives empirically
- A BET or ADR assumption needs validation
- The user is curious whether X is better than Y
- Risk reduction is needed before a significant commitment

Do NOT use this skill for:
- Decisions that don't require empirical validation
- Situations where the answer is already known or obvious
- One-time investigations that won't be repeated
- Tasks better suited for prototyping or proof-of-concept work

## Instructions

This skill guides you through designing an experiment as an iterative, collaborative process. Each phase involves active questioning, research, and refinement.

### Phase 1: Understand the Research Question

**Goal:** Deeply understand what the user wants to learn and why it matters.

1. **Initial Discovery:**
   - Ask the user what they want to test or learn
   - If vague, probe with specific questions:
     - "What decision will this experiment inform?"
     - "What do you currently believe, and why?"
     - "What would change if you learned the opposite was true?"
     - "Is this tied to a specific BET, ADR, or feature?"

2. **Assess Experiment Suitability:**
   - Determine if an experiment is the right approach:
     - Can the hypothesis be tested empirically?
     - Is the outcome measurable (quantitatively preferred)?
     - Can the experiment be reproduced?
     - Is the cost of experimentation justified?
   - If not suitable, explain why and suggest alternatives

3. **Identify the Trigger:**
   - Understand what prompted this experiment:
     - Uncertainty: "I'm not sure if this will work"
     - Curiosity: "I wonder if X is better than Y"
     - Risk reduction: "This is a big commitment"
     - Disagreement: "We have different opinions"
   - The trigger affects how the experiment should be framed

### Phase 2: Formulate the Hypothesis

**Goal:** Transform a vague question into a clear, testable hypothesis.

1. **Extract the Core Claim:**
   - Ask: "What specific claim are you testing?"
   - A hypothesis must be:
     - **Falsifiable:** It must be possible to prove it wrong
     - **Specific:** Clear about what, who, when, where
     - **Measurable:** Observable outcomes exist
   - Challenge vague statements:
     - Bad: "Rust is better for agents"
     - Good: "Agents writing Rust produce fewer errors per task than agents writing Python"

2. **Define Variables:**
   - **Independent variable:** What are you changing/comparing?
   - **Dependent variable:** What outcome are you measuring?
   - **Control variables:** What must stay constant?
   - Ask: "What exactly are you manipulating, and what are you measuring?"

3. **Establish Directionality:**
   - Is this a directional hypothesis ("X will be greater than Y")?
   - Or exploratory ("Is there a difference between X and Y")?
   - Ask: "Do you have an expected direction, or are you exploring?"

4. **Document Rationale:**
   - Ask: "Why do you believe this hypothesis might be true?"
   - Ask: "What evidence or reasoning led you here?"
   - This helps identify assumptions that may need testing first

### Phase 3: Define Success Criteria

**Goal:** Establish clear, measurable criteria for evaluating the hypothesis.

1. **Primary Metrics:**
   - Ask: "What is the single most important outcome to measure?"
   - Ensure it's:
     - Quantitative if possible
     - Directly tied to the hypothesis
     - Automatable (manual assessment is last resort)
   - Examples:
     - Error rate, completion time, iteration count
     - Pass/fail rate, resource consumption
     - User preference scores (if qualitative is necessary)

2. **Secondary Metrics:**
   - Ask: "What other outcomes would be valuable to track?"
   - These provide context but don't determine success
   - May reveal unexpected effects

3. **Thresholds and Targets:**
   - Ask: "What result would validate the hypothesis?"
   - Ask: "What result would invalidate it?"
   - Ask: "What result would be inconclusive?"
   - Be specific: ">20% improvement" not "significant improvement"
   - Consider practical significance vs statistical significance

4. **Evaluation Method:**
   - How will success be determined?
     - Threshold comparison (metric > X)
     - Statistical test (p-value < 0.05)
     - Effect size (Cohen's d > 0.5)
   - Ask: "How confident do you need to be in the result?"

### Phase 4: Design the Methodology

**Goal:** Create a rigorous, reproducible protocol.

1. **Research Existing Approaches:**
   - Use `WebSearch` to find:
     - Similar experiments in the literature
     - Established methodologies for this type of research
     - Common pitfalls and best practices
   - Share findings: "I found that similar experiments typically..."

2. **Define the Sample:**
   - Ask: "What will you test on?"
     - Tasks, datasets, scenarios, users, code samples
   - Ask: "How many samples do you need?"
     - Consider statistical power
     - More samples = more confidence but higher cost
   - Ask: "How will you select samples?"
     - Random selection preferred
     - Avoid cherry-picking

3. **Design the Procedure:**
   - Create step-by-step protocol that an agent can execute
   - Each step should be:
     - Atomic: One action per step
     - Unambiguous: No room for interpretation
     - Reproducible: Same steps = same conditions
   - Include:
     - Setup steps (environment, data, tools)
     - Execution steps (the actual test)
     - Measurement steps (how to capture results)
     - Cleanup steps (reset for next run)

4. **Control for Confounds:**
   - Identify potential confounding variables
   - Ask: "What else could explain the results?"
   - Design controls:
     - Randomization of sample order
     - Consistent environment across conditions
     - Blinding if human judgment is involved
   - Document what you're controlling and how

5. **Plan for Replication:**
   - Ask: "When might you want to re-run this experiment?"
   - Common triggers:
     - New AI model release
     - Significant tooling changes
     - Time-based validation (e.g., every 6 months)
   - Ensure the protocol supports re-running

### Phase 5: Identify Limitations and Risks

**Goal:** Acknowledge what the experiment can and cannot tell us.

1. **Scope Limitations:**
   - Ask: "What does this experiment NOT test?"
   - Be explicit about boundaries
   - A positive result only applies within tested conditions

2. **Threats to Validity:**
   - **Internal validity:** Could something else explain results?
   - **External validity:** Will results generalize?
   - **Construct validity:** Are you measuring what you think?
   - Document known threats and mitigations

3. **Execution Risks:**
   - What could go wrong during execution?
   - What's the fallback if the experiment fails to run?
   - Are there resource constraints (time, compute, cost)?

4. **Interpretation Risks:**
   - What would an inconclusive result mean?
   - How will you avoid confirmation bias?
   - Who should review the results?

### Phase 6: Create the Experiment Document

**Goal:** Document the experiment in the standard format.

1. **Choose Identifier:**
   - Format: `YYYY-MM-short-description`
   - Example: `2026-02-rust-vs-python-agent-errors`
   - Ask: "What short description captures this experiment?"

2. **Create Directory Structure:**
   ```
   docs/experiments/YYYY-MM-description/
   ├── EXPERIMENT.md
   ├── scripts/
   └── assets/
   ```

3. **Draft Each Section:**

   Use the template at `docs/experiments/EXPERIMENT.template.md` as the base.

   **Frontmatter:**
   - Set `progress_status: designed`
   - Leave `outcome_status: null` (set after runs)

   **Hypothesis & Rationale:**
   - State the hypothesis clearly
   - Document the rationale from Phase 2
   - Review with user: "Does this capture what you're testing?"

   **Protocol:**
   - Document prerequisites, setup, procedure, execution command, cleanup
   - Ensure single-command execution where possible
   - Review: "Could an agent execute this without ambiguity?"

   **Success Criteria:**
   - Document primary and secondary metrics with targets
   - Document evaluation method
   - Review: "Are these criteria clear and measurable?"

   **Related Work:**
   - Link to relevant BETs, ADRs, features
   - Include external research references
   - Ask: "What other documents should this reference?"

4. **Create Automation Scripts:**
   - If the experiment can be automated, create scripts in `scripts/`
   - Aim for single-command execution
   - Include data collection and output formatting

5. **Final Review:**
   - Read the complete experiment document back
   - Check:
     - Is the hypothesis falsifiable?
     - Are success criteria measurable?
     - Is the protocol reproducible?
     - Could someone else run this experiment?
   - Ask: "If this experiment invalidates your hypothesis, what will you do?"

### Phase 7: Plan Execution and Review

**Goal:** Prepare for running the experiment.

1. **Execution Readiness:**
   - Verify all prerequisites can be met
   - Confirm resources are available
   - Identify who will review before execution

2. **Set Expectations:**
   - Remind: "All experiments require human review before execution"
   - Ask: "Who should approve this experiment?"
   - Ask: "When do you plan to run it?"

3. **Plan for Results:**
   - Discuss what happens after:
     - If validated: What action follows?
     - If invalidated: What changes?
     - If inconclusive: Re-run with modifications?
   - Document expected follow-up actions

4. **Suggest Next Steps:**
   - Recommend review by relevant stakeholders
   - Suggest timeline for execution
   - Offer to help interpret results when available

## Reference Materials

- **Experiment Template:** See `docs/experiments/EXPERIMENT.template.md`
- **Best Practices:** See `references/experiment_design_best_practices.md`
- **ADR 0007:** Documents the decision to use experiments for empirical validation

## Success Criteria

- An experiment document is created following the standard template
- The hypothesis is falsifiable and specific
- Success criteria are measurable and tied to the hypothesis
- The protocol is detailed enough for agent execution
- Variables and controls are explicitly identified
- Limitations and risks are documented
- The user understands what the experiment will and won't tell them
- The experiment is ready for human review and approval

## Notes

- Be respectfully rigorous—challenge vague thinking without being dismissive
- Quantitative metrics are preferred; qualitative should be automatable when possible
- Every experiment should be reproducible and re-runnable
- Negative and inconclusive results are valuable—design to capture them
- If the user seems to be seeking validation rather than truth, gently redirect
- An experiment that can't be falsified isn't an experiment—it's a demonstration
