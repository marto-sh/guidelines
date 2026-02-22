# TODO

## Skills to Create

- [ ] Create `research/write-research-brief` skill — produces the human-oriented brief from a literature review, presents findings, and suggests next steps (experiments, ADRs, BETs). Requires a brief format ADR first.
- [ ] Add a code review skill (review PRs or commits)
- [ ] Add a learning skill whenever human gives feedback for the agent to remember
- [ ] Add continuous learning to skills: after completing a skill, the agent should reflect on what needed human guidance, what went well, and what went wrong — then update the skill's rules and examples to avoid repeating mistakes. This should be a systematic step built into every skill, not ad-hoc.

## Process

- [ ] Define how agent sessions should be stored so that precious human inputs (domain knowledge, design decisions, feedback) are never lost. Sessions contain irreplaceable context that cannot be reconstructed from code alone. Smarter agents could also review past sessions to extract learnings that less capable agents wouldn't have gathered at the time. Raw human input is the strongest signal; reviewed/approved documents are weaker (may have been approved without full agreement). Specs, docs, etc. can be "views" dynamically generated from this ground truth.
- [ ] Explore having ADR creation automatically generate implementation tasks (e.g., update AGENT.md per ADR 0011, append to TODO.md, or create GitHub issues) so that decisions produce actionable work items agents can pick up
- [ ] Define work tracking vocabulary and structure (e.g., checklist = deterministic list of items, task = atomic unit of work, workstream = series of tasks toward a goal). Likely warrants an ADR.

## ADRs to Create

- [ ] Define standard repository setup and project structure (public, AGPL-3.0 license, directory layout conventions — in particular: where should competition analysis, market research, and other non-code artifacts live?)
- [ ] DateTime conventions (UTC storage, audit fields, serialization format, no local time in domain)
- [ ] Testing
- [ ] Context preservation (capture reasoning and context for handoff)
- [ ] Git worktree isolation for parallel agent work
- [ ] Agent PR reviews
- [ ] Agent-human collaboration
- [ ] Task partitioning (divide work to minimize agent conflicts)
- [ ] CI/CD with local feedback mode (avoid remote server calls for faster iteration)

## Tooling

