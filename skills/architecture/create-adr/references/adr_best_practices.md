# ADR Best Practices

This document summarizes best practices for Architecture Decision Records based on research from Google, AWS, Microsoft Azure, Spotify, and other industry leaders.

**Note:** This skill uses the `adrs` CLI tool for creating and managing ADRs. See `adrs_tool_guide.md` for detailed tool documentation.

## Core Principles

### 1. Immutability
- Once accepted or rejected, ADRs are **immutable**
- Never alter existing content—instead, supersede with a new ADR
- This preserves the historical context and reasoning at the time of the decision

### 2. One Decision Per ADR
- Focus on a single architectural decision
- Avoid combining multiple decisions into one document
- Keeps documents focused and easier to reference

### 3. Honest Trade-off Documentation
- **Always document negative consequences**, not just positive ones
- Show what alternatives were considered and why they were rejected
- Demonstrate that the decision was thoughtful, not predetermined

### 4. Keep It Concise
- Aim for 1-2 pages total
- Be factual and assertive, not verbose
- Future readers will appreciate brevity

## When to Write an ADR

### Spotify's Rule of Thumb
> "If the decision will be referenced six months later—or it could save someone a week of rediscovery—write an ADR."

### Write ADRs for Decisions That:
- Affect system qualities (availability, performance, security, cost, compliance)
- Are hard to reverse (data model, language/runtime, cloud provider selection)
- Impact multiple teams or system components
- Require significant investment (time, money, resources)
- Have multiple viable approaches requiring trade-off analysis

### Skip ADRs for:
- Trivial implementation details
- Decisions that can be easily changed
- Local code style choices covered by linters
- Decisions with only one obvious solution

## ADR Lifecycle

### Status Workflow
```
Proposed → Accepted → Superseded
         ↓
      Rejected
         ↓
      Deprecated
```

### State Definitions
- **Proposed:** Under discussion, seeking feedback
- **Accepted:** Approved and actively in use
- **Rejected:** Considered but not adopted (document why to prevent future rediscussion)
- **Deprecated:** No longer recommended but not yet replaced
- **Superseded:** Replaced by newer ADR (include reference to replacement)

## Storage and Organization

### Recommended Directory Structure
```
/project-root
  /docs
    /adr
      README.md          # Index of all ADRs
      0001-use-microservices.md
      0002-choose-postgresql.md
      0003-implement-event-sourcing.md
```

### File Naming Convention
- Format: `NNNN-title-with-dashes.md`
- NNNN: Four-digit sequential number (0001-9999)
- Title: Lowercase with dashes
- Extension: `.md` (Markdown)

### Numbering Rules
- Sequential and monotonic
- Never reuse numbers
- Start at 0001 (or 0000 for meta-ADR about using ADRs)
- Increment by 1 for each new ADR

## The Review Process (AWS/Azure Pattern)

### Collaborative Approach
1. **Readout Meeting Style:**
   - Participants spend 10-15 minutes reading the ADR
   - Provide written comments on sections requiring clarification
   - Keep total participants below 10

2. **Cross-functional Representation:**
   - Invite representatives from each affected team
   - Ensure diverse perspectives

3. **Iteration:**
   - Author gathers feedback
   - Revises ADR based on input
   - May require multiple rounds

4. **Approval:**
   - Add timestamp, version, stakeholder list
   - Update status to "Accepted"
   - Store in version control

## Required Sections

### Minimum (Michael Nygard's Original)
1. **Title** - Short phrase, imperative form
2. **Status** - Current state with date
3. **Context** - Problem and forces, value-neutral
4. **Decision** - What was chosen, active voice
5. **Consequences** - Positive, negative, and neutral impacts

### Enhanced (MADR/AWS Pattern)
6. **Decision Drivers** - Factors influencing the decision
7. **Considered Options** - All alternatives evaluated (minimum 3)
8. **Pros/Cons of Options** - Detailed analysis for transparency
9. **Validation** - Success criteria and evaluation plan
10. **Related Decisions** - Links to superseding/related ADRs

## Writing Tips

