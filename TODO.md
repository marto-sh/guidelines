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

## Cross-Provider Compatibility

- [ ] Create list of supported coding agents (Claude Code, Gemini CLI, Mistral Vibe, OpenAI Codex, etc.)
- [ ] Ensure instructions work across LLMs (use standard conventions: AGENT.md, skill format, etc.)

## Experiments

- [ ] Design experiment to determine which models can run on consumer hardware (in particular Mac Mini)
- [ ] What's the performance gain of having an LLM fine tuned on Rust?
- [ ] What's the performance gain of giving access to the AST to an LLM?
- [ ] How much performance can be improved on a given model (distillation, profiling and optimization, etc.)?
