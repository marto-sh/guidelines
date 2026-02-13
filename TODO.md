# TODO

## Skills to Create

- [ ] Add a code review skill (review PRs or commits)
- [ ] Add a learning skill whenever human gives feedback for the agent to remember

## ADRs to Create

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
- [ ] Distill knowledge from https://12factor.net/ into architecture documents
- [ ] Distill knowledge from https://martinfowler.com into architecture documents
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

- [ ] Move experiments to doc instead of docs/ and delete the docs/ folder

## Experiments

- [ ] Can an LLM reliably follow an atomic rule?
- [ ] Design experiment to determine which models can run on consumer hardware (in particular Mac Mini)
- [ ] What's the performance gain of having an LLM fine tuned on Rust?
- [ ] What's the performance gain of giving access to the AST to an LLM?
- [ ] How much performance can be improved on a given model (distillation, profiling and optimization, etc.)?
- [ ] Assess if we can offload knowledge from LLM weights and have them stored in a separate, white-box system (e.g. a database)
- [ ] Evaluate https://docs.boxlite.ai/ for ADR-0005
