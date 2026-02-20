# TODO

## Skills to Create

- [ ] Add a code review skill (review PRs or commits)
- [ ] Add a learning skill whenever human gives feedback for the agent to remember
- [ ] Add continuous learning to skills: after completing a skill, the agent should reflect on what needed human guidance, what went well, and what went wrong — then update the skill's rules and examples to avoid repeating mistakes. This should be a systematic step built into every skill, not ad-hoc.

## Process

- [ ] Define Git merge strategy for PRs (merge commit, rebase, or squash)
- [ ] Define how agent sessions should be stored so that precious human inputs (domain knowledge, design decisions, feedback) are never lost. Sessions contain irreplaceable context that cannot be reconstructed from code alone. Smarter agents could also review past sessions to extract learnings that less capable agents wouldn't have gathered at the time.

## ADRs to Create

- [ ] Define standard repository setup (public, AGPL-3.0 license)
- [ ] DateTime conventions (UTC storage, audit fields, serialization format, no local time in domain)
- [ ] Testing
- [ ] Context preservation (capture reasoning and context for handoff)
- [ ] Git worktree isolation for parallel agent work
- [ ] Agent PR reviews
- [ ] Agent-human collaboration
- [ ] Task partitioning (divide work to minimize agent conflicts)
- [ ] CI/CD with local feedback mode (avoid remote server calls for faster iteration)

## Tooling

- [ ] Linter/validator for BETs (ensure frontmatter, required sections, valid status)
- [ ] Linter/validator for Experiments (ensure frontmatter, required sections, valid status)

## Documentation

- [ ] Research current approaches to context engineering for coding agents: <https://martinfowler.com/articles/exploring-gen-ai/context-engineering-coding-agents.html>
- [ ] Define philosophy and guiding principles
- [ ] Bet: Agents consistently apply tactical design patterns (DDD, hexagonal, coding guidelines)
- [ ] Distill knowledge from <https://12factor.net/> into architecture documents
- [ ] Distill knowledge from <https://martinfowler.com> into architecture documents
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

## Refactor

## Experiments

- [ ] **Multi-agent conflict resolution**: when two agents work in parallel and produce conflicting changes (e.g. overlapping PRs), what is the best strategy for an agent to resolve the conflict? Does pulling context from both PRs (understanding the intent behind each change) yield better resolutions than treating it as a pure text merge? This is distinct from commit reorganization — it is about understanding intent to resolve semantic conflicts.
- [ ] Can an LLM reliably follow an atomic rule?
- [ ] Design experiment to determine which models can run on consumer hardware (in particular Mac Mini)
- [ ] What's the performance gain of having an LLM fine tuned on Rust?
- [ ] What's the performance gain of giving access to the AST to an LLM?
- [ ] How much performance can be improved on a given model (distillation, profiling and optimization, etc.)?
- [ ] Assess if we can offload knowledge from LLM weights and have them stored in a separate, white-box system (e.g. a database)
- [ ] Evaluate <https://docs.boxlite.ai/> for ADR-0005

## Projects

- [ ] Build an RSS/feed aggregator for interesting ideas — curate sources like arXiv papers, thoughts from key thinkers (François Chollet, Yann LeCun, etc.), blog posts, and documentation updates from relevant websites. Goal: a single feed to stay on top of ideas relevant to the project.

## Interesting Ideas

- [ ] François Chollet's analogy between agentic coding and ML training: if spec+tests are the optimization goal and agents are the optimizer, the generated codebase is a blackbox model — implying classic ML issues (overfitting to spec, Clever Hans shortcuts, data leakage, concept drift) will hit agentic coding too. What mitigations apply? What is the "Keras of agentic coding" — the optimal high-level abstractions for humans to steer codebase generation? (<https://x.com/fchollet/status/2024519439140737442>)
