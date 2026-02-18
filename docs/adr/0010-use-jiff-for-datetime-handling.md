---
number: 10
title: Use jiff for DateTime handling
status: accepted
date: 2026-02-18
---

# Use jiff for DateTime handling

## Background: Key DateTime Concepts

Before reading this ADR, it helps to understand a few concepts that are often confused.

**UTC offset vs. timezone name**
A UTC offset (e.g. `-05:00`) tells you how many hours ahead or behind UTC a moment is *right now*. A timezone name (e.g. `America/New_York`) encodes the *rules* for when that offset changes — including daylight saving time (DST) transitions. Two regions can share the same offset today but follow different DST rules, meaning they diverge in the future. The offset alone is not enough to reason correctly about future or past times.

**DST gaps and folds**
When clocks spring forward (e.g. 01:59 jumps to 03:00), there is a one-hour gap: times between 02:00 and 02:59 simply do not exist. When clocks fall back (e.g. 02:00 rolls back to 01:00), there is a fold: times between 01:00 and 01:59 exist twice. A library must have an explicit strategy for what to do in these cases; silently returning a wrong time or `None` is a correctness bug.

**Lossless round-trips**
When a datetime is serialized (e.g. written to JSON or stored in a database) and later deserialized, a lossless round-trip means all information is preserved. If only the UTC offset is stored (`2024-07-15T10:00:00-04:00`), the timezone name is lost and future DST arithmetic may be wrong. If the IANA timezone name is also stored (`2024-07-15T10:00:00-04:00[America/New_York]`, per RFC 9557), the round-trip is lossless and arithmetic remains correct after deserialization.

**UTC (Coordinated Universal Time)**
UTC is the universal time standard that all other timezones are defined relative to. `America/New_York` is UTC-5 in winter and UTC-4 in summer; `Europe/Paris` is UTC+1 in winter and UTC+2 in summer.

**Civil time**
Civil time (also called "wall clock time") is the time as a human reads it on a clock: `2024-07-15 10:00:00`. It has no timezone attached — it is simply the year, month, day, hour, minute, and second. The same civil time means different instants in different parts of the world.

**Naive datetime**
"Naive" is another term for civil time, used by chrono. `NaiveDateTime(2024-07-15 10:00:00)` is just a calendar reading — it could be anywhere in the world. The term "naive" signals that the value is unaware of timezones, not that it is simple or wrong.

**IANA timezone database (TZDB)**
The authoritative, worldwide database of timezone rules, maintained by IANA. It maps timezone names like `America/New_York` to their full history of UTC offsets and DST rules. Any library claiming proper timezone support must be backed by this database.

---

## Context and Problem Statement

Rust projects require a DateTime library for handling timestamps, durations, and timezone-aware operations. The Rust ecosystem offers several options with significantly different design philosophies, correctness guarantees, and maintenance trajectories. The initial use case is storing UTC audit timestamps (e.g. `published_at: Option<Timestamp>`), but the domain is expected to grow to include user-facing timezone display and calendar arithmetic, making the choice architecturally significant.

## Decision Drivers

* **Correctness by default** — DST arithmetic, serialization round-trips, and ambiguous time handling must work correctly without requiring developers to remember which method to call on which type
* **Long-term maintenance confidence** — the chosen library must have a credible, active maintenance outlook for the years ahead
* **Future-proof timezone support** — even if the initial use case is UTC-only, the library must support IANA timezone arithmetic without a migration when that need arises
* **Ecosystem integration** — serde, sqlx, and other common crates must be reachable

## Considered Options

* `jiff` — modern DateTime library by BurntSushi (author of `ripgrep`, `regex`)
* `time` — lightweight offset-aware DateTime library, no IANA timezone support
* `chrono` — the incumbent, dominant by download count, entering decline

## Decision Outcome

Chosen option: **`jiff`**, because it is the only option that provides correct DST arithmetic, lossless timezone-aware serialization (RFC 9557), and a unified API across civil and zone-aware types — and it is actively invested in by a proven author. While `time` is simpler for the current UTC-only use case, choosing it would require a future migration when timezone-aware operations appear. Choosing jiff now avoids that cost entirely.

### Consequences

* Good, because DST gaps and folds are handled correctly by default — when a time falls in a gap or fold, jiff applies an explicit, documented strategy rather than silently returning a wrong result or an error with no recovery path
* Good, because `Zoned` datetimes serialize with their IANA timezone name following RFC 9557 (e.g. `2024-07-15T10:00:00-04:00[America/New_York]`), so deserializing a stored value reconstructs the full timezone context, not just an offset — making serde round-trips lossless
* Good, because the same API surface (`checked_add`, `in_tz`, `civil::Date`) works uniformly across all datetime types — no split between `NaiveDate`, `NaiveDateTime`, `DateTime<Tz>` as in chrono
* Good, because the library is authored and maintained by BurntSushi, who has a strong, long-term track record
* Bad, because `jiff` is pre-1.0 (currently 0.2.x); one breaking release has already occurred (0.1→0.2). The next breaking change is expected to be 1.0, targeted for Spring/Summer 2026
* Bad, because sqlx integration requires the external `jiff-sqlx` crate (0.1.1, ~30k downloads, Postgres and SQLite only — no MySQL), whereas `time` and `chrono` are built into sqlx natively
* Bad, because `Zoned` is not `Copy` — meaning it cannot be implicitly duplicated by the compiler and must be explicitly `.clone()`d. This is because `Zoned` holds a reference-counted pointer to IANA timezone data on the heap. In practice this rarely matters, since most domain types already contain non-`Copy` fields (e.g. `String`); and `jiff::Timestamp`, used for UTC audit fields, is `Copy`.
* Neutral, because `jiff::Timestamp` (a nanosecond-precision Unix epoch value) maps cleanly onto UTC-only audit fields, so the initial use case requires only a small API surface

