# Automated Conventions

The majority of our conventions are enforced automatically using deterministic tools. This provides immediate, consistent feedback and reduces the cognitive load on developers and agents.

This includes:

- **Naming conventions** (via static analysis tools)
- **Code quality** (complexity, style, patterns)
- **Error handling** (unwrap usage, error types)
- **Module organization** (imports, structure)

**Example with clippy:**

```bash
cargo clippy --all-targets --all-features -- -D warnings
```

## Rationale

- **Fast and deterministic feedback**: Automated tools provide immediate, consistent feedback that doesn't vary between runs or environments
- **Reduces agent/human workload**: Automated checks eliminate the need for manual or agent-based code reviews for basic conventions
- **Less context to load**: The conventions are embedded in the tooling rather than requiring documentation to be read and remembered
- **Scalable**: Works consistently across projects of any size without additional effort

## References

- [Clippy Documentation](https://doc.rust-lang.org/stable/clippy/)