- [ ] Implement pre-commit hook for ADR 0011: block commit when `docs/adr/*.md` is staged without `AGENT.md`, prompt human for confirmation or require `AGENTMD_VERIFIED=1` for agents
- [ ] Implement CI manual confirmation check for ADR 0011: required review status on PRs that modify `docs/adr/` files
- [ ] Linter/validator for BETs (ensure frontmatter, required sections, valid status)
- [ ] Linter/validator for Experiments (ensure frontmatter, required sections, valid status)
- [ ] Research a unified markdown document validation tool — all our document types (ADRs, BETs, experiments, literature reviews, briefs) are markdown files with specific formats following progressive disclosure. A single tool could: enforce required sections and frontmatter per document type, create and update registry/index files, generate and refresh tables of contents, validate cross-references between documents. Existing leads: [mdvault](https://lib.rs/crates/mdvault) (Rust, schema-based frontmatter validation, type-aware scaffolding), [markdown-validator](https://github.com/mattbriggs/markdown-validator) (declarative structural rules), [rumdl](https://crates.io/crates/rumdl) (Rust markdown linter). Could extend `adrs` or build a new tool covering all document types.

## Documentation

- [ ] Research current approaches to context engineering for coding agents: <https://martinfowler.com/articles/exploring-gen-ai/context-engineering-coding-agents.html>
- [ ] Define philosophy and guiding principles
- [ ] Bet: Agents consistently apply tactical design patterns (DDD, hexagonal, coding guidelines)
- [ ] Bet: Agents reliably apply established engineering patterns at scale (<https://www.modular.com/blog/the-claude-c-compiler-what-it-reveals-about-the-future-of-software>)
- [ ] Bet: Agents cannot yet invent novel abstractions (short/medium term) (<https://www.modular.com/blog/the-claude-c-compiler-what-it-reveals-about-the-future-of-software>)
- [ ] Distill knowledge from <https://12factor.net/> into architecture documents
- [ ] Distill knowledge from <https://martinfowler.com> into architecture documents
- [ ] Incorporate learnings from The Bitter Lesson (<http://www.incompleteideas.net/IncIdeas/BitterLesson.html>)
- [ ] Research and document key tech influencers in design patterns and architectures
  - [ ] Uncle Bob (Robert C. Martin)
  - [ ] Rich Hickey
  - [ ] Martin Fowler
  - [ ] Eric Evans
  - [ ] Vaughn Vernon
  - [ ] Greg Young
  - [ ] Udi Dahan
  - [ ] Jimmy Bogard
  - [ ] Mark Seemann
  - [ ] Vladimir Khorikov
  - [ ] Christopher Alexander
  - [ ] Ralph Johnson
  - [ ] James Coplien
  - [ ] Ward Cunningham
  - [ ] Kent Beck
  - [ ] Michael Nygard
  - [ ] Nat Pryce
  - [ ] Sam Newman

## Cross-Provider Compatibility

- [ ] Create list of supported coding agents (Claude Code, Gemini CLI, Mistral Vibe, OpenAI Codex, etc.)
- [ ] Ensure instructions work across LLMs (use standard conventions: AGENT.md, skill format, etc.)
- [ ] Adopt the `AGENTS.md` convention: add an `AGENTS.md` file at repository root (recognised by OpenAI Codex, Gemini CLI, and others) alongside the existing `AGENT.md`. Define which file name takes precedence per agent and whether the two should be kept in sync or unified.

## ADRs to Revise

- [ ] Revise ADR 0008 (Share Guidelines Across Projects) to account for ADR 0011 (distilled decisions in AGENT.md travel with the shared guidelines)

## Refactor

- [ ] Add Persona section to existing skills that don't have one (now a required section per `skill/authoring`)

## Experiments

- [ ] **Multi-agent conflict resolution**: when two agents work in parallel and produce conflicting changes (e.g. overlapping PRs), what is the best strategy for an agent to resolve the conflict? Does pulling context from both PRs (understanding the intent behind each change) yield better resolutions than treating it as a pure text merge? This is distinct from commit reorganization — it is about understanding intent to resolve semantic conflicts.
- [ ] Can an LLM reliably follow an atomic rule?
- [ ] Design experiment to determine which models can run on consumer hardware (in particular Mac Mini)
- [ ] What's the performance gain of having an LLM fine tuned on Rust?
- [ ] What's the performance gain of giving access to the AST to an LLM?
- [ ] How much performance can be improved on a given model (distillation, profiling and optimization, etc.)?
- [ ] Assess if we can offload knowledge from LLM weights and have them stored in a separate, white-box system (e.g. a database)
- [ ] Evaluate <https://docs.boxlite.ai/> for ADR-0005
- [ ] How can we prevent AI from overfitting on tests in a feedback loop? Code may pass tests but fail to generalize. (<https://www.modular.com/blog/the-claude-c-compiler-what-it-reveals-about-the-future-of-software>)

## Projects

- [ ] Build an RSS/feed aggregator for interesting ideas — curate sources like arXiv papers, thoughts from key thinkers (François Chollet, Yann LeCun, etc.), blog posts, and documentation updates from relevant websites. Goal: a single feed to stay on top of ideas relevant to the project.

## Knowledge Management

- [ ] Investigate broader knowledge management approach — how to capture ideas, fleeting thoughts, and notes that don't fit into research/experiments/ADRs/BETs. Useful reference: <https://diataxis.fr/>
- [ ] Design freshness/maintenance mechanism for literature reviews — scheduled refresh (e.g., every 3 months), signal-driven refresh (e.g., new papers, news), or a combination. See ADR 0013.
- [ ] Build tooling for research process (ADR 0013) — scripts or CLI to create research directories, generate templates, update the index. Enforce structure via CI/pre-commit hooks (similar to ADR tooling).

## Learning

- [ ] Research the state of embeddings: universal embedding spaces for language, vision, audio, and reasoning; similarity/differences in representation; operations that can be performed on embeddings

## Interesting Ideas

- [ ] Train agents as teammates that learn from ADRs, past sessions, and human inputs to make consistent architectural and implementation choices, reducing the need for human alignment efforts (<https://www.modular.com/blog/the-claude-c-compiler-what-it-reveals-about-the-future-of-software>)
- [ ] Leverage the principle that assessing correctness is easier than finding solutions — use this to create validation systems that ensure rule adherence without requiring agents to rediscover solutions
- [ ] Explore using formal proof systems to verify that architectural decisions and implementations comply with established guidelines and constraints
- [ ] If LLMs can perform tasks at a reliability level comparable to code (linters, type checkers, automation tools), no one would challenge their output — just as no one challenges a linter today. The key question is whether we can get there. Supporting quote: *"A large fraction of historical engineering effort has gone into mechanical work: rewriting code, adapting interfaces, migrating systems, and reproducing existing patterns in new environments. AI is rapidly becoming better at these tasks than humans. We should not compete with automation at mechanical work. Instead, engineers should clarify intent with rigor, validate outcomes with tests, and improve their design. Human effort should concentrate where creativity and judgment matter most: and all engineers now have management responsibilities. As migration and implementation accelerate, architectural evolution is no longer limited by how fast humans can rewrite software, but by how clearly we can define where systems should go next."* (<https://www.modular.com/blog/the-claude-c-compiler-what-it-reveals-about-the-future-of-software>)
- [ ] How can we ensure AI-generated code doesn't infringe copyrights? Smaller models that can't memorize large codebases may be forced to learn to code rather than regurgitate snippets — could model size be a lever for copyright safety? (<https://www.modular.com/blog/the-claude-c-compiler-what-it-reveals-about-the-future-of-software>)
- [ ] As implementation becomes cheap, AI amplifies both good and bad structure — enforce a strict process of challenging architectural decisions, abstractions, and task definitions before jumping into implementation. (<https://www.modular.com/blog/the-claude-c-compiler-what-it-reveals-about-the-future-of-software>)
- [ ] François Chollet's analogy between agentic coding and ML training: if spec+tests are the optimization goal and agents are the optimizer, the generated codebase is a blackbox model — implying classic ML issues (overfitting to spec, Clever Hans shortcuts, data leakage, concept drift) will hit agentic coding too. What mitigations apply? What is the "Keras of agentic coding" — the optimal high-level abstractions for humans to steer codebase generation? (<https://x.com/fchollet/status/2024519439140737442>)
- [ ] Not all content has the same trust level — some artifacts are 100% agent-generated (e.g., literature reviews), while others are human-authored or human-validated (e.g., ADRs, BETs). Agent-generated content should carry less weight than human-validated content when used for decision-making or as context for other agents. This implies a trust hierarchy: raw human input > human-reviewed documents > agent-generated artifacts. The `produced_by` provenance field (ADR 0014) is a first step, but a broader content trust model could track validation status (unreviewed, human-skimmed, human-validated) and let agents weigh sources accordingly.

## Interesting Sources

### Influencers

- François Chollet
- Yann LeCun
- Chris Lattner

### Blogs

- <https://www.modular.com/>