### Confirmation

* All date/time types in the codebase use `jiff` types — `Timestamp`, `Zoned`, `civil::Date`, etc. No `chrono` or `time` types appear in domain or application code
* Dependency audits (`cargo deny` or `cargo audit`) flag any introduction of `chrono` or `time` as a direct dependency
* The project upgrades to jiff 1.0 when it is released, reviewed as a dedicated task

## Pros and Cons of the Options

### `jiff`

* Good, because DST arithmetic is correct by default — gaps and folds are resolved using explicit strategies; the default `compatible` strategy picks the post-transition time for gaps and the pre-transition time for folds, which matches the behavior users typically expect
* Good, because serialization follows RFC 9557, preserving the IANA timezone name alongside the UTC offset: `2024-07-15T10:00:00-04:00[America/New_York]`. Without the name, a stored `-04:00` could be any of several regions that happen to share that offset in summer but differ in winter.
* Good, because the TZDB is read from the system on Unix and bundled on Windows — no stale embedded snapshot that becomes incorrect when a government changes its DST rules
* Good, because multi-unit calendar spans (`5.years().months(2).days(1)`) work uniformly
* Good, because no known RUSTSEC advisories
* Good, because 0.2.0 is the only breaking release so far; most changes were compiler-caught renames
* Neutral, because pre-1.0; 1.0 originally targeted Summer 2025, now Spring/Summer 2026
* Bad, because `jiff-sqlx` (external) is immature: 0.1.1, ~30k downloads, Postgres and SQLite only
* Bad, because `Zoned` is not `Copy` (see Consequences above for full explanation)
* Bad, because ~70M downloads — significant but far behind `time` and `chrono` in ecosystem breadth

### `time`

* Good, because it is the ideal fit for UTC-only timestamp use cases — simple, focused, no unnecessary complexity
* Good, because sqlx integration is native (built into sqlx for Postgres, MySQL, and SQLite)
* Good, because actively maintained with monthly releases (maintainer: jhpratt)
* Good, because 550M+ downloads — well battle-tested
* Neutral, because RUSTSEC-2026-0009 (DoS via stack exhaustion in RFC 2822 parsing) is patched in 0.3.47 and not relevant to UTC audit timestamp use cases
* Bad, because there is no IANA timezone support — `OffsetDateTime` carries a fixed UTC offset only (e.g. `-05:00`), not the timezone name or its rules. This means it cannot answer questions like "what time is it in New York tomorrow after DST?", and any DST-safe arithmetic is impossible
* Bad, because any future need for timezone-aware operations would require migrating away from `time` entirely

### `chrono`

* Good, because dominant ecosystem integration: serde, sqlx, diesel, redis, and nearly every Rust database or serialization crate support it natively
* Good, because 470M+ downloads; deeply battle-tested in production
* Good, because still releasing quarterly (0.4.43 as of January 2026)
* Neutral, because IANA timezone support is available via the separate `chrono-tz` crate, which embeds a snapshot of the TZDB at compile time — the snapshot can become stale if not updated when governments change their DST rules
* Bad, because the primary maintainer (Dirkjan Ochtman) announced in January 2026 that he is winding down maintenance and recommending jiff as the replacement
* Bad, because the API design is dated: `NaiveDate`, `NaiveDateTime`, `DateTime<Tz>`, and `Date<Tz>` are four separate types with inconsistent method availability, making it easy to use the wrong one
* Bad, because `DateTime<Tz>` serialization only preserves the UTC offset, not the IANA timezone name — deserializing a stored value loses the timezone identity, so subsequent DST arithmetic may be wrong (see "lossless round-trips" in the Background section)
* Bad, because when a time falls in a DST gap (a time that does not exist), chrono returns `MappedLocalTime::None` with no recovery strategy, leaving the developer to handle an unresolvable error
* Bad, because RUSTSEC-2020-0159 (potential segfault via `localtime_r`) — patched, but reflects a structural design concern

## More Information

* [jiff documentation and comparison](https://docs.rs/jiff/latest/jiff/_documentation/comparison/index.html)
* [jiff 0.2.0 migration guide](https://github.com/BurntSushi/jiff/discussions/249)
* [jiff-sqlx on crates.io](https://crates.io/crates/jiff-sqlx)
* [RUSTSEC-2026-0009 (time DoS advisory)](https://rustsec.org/advisories/RUSTSEC-2026-0009.html)
* [Dirkjan Ochtman on chrono wind-down (January 2026)](https://dirkjan.ochtman.nl/writing/2026/01/09/reviewing-2025.html)
* [sqlx jiff support tracking issue](https://github.com/launchbadge/sqlx/issues/3487)
* A companion ADR covering DateTime conventions (UTC storage, audit field naming, serialization format, prohibition of local time in domain types) is tracked in TODO.md and should be authored before the domain grows to include timezone-aware operations.
* This decision should be revisited when jiff 1.0 ships (expected Spring/Summer 2026) to evaluate whether to lock the dependency to `>=1.0`.
