# Bet: Agents reliably make atomic code changes at low cost

Status: unproven
Created: 2026-01-29

## Belief

By end of 2026, with appropriate setup (explicit context, LLM-friendly specs, repeatable patterns, proper tooling), AI agents can reliably make atomic code changes with:
- **100% success rate** on a benchmark of at least 1000 tasks
- **Average cost ≤ €0.05** per task (January 1, 2026 EUR value)

An **atomic code change** is the smallest meaningful unit of work: a few lines at most, a single logical step. Examples include adding an early return statement, renaming a variable, renaming a file, implementing a simple reduce operation, adding a validation check.

A **precise specification** provides clear boundaries and defined logic—no architectural or design decisions required. For example: "add this business rule to this Order's purchase method" rather than "should this be an entity or a value object?"

**Correctness** is validated against test suites. The agent does not see the ground truth test during execution; it must write its own tests if it chooses a TDD approach. Success is judged by whether the hidden evaluation tests pass.

## Because

**Cost trajectory:** LLM inference costs have been declining approximately 3-4x per year. GPT-4 equivalent performance went from $20/M tokens (2022) to $0.40/M tokens (2025)—a 50x decline over 3 years. This trend is expected to continue through 2026 with new hardware (H200, DDR6) and model efficiency improvements. A €0.05 budget that feels tight today will allow significantly more iterations by end of 2026.

**Capability trajectory:** Even if current LLM architectures plateau, the long-term trend toward improved AI performance will continue—whether through better LLMs, hybrid systems, or alternative architectures. The bet is on the outcome, not a specific technology.

**Setup as force multiplier:** Current research shows agents struggle with complex, long-running tasks but perform well with good test suites and clear context. The hypothesis is that with sufficient investment in setup—explicit context, LLM-friendly patterns, proper typing, guidelines, processes, and tools—100% reliability on atomic changes is achievable.

**Why 100%:** Errors compound. A 95% reliable system cannot be a foundation to build upon. 100% reliability on atomic changes enables treating agents as trustworthy primitives for larger workflows.

## Evaluation

### Right when

By December 31, 2026, an internal benchmark demonstrates:
1. **1000+ atomic change tasks** drawn from real codebases
2. **100% success rate**: every task passes its evaluation test suite
3. **Average cost ≤ €0.05** per task across all tasks (some may cost more, some less)
4. Cost measured in January 1, 2026 EUR value
5. Cost includes all inference, compute, and iteration costs

The benchmark must use hidden evaluation tests that the agent cannot see during execution.

### Wrong when

By December 31, 2026, any of the following:
1. Cannot construct a 1000+ task benchmark that achieves 100% success rate, OR
2. Average cost exceeds €0.05 per task, OR
3. The setup required is so artificial that it doesn't represent real codebase conditions

No partial credit. 99.9% is not 100%.

## Alternatives Considered

### Costs stop decreasing
The dramatic cost decline could slow or halt due to hardware constraints, market consolidation, or diminishing returns on efficiency.

**Rejected because:** Multiple independent drivers are pushing costs down—hardware improvements, model distillation, inference optimization, competition. Even if the rate slows, continued decline through 2026 is highly likely.

### LLMs plateau at <100% reliability
Current LLM architectures may have fundamental limitations that prevent 100% reliability regardless of setup effort.

**Rejected because:** Even if LLMs specifically plateau, the bet is on outcomes, not specific technologies. Alternative approaches (hybrid systems, formal verification integration, specialized models) may bridge the gap. Additionally, 100% on *atomic* changes is a narrower target than general coding—focused investment in setup may overcome limitations.

### Setup cost exceeds value gained
Achieving 100% reliability may require so much setup effort (typing, guidelines, patterns, tooling) that the total cost exceeds just having humans write the code.

**Rejected because:** Setup cost is amortized across all future changes. A codebase with proper typing, explicit context, and LLM-friendly patterns benefits every subsequent task. The upfront investment pays dividends at scale.

## Implications

If this bet is right:

**The developer role transforms:**
- Work shifts to building specs, defining vision, making architectural and design decisions
- Code review becomes spec review—verify the intent is correct, trust the execution
- Less time reading/writing code, more time thinking about what code should do

**Codebases become fluid:**
- Entire codebases can be rewritten incrementally: "now we code X like this" applied as thousands of atomic changes
- Refactoring at scale becomes tractable
- Technical debt can be systematically eliminated

**Agent setup becomes crucial:**
- Investment in LLM-friendly codebase patterns pays off
- Proper typing, explicit interfaces, clear module boundaries become essential
- Guidelines and processes for agent-friendly development become valuable
- This repository's focus on agent guidelines is validated

**Economic shift:**
- At €0.05 per atomic change (~3 seconds of €60/hr developer time), agents win on cost by definition
- Developer leverage increases dramatically
- Small teams can maintain larger codebases

## Review Schedule

- **Q2 2026:** Check inference cost trends, begin benchmark construction, early reliability experiments
- **Q3 2026:** Benchmark at 500+ tasks, assess progress toward 100%
- **Q4 2026:** Final evaluation on full 1000+ task benchmark

## Related

- ADRs: [0002 - Use Bet Records to document foundational beliefs](../adr/0002-use-bet-records-to-document-foundational-beliefs.md)
- Bets: []
