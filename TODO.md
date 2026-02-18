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

## Tooling

- [ ] Linter/validator for BETs (ensure frontmatter, required sections, valid status)
- [ ] Linter/validator for Experiments (ensure frontmatter, required sections, valid status)

## Documentation

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

## Refactor

## Experiments

- [ ] Can an LLM reliably follow an atomic rule?
- [ ] Design experiment to determine which models can run on consumer hardware (in particular Mac Mini)
- [ ] What's the performance gain of having an LLM fine tuned on Rust?
- [ ] What's the performance gain of giving access to the AST to an LLM?
- [ ] How much performance can be improved on a given model (distillation, profiling and optimization, etc.)?
- [ ] Assess if we can offload knowledge from LLM weights and have them stored in a separate, white-box system (e.g. a database)
- [ ] Evaluate <https://docs.boxlite.ai/> for ADR-0005
