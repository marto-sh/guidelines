---
number: 8
title: Share Guidelines Across Projects
status: proposed
date: 2026-02-03
---

# Share Guidelines Across Projects

## Context and Problem Statement

This repository contains guidelines, skills, BETs, ADRs, and documentation designed to standardize and improve agent-assisted development. Multiple projects need to consume these guidelines, and when guidelines are updated, those changes should propagate to all consuming projects with minimal friction.

The challenge is finding the right balance between:

1. **Seamless updates**: When guidelines improve, projects should benefit without manual intervention.
2. **Version control**: Projects may need to pin to specific versions for stability.
3. **Customization**: Some projects may need project-specific overrides or additions.
4. **Simplicity**: The mechanism should be easy to understand and maintain.
5. **Agent compatibility**: The solution must work well with AI coding agents that read AGENT.md and related files.

## Decision Drivers

* **Update propagation** — changes to guidelines should reach consuming projects with minimal manual effort
* **Version pinning** — projects must be able to lock to a specific version for stability
* **Merge conflict avoidance** — the mechanism should minimize or eliminate merge conflicts during updates
* **Agent discoverability** — agents must be able to find and read guidelines without special tooling
* **Offline availability** — guidelines should be available without network access during development
* **Auditability** — teams should be able to see exactly which guidelines version they're using
* **Low ceremony** — updating should not require complex procedures or specialized knowledge

## Considered Options

* **Git submodule** — include guidelines as a submodule in consuming projects
* **Git subtree** — merge guidelines into consuming projects with subtree
* **Package manager** — publish guidelines as a package (npm, cargo, etc.)
* **HTTP fetch at runtime** — fetch guidelines from a URL when agents start
* **Manual copy with update script** — copy files and provide a script to pull updates
* **Symbolic links to local clone** — symlink to a locally cloned guidelines repository

## Decision Outcome

Chosen option: **Git submodule**, because it provides the best balance of automatic updates, version pinning, auditability, and agent compatibility.

With git submodules:

1. **Projects include guidelines**: `git submodule add https://github.com/org/guidelines.git guidelines`
2. **AGENT.md references submodule**: The project's AGENT.md can include or reference `guidelines/AGENT.md`
3. **Updates are explicit**: Run `git submodule update --remote` to pull latest, then commit the new reference
4. **Version is auditable**: The submodule commit SHA is tracked in the parent repository
5. **Works offline**: Once cloned, guidelines are local files

### Consequences

* **Good**, because version is explicitly tracked via commit SHA in the parent repo
* **Good**, because updates are a single command (`git submodule update --remote`)
* **Good**, because guidelines are plain files agents can read directly
* **Good**, because no build step or package manager required
* **Good**, because works with any language ecosystem
* **Good**, because supports pinning to any commit, tag, or branch
* **Bad**, because git submodules have a learning curve for developers unfamiliar with them
* **Bad**, because `git clone` doesn't fetch submodules by default (requires `--recurse-submodules`)
* **Bad**, because submodule updates create additional commits in consuming projects
* **Neutral**, because requires network access for initial clone and updates (but not for day-to-day use)

### Confirmation

This decision will be validated through:

1. **Adoption test**: Successfully integrate guidelines into at least 2 consuming projects
2. **Update workflow**: Perform at least 3 update cycles and measure friction
3. **Agent compatibility**: Verify agents can discover and use guidelines from submodule path
4. **Developer feedback**: Survey developers after 3 months of use
5. **Rollback test**: Successfully pin to an older version when needed

## Pros and Cons of the Options

### Git submodule

Include guidelines as a git submodule that tracks the guidelines repository.

* Good, because updates are explicit and auditable (commit SHA in parent repo)
* Good, because supports version pinning to any commit, tag, or branch
* Good, because guidelines are plain files—no transformation needed
* Good, because works with any language ecosystem
* Good, because supports CI/CD automation for update checks
* Neutral, because requires `--recurse-submodules` on clone
* Bad, because submodules have a reputation for being confusing
* Bad, because switching branches with different submodule states can cause issues
* Bad, because nested submodules (if guidelines ever has dependencies) compound complexity

