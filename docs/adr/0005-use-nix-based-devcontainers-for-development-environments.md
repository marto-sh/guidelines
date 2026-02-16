---
number: 5
title: Use Nix-based Devcontainers for Development Environments
status: accepted
date: 2026-01-30
---

# Use Nix-based Devcontainers for Development Environments

## Context and Problem Statement

AI agents working on this codebase need a predictable, reproducible environment to operate reliably. [Bet 0001](../bets/0001-agents-reliably-make-atomic-changes.md) establishes that agents can make reliable changes given proper tooling—but this requires the environment itself to be deterministic.

Three concerns drive this decision:

1. **Reduced decision space**: Following Bet 0001, we want to minimize choices agents must make. If environment setup is fully automated, there is no room for error—agents don't need to decide how to install tools or configure dependencies.
2. **Reproducibility**: Package versions must be identical across all environments. Traditional package managers (apt, cargo install) can drift over time, causing subtle failures.
3. **Isolation**: Agents should operate in a sandbox where mistakes cannot affect the host system. This enables autonomous operation without risk.

## Decision Drivers

* **Reduced decision space** — automated setup eliminates choices agents must make, leaving no room for error (see [Bet 0001](../bets/0001-agents-reliably-make-atomic-changes.md))
* **Agent reproducibility** — agents must get identical environments to produce consistent results
* **Zero manual setup** — contributors should not need to install tools manually (error-prone)
* **Sandbox isolation** — agents can break the environment without affecting the host
* **Setup complexity is acceptable** — we prefer correctness over ease of initial configuration

## Considered Options

* Devcontainer with apt/cargo (simple container)
* Pure Nix flakes with direnv
* Nix-based Devcontainer (hybrid)
* Documentation only

## Decision Outcome

Chosen option: "Nix-based Devcontainer", because it is the only option that provides both byte-for-byte reproducibility (via Nix) and container isolation (via devcontainer).

### Consequences

* Good, because environments are reproducible via Nix lockfile
* Good, because agents operate in isolated containers
* Good, because contributors get zero-setup onboarding ("Open in Container")
* Good, because the devcontainer spec is widely supported (VS Code, GitHub Codespaces, DevPod)
* Bad, because Nix has a steep learning curve for maintenance
* Bad, because container builds are slower than native Nix

### Confirmation

The devcontainer configuration includes:

1. A `flake.nix` defining all development dependencies
2. A `flake.lock` pinning exact versions
3. A Dockerfile that installs Nix and builds the flake
4. CI validation that the devcontainer builds successfully

## Pros and Cons of the Options

### Devcontainer with apt/cargo

Simple container using traditional package managers.

Even with explicit version pins, reproducibility is not guaranteed:

* Base images like `rust:1.75-bookworm` can have underlying packages updated
* Apt versions can be removed from repositories, breaking `apt install pkg=1.2.3`
* Cargo crates can be yanked (rare but possible)
* Transitive dependencies are not tracked or pinned

Pros/cons:

* Good, because low complexity and familiar tooling
* Good, because fast initial setup
* Bad, because reproducibility is not guaranteed even with version pins
* Bad, because no cryptographic verification of dependencies

### Pure Nix flakes with direnv

Nix manages the environment directly on the host.

* Good, because maximum reproducibility
* Good, because fast rebuilds with Nix cache
* Bad, because no container isolation — agents run on host
* Bad, because requires Nix installed on contributor machines (manual step)
* Bad, because agents are less familiar with Nix syntax

### Nix-based Devcontainer (hybrid)

Nix manages packages inside a devcontainer.

Nix provides byte-for-byte reproducibility through:

* `flake.lock` pins cryptographic hashes of every dependency
* Binary cache preserves all versions indefinitely
* Complete dependency closure is tracked (including transitive deps)
* Builds are deterministic—same inputs always produce same outputs

Pros/cons:

* Good, because maximum reproducibility via Nix lockfile
* Good, because full container isolation
* Good, because zero manual setup for contributors
* Neutral, because more complex Dockerfile
* Bad, because slower builds (container + Nix)
* Bad, because Nix learning curve for maintenance

### Documentation only

Document required tools without automation.

* Good, because no tooling overhead
* Bad, because manual steps lead to errors
* Bad, because environments will diverge
* Bad, because agents cannot self-setup

## More Information

### Implementation

This decision requires updating the existing devcontainer to:

1. Add a `flake.nix` with development dependencies (Rust, Cocogitto, etc.)
2. Modify the Dockerfile to install Nix and build the flake
3. Remove manual `cargo install` commands from setup script

### Related Decisions

* [Bet 0001: Agents Reliably Make Atomic Changes](../bets/0001-agents-reliably-make-atomic-changes.md) — foundational belief requiring reproducible environments
* [ADR 0003: Use Rust as the Primary Programming Language](0003-use-rust-as-the-primary-programming-language.md) — Rust toolchain must be included
* [ADR 0004: Use Conventional Commits](0004-use-conventional-commits.md) — Cocogitto must be included

### References

* [Dev Container Specification](https://containers.dev/)
* [Nix Flakes](https://nixos.wiki/wiki/Flakes)
* [nix-devcontainer](https://github.com/xtruder/nix-devcontainer) — reference implementation
