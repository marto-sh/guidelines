---
number: 12
title: Use Shared Crates with Unified API for Cross-Cutting Concerns
status: accepted
date: 2026-02-20
---

# Use Shared Crates with Unified API for Cross-Cutting Concerns

## Context and Problem Statement

Multiple marto-sh projects need capabilities like text-to-speech (TTS), and in the future potentially speech-to-text (STT) or other cross-cutting concerns. These projects have different requirements — for instance, libre-code needs lightweight, low-resource TTS while libre-cv may need high-quality voice output or voice cloning. Today, no Rust crate provides a unified interface over multiple neural TTS backends with explicit engine selection.

Without a shared approach, each project would depend directly on individual engine crates (e.g., `piper-rs`, `kokoro-tts`, `pocket-tts`), leading to inconsistent APIs, duplicated integration effort, and tight coupling to specific engines. When a better engine emerges, each project would need to be updated independently.

How should marto-sh projects consume capabilities like TTS while maintaining a consistent API surface and the ability to evolve engine choices independently?

## Decision Drivers

* **Consistent API surface** — all marto-sh projects should interact with TTS (and similar concerns) through the same interface
* **Engine evolvability** — adding or swapping backends should not require changes in consuming projects
* **No existing crate fills this gap** — research (Feb 2026) found no Rust crate offering a unified trait-based interface over multiple neural TTS engines with explicit selection
* **Reusable pattern** — the approach should generalize to other cross-cutting concerns (STT, etc.) as separate crates following the same pattern
* **Centralized guidance** — model benchmarks, tradeoffs, and selection guidance should live alongside the code, not scattered across projects

## Considered Options

* **Shared crate with unified API and explicit engine selection**
* **Direct dependency per project**
* **Contribute to an existing crate**
* **Shared crate with declarative engine selection**

## Decision Outcome

Chosen option: "Shared crate with unified API and explicit engine selection", because it provides a consistent interface across projects while keeping engine choice transparent and debuggable.

For each cross-cutting concern (starting with TTS), a dedicated crate is created within the marto-sh organization. The crate:

1. **Exposes a unified trait-based API** — consuming projects code against a common interface, not engine-specific APIs.
2. **Supports multiple backends** gated by Cargo features — consumers explicitly choose which engine to use (e.g., `marto-tts = { features = ["piper"] }`).
3. **Includes a configuration skill** — the crate's repository contains a skill that guides projects through selecting and configuring the right backend for their needs, based on documented benchmarks and tradeoffs.
4. **Includes reference documentation** — benchmarks, capability matrices, and tradeoff analyses for each supported backend.

This pattern is intended to be **replicated for other concerns** (e.g., a future `marto-stt` crate), each as a separate, focused crate — not a monolithic speech processing library.

### Consequences

* Good, because all projects use the same API regardless of which engine they select
* Good, because adding a new engine is a crate-internal change — consumers are unaffected unless they opt in
* Good, because the model selection skill and reference docs provide structured guidance without encoding it in code
* Good, because engine choice remains transparent and debuggable (consumers know exactly which engine they selected)
* Good, because the pattern generalizes cleanly to STT and other concerns as separate crates
* Bad, because building and maintaining a multi-backend abstraction crate is a real investment
* Bad, because if backends diverge too much in capabilities, the unified trait may become a leaky abstraction that constrains what engines can express
* Neutral, because this creates an additional repository to maintain per concern, but each is small and focused

### Confirmation

This decision will be validated through:

1. **First crate: marto-tts** — build the TTS crate with at least two backends (one lightweight, one higher-quality) and integrate it into both libre-code and libre-cv
2. **API stability test** — adding a third backend should require zero changes in consuming projects
3. **Abstraction fitness** — if the unified trait requires engine-specific escape hatches for more than 20% of use cases, the abstraction should be reconsidered
4. **Pattern reuse** — when the next concern (e.g., STT) arises, applying the same pattern should feel natural, not forced

## Pros and Cons of the Options

### Shared crate with unified API and explicit engine selection

Each cross-cutting concern gets its own marto-sh crate with a trait-based interface. Consumers explicitly pick the backend via Cargo features. The crate includes a configuration skill and reference docs.

* Good, because consistent API surface across all projects
* Good, because engine choice is explicit and transparent — no hidden magic
* Good, because Cargo features keep binary size minimal (only compile selected backends)
* Good, because centralizes benchmarks, tradeoffs, and selection guidance in one place
* Good, because generalizable pattern for future concerns
* Bad, because upfront investment to design the trait and integrate multiple backends
* Bad, because risk of leaky abstraction if engines have fundamentally different capability models

### Direct dependency per project

Each project depends directly on whichever engine crate suits it best (e.g., libre-code uses `piper-rs`, libre-cv uses `pocket-tts`).

* Good, because zero upfront investment — just add a dependency
* Good, because each project gets the most native API for its chosen engine
* Good, because no abstraction to maintain
* Bad, because inconsistent APIs across projects
* Bad, because duplicated integration code (audio output, error handling, configuration)
* Bad, because swapping engines requires rewriting integration code per project
* Bad, because no shared knowledge base about engine tradeoffs

### Contribute to an existing crate

Fork or contribute to an existing multi-backend crate (e.g., `natural-tts`) rather than building from scratch.

* Good, because builds on existing work and community
* Good, because less upfront effort than starting from scratch
* Bad, because `natural-tts` has low activity and PyO3 dependencies for some backends
* Bad, because the `tts` crate only wraps OS speech APIs, not neural engines
* Bad, because contributing to an external project means less control over API direction and release cadence
* Bad, because no existing crate matches the desired architecture (trait-based, Cargo-feature-gated, with selection guidance)

### Shared crate with declarative engine selection

Same shared crate, but consumers declare requirements (quality tier, latency budget, cloning support) and the crate automatically selects the best engine.

* Good, because consumers don't need to know about specific engines
* Good, because engine upgrades can happen transparently
* Bad, because requires designing a "requirements vocabulary" upfront that may be wrong or incomplete
* Bad, because hides which engine is running, making debugging harder
* Bad, because the mapping from requirements to engines is an opinionated policy embedded in code
* Bad, because unnecessary complexity when the crate owner controls all consuming projects

## More Information

### Rust TTS Ecosystem (Feb 2026)

Research found no existing crate that fills this gap. The landscape includes:

- **`tts`** (v0.26) — trait-based but wraps OS speech APIs only (SAPI, Speech Dispatcher, AVFoundation), not neural TTS
- **`piper-rs`** — Piper/ONNX, lightweight, CPU-only, single engine
- **`kokoro-tts` / `kokoroxide`** — Kokoro 82M, fast, CPU-only, single engine
- **`pocket-tts`** (v0.6) — pure Rust via Candle, voice cloning + streaming, single engine
- **`natural-tts`** — multi-backend but low activity, PyO3 dependencies
- **`sherpa-rs`** — wraps sherpa-onnx (TTS + STT + VAD), monolithic runtime

### Related Decisions

* [ADR 0003](0003-use-rust-as-the-primary-programming-language.md) — Use Rust as primary language
* [ADR 0008](0008-share-guidelines-across-projects.md) — Share guidelines across projects