### Git subtree

Merge guidelines into consuming projects using `git subtree add/pull`.

* Good, because guidelines become part of the repository—no special clone flags needed
* Good, because history is preserved in the consuming repository
* Good, because files are directly accessible without submodule initialization
* Bad, because updates can cause merge conflicts if consuming project modified guideline files
* Bad, because harder to see which version of guidelines is being used
* Bad, because `git subtree pull` can be confusing and error-prone
* Bad, because the consuming repository's history becomes polluted with guidelines commits

### Package manager

Publish guidelines as a package (npm, cargo, pip, etc.).

* Good, because familiar workflow for developers used to package managers
* Good, because semantic versioning provides clear upgrade paths
* Good, because package lock files ensure reproducibility
* Bad, because requires choosing a package manager (language-specific)
* Bad, because guidelines aren't code—packaging them feels unnatural
* Bad, because agents may not know to look in node_modules or similar directories
* Bad, because requires publishing infrastructure and processes
* Bad, because different projects may use different package managers

### HTTP fetch at runtime

Fetch guidelines from a URL when agents start or on demand.

* Good, because always gets the latest version
* Good, because no changes needed to consuming repository
* Good, because works across all projects without setup
* Bad, because requires network access during development
* Bad, because no version pinning—could break projects unexpectedly
* Bad, because agents must support HTTP fetching (not all do)
* Bad, because no auditability of which version was used
* Bad, because introduces latency and potential failures

### Manual copy with update script

Copy guidelines files into projects, provide a script to pull updates.

* Good, because simple to understand—just files in the repository
* Good, because no git submodule complexity
* Good, because full control over when and what to update
* Bad, because easy to forget to run the update script
* Bad, because no clear version tracking without manual documentation
* Bad, because local modifications get overwritten on update
* Bad, because script must handle conflict resolution

### Symbolic links to local clone

Symlink guidelines directory to a locally cloned guidelines repository.

* Good, because changes to guidelines are immediately visible
* Good, because simple to set up and understand
* Bad, because requires each developer to clone guidelines separately
* Bad, because symlinks don't work well across different operating systems
* Bad, because CI/CD systems won't have the linked repository
* Bad, because no version pinning—depends on local clone state
* Bad, because the path to guidelines varies per developer machine

## More Information

### Recommended Project Structure

```
my-project/
├── guidelines/              # Git submodule
│   ├── AGENT.md
│   ├── skills/
│   ├── doc/
│   │   ├── adr/
│   │   └── bets/
│   └── ...
├── AGENT.md                 # Project-specific, references guidelines/
├── src/
└── ...
```

### Project AGENT.md Pattern

The consuming project's AGENT.md should reference the guidelines:

```markdown
# Project Agent Instructions

## Guidelines

This project follows the guidelines in [guidelines/AGENT.md](guidelines/AGENT.md).

## Project-Specific Instructions

[Additional context specific to this project...]
```

### Update Workflow

```bash
# Check for updates
cd my-project
git submodule update --remote guidelines

# Review changes
cd guidelines
git log --oneline HEAD@{1}..HEAD

# Commit the update
cd ..
git add guidelines
git commit -m "chore(guidelines): update to latest version"
```

### CI/CD Integration

Consider adding a scheduled workflow to check for guideline updates:

```yaml
name: Check Guidelines Updates
on:
  schedule:
    - cron: '0 9 * * 1'  # Weekly on Monday
jobs:
  check:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
        with:
          submodules: true
      - name: Check for updates
        run: |
          git submodule update --remote guidelines
          if git diff --quiet guidelines; then
            echo "Guidelines are up to date"
          else
            echo "Guidelines updates available"
            # Create PR or notify team
          fi
```

## Related Decisions

* [ADR 0001](0001-record-architecture-decisions.md) - Record architecture decisions
* [ADR 0006](0006-design-processes-and-tools-for-multi-agent-collaboration.md) - Multi-agent collaboration

## References

* [Git Submodules Documentation](https://git-scm.com/book/en/v2/Git-Tools-Submodules)
* [Git Subtree Tutorial](https://www.atlassian.com/git/tutorials/git-subtree)