### Context Section
- State the problem, not the solution
- Use value-neutral language (don't bias toward your preference)
- Explain constraints (technical, business, team, time)
- Make it understandable to someone unfamiliar with the project

### Decision Section
- Start with "We will..." or "We have decided to..."
- Explain the reasoning, not just the choice
- Reference decision drivers explicitly
- Keep it focused—details go in other sections

### Consequences Section
**This is the most important section!**
- Always include positive, negative, AND neutral consequences
- Be honest about trade-offs
- Think about:
  - What becomes easier? (testing, deployment, scaling)
  - What becomes harder? (operations, learning curve, cost)
  - What risks are introduced?
  - What future options are enabled or closed off?

### Considered Options Section
- List at least 3 options
- Include brief description of each
- Show you did your homework

### Pros/Cons Section
- Be fair to all options
- Include technical, operational, and business perspectives
- Helps readers understand why runner-ups didn't win

## Common Anti-Patterns to Avoid

### 1. Post-hoc Justification
**Bad:** Writing an ADR after implementing to justify a predetermined choice
**Good:** Writing an ADR during the decision-making process

### 2. Avoiding Negative Consequences
**Bad:** Only listing positive outcomes
**Good:** Honestly documenting trade-offs and risks

### 3. Design Document Disguised as ADR
**Bad:** Using ADR to document detailed design
**Good:** ADR focuses on the decision; design docs provide details

### 4. Too Vague or Abstract
**Bad:** "Use best practices for security"
**Good:** "Use OAuth 2.0 with PKCE for mobile app authentication"

### 5. Rewriting History
**Bad:** Editing old ADRs to reflect current understanding
**Good:** Creating new ADR that supersedes the old one

## Integration with RFC Process

### When to Use Each
- **RFC (Request for Comments):** Use when you need input BEFORE deciding
- **ADR:** Use to document the decision AFTER consensus is reached

### Recommended Workflow
```
Problem Identified
      ↓
Write RFC (if input needed)
      ↓
Gather feedback
      ↓
Reach consensus
      ↓
Write ADR (document decision)
      ↓
Implement solution
```

## Superseding ADRs

### When Context Changes
1. **Create New ADR:**
   - Document new context and decision
   - Reference the old ADR being superseded
   - Explain what changed and why

2. **Update Old ADR:**
   - Change status to "Superseded"
   - Add link to new ADR
   - Add date of superseding
   - Keep all original content intact

### Example
```markdown
Status: Superseded by [ADR-0042](0042-use-postgresql.md)
Superseded on: 2026-01-28
Reason: Performance requirements changed; needed ACID transactions
```

## Maintenance and Review

### Periodic Reviews
- Quarterly or annual architecture reviews
- After major incidents or system changes
- When considering major technology shifts

### Living Documentation
- Store in version control with code
- Automate documentation generation if possible
- Keep index/README up to date

## Tooling

### The adrs CLI Tool

This skill uses the `adrs` tool for creating and managing ADRs. Key benefits:

**Automation:**
- Automatic numbering
- Template generation
- Table of contents generation
- Dependency graph visualization

**Workflow Support:**
- Status management (`adrs status N accepted`)
- Link relationships (`adrs link N1 Supersedes N2`)
- Search capabilities (`adrs search "query"`)
- Health checks (`adrs doctor`)

**Installation:**
```bash
# Homebrew
brew install joshrotenberg/brew/adrs

# Cargo (Rust)
cargo install adrs

# Binary releases
# https://github.com/joshrotenberg/adrs/releases
```

**Basic Usage:**
```bash
# Initialize
adrs init

# Create ADR
adrs new "Use PostgreSQL for Primary Database"

# List ADRs
adrs list

# Update status
adrs status 1 accepted

# Generate documentation
adrs generate toc > doc/adr/README.md
```

**See Also:** `adrs_tool_guide.md` for comprehensive documentation

### Alternative Tools

- **adr-tools** (Bash): Original implementation by Nat Pryce
- **log4brains**: Web-based ADR management with visualization
- **dotnet-adr**: .NET-specific implementation
- **Manual approach**: Direct Markdown file management in version control

## Examples from Industry

### Google's Design Docs
- Similar purpose to ADRs but more upfront
- Emphasize trade-offs considered during decisions
- Written when solution ambiguity exists

### Spotify's Threshold
- "Saves someone a week of rediscovery" test
- Improved onboarding and team alignment
- Reduced rediscovering past decisions

### AWS's Process
- Developed from 200+ ADRs across projects
- Treats ADRs as "team law"
- Strict adherence to lifecycle and format

## Further Reading

### Foundational Resources
- [Michael Nygard's Original Article (2011)](https://cognitect.com/blog/2011/11/15/documenting-architecture-decisions)
- [MADR - Markdown ADR Template](https://adr.github.io/madr/)
- [ADR GitHub Organization](https://adr.github.io/)

### Industry Practice
- [AWS Prescriptive Guidance](https://docs.aws.amazon.com/prescriptive-guidance/latest/architectural-decision-records/)
- [Azure Well-Architected Framework](https://learn.microsoft.com/en-us/azure/well-architected/architect-role/architecture-decision-record)
- [Spotify Engineering Blog](https://engineering.atspotify.com/2020/04/when-should-i-write-an-architecture-decision-record)
- [Google Cloud - Architecture Decision Records](https://cloud.google.com/architecture/architecture-decision-records)

### Tools
- [adrs CLI tool](https://github.com/joshrotenberg/adrs) - Rust-based ADR management (used by this skill)
- [adr-tools](https://github.com/npryce/adr-tools) - Original Bash implementation
- [log4brains](https://github.com/thomvaill/log4brains) - Web-based ADR management
