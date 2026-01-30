---
number: 3
title: Use Rust as the Primary Programming Language
status: accepted
date: 2026-01-30
---

# Use Rust as the Primary Programming Language

## Context and Problem Statement

These guidelines aim to optimize codebases for agent-assisted development. [Bet 0001](../bets/0001-agents-reliably-make-atomic-changes.md) establishes that with appropriate setup—including explicit context, LLM-friendly specs, and proper tooling—AI agents can reliably make atomic code changes. A critical question emerges: which programming language provides the best foundation for agent-assisted development?

The hypothesis is that static type checking provides compiler feedback that helps agents self-correct, leading to higher success rates. The more errors caught at compile time, the more feedback loops agents have before runtime.

## Decision Drivers

* **Agent feedback loops**: 94% of LLM-generated compilation errors are type-check failures ([GitHub Blog, 2025](https://github.blog/ai-and-ml/llms/why-ai-is-pushing-developers-toward-typed-languages/))—strong static typing catches the dominant error class
* **Corpus uniformity**: Rust's ecosystem (cargo, rustfmt, Clippy, test culture) produces a more uniform training corpus, leading to more reliable and idiomatic code generation
* **Compiler error quality**: Rust's compiler provides detailed, structured errors that serve as an immediate feedback loop for LLMs
* **Static reasoning alignment**: Agent-authored PRs rely on static-reasoning-based validation 67.2% of the time vs 44.9% for humans ([arXiv study](https://arxiv.org/html/2512.21757))
* **Type system as contract**: Types function as shared contracts between developers, frameworks, and AI tools, ensuring code from any source conforms to project standards
* **Alignment with Bet 0001**: Investment in setup (including language choice) is amortized across all future agent-assisted changes

## Considered Options

* **Rust** — Systems language with ownership model, borrow checker, and strong static typing
* **TypeScript** — Typed superset of JavaScript, large ecosystem, excellent tooling
* **Python with strict typing** — Dynamic language with optional type hints and external checkers (mypy, pyright)
* **Go** — Statically typed, simple, fast compilation, no generics complexity
* **Domain-specific recommendations** — Different languages for different use cases (Rust for CLI, TypeScript for web, Python for ML)

## Decision Outcome

Chosen option: **Rust**, because it provides the strongest static type guarantees and the most comprehensive compiler feedback, directly supporting the hypothesis that type safety improves agent performance. The borrow checker and ownership model, while adding complexity, catch entire classes of bugs (memory safety, data races) that other languages cannot detect at compile time.

### Consequences

* **Good**, because maximum compile-time error detection provides the richest feedback loop for agents
* **Good**, because Rust's uniform ecosystem (cargo, rustfmt, Clippy) produces consistent patterns that LLMs generate reliably
* **Good**, because memory safety and thread safety are guaranteed without runtime overhead
* **Good**, because the decision aligns with and supports Bet 0001's investment-in-setup philosophy
* **Bad**, because Rust has a steep learning curve, especially the borrow checker and lifetime annotations
* **Bad**, because Rust's rapid API evolution causes challenges—LLMs achieve only 38% success on APIs that changed after training cutoff ([RustEvo² benchmark](https://arxiv.org/abs/2503.16922))
* **Bad**, because the ML/AI ecosystem is smaller than Python's; some use cases may require Python interop or exceptions
* **Neutral**, because teams adopting these guidelines will need agent-assisted learning support to ramp up on Rust

### Confirmation

This decision will be validated through:

1. **Agent success metrics**: Track task completion rates on Rust codebases vs baseline, targeting alignment with Bet 0001's 100% success rate goal
2. **Team productivity**: Measure time-to-feature, bug rates, and onboarding time for teams new to Rust
3. **Qualitative feedback**: Regular retrospectives on developer and agent experience
4. **6-month review checkpoint**: Revisit this decision if metrics indicate Rust is proving too difficult for agents or teams

**API evolution mitigation strategy**:
- Prefer models with more recent training cutoffs
- Pin dependency versions to those within model cutoff when possible
- Provide current API documentation to agents when pinning isn't feasible (e.g., via RAG)

**ML ecosystem handling**: Evaluate on a case-by-case basis—use Rust-native crates (burn, candle) when available, create Rust wrappers around Python libraries, or permit Python in the codebase when necessary.

## Pros and Cons of the Options

### Rust

* Good, because strongest static type guarantees in mainstream languages
* Good, because borrow checker catches memory safety and data race bugs at compile time
* Good, because uniform ecosystem produces reliable LLM generations
* Good, because detailed compiler errors serve as agent feedback loop
* Neutral, because performance benefits may not matter for all use cases
* Bad, because steep learning curve, especially for ownership and lifetimes
* Bad, because 38% LLM success rate on post-cutoff API changes
* Bad, because smaller ecosystem for web and ML domains

### TypeScript

* Good, because now the most-used language on GitHub (Octoverse 2025), massive training corpus
* Good, because excellent error messages and LSP tooling
* Good, because gentler learning curve than Rust
* Good, because dominant in web development ecosystem
* Neutral, because +66% YoY growth suggests strong momentum
* Bad, because "permissive type system leaves more room for ambiguous or deferred errors"
* Bad, because heterogeneous corpus (style and quality vary widely) leads to less reliable generations
* Bad, because no memory safety guarantees

### Python with strict typing

* Good, because dominant ecosystem for ML/AI (PyTorch, transformers, scikit-learn)
* Good, because lowest learning curve, most accessible
* Good, because type hints + mypy/pyright catch many errors statically
* Neutral, because typing is optional, creating inconsistent codebases
* Bad, because weak typing leads to low code coverage in test generation studies
* Bad, because runtime errors dominate over compile-time feedback
* Bad, because "does not present the same challenges associated with inferring correct types as seen in strongly typed languages"

### Go

* Good, because very fast compilation—optimized for development speed and quick feedback loops
* Good, because statically typed with good tooling
* Good, because easier to learn than Rust
* Good, because fast compile times mean cheaper agent iterations (less compute per feedback cycle)
* Neutral, because smaller ecosystem than TypeScript or Python
* Bad, because generics are limited—no generic methods, weak type constraints, described as "a transitional solution"
* Bad, because cannot encode complex type relationships or make "invalid states impossible to represent"
* Bad, because fewer compile-time guarantees than Rust—type safety is "good enough" but not maximal

### Domain-specific recommendations

* Good, because pragmatic—use the best tool for each job
* Good, because avoids forcing Rust into domains where it's weaker (ML, rapid prototyping)
* Neutral, because adds decision overhead for each new project
* Bad, because inconsistent tooling and patterns across codebases
* Bad, because agents must context-switch between language idioms
* Bad, because undermines the "investment in setup" philosophy—setup effort isn't reusable across languages

## More Information

**Related decisions and resources**:
- [Bet 0001: Agents reliably make atomic code changes at low cost](../bets/0001-agents-reliably-make-atomic-changes.md)
- [ADR 0002: Use Bet Records to document foundational beliefs](0002-use-bet-records-to-document-foundational-beliefs.md)
- [GitHub Blog: Why AI is pushing developers toward typed languages](https://github.blog/ai-and-ml/llms/why-ai-is-pushing-developers-toward-typed-languages/)
- [RustEvo² benchmark: API Evolution in LLM-based Rust Code Generation](https://arxiv.org/abs/2503.16922)
- [RunMat: Choosing Rust for LLM-Generated Code](https://runmat.org/blog/why-rust)

**Onboarding approach**: Teams new to Rust should leverage agent-assisted learning—using AI agents to explain Rust concepts, help debug borrow checker errors, and guide through ownership patterns. This approach aligns with the overall philosophy of these guidelines.
