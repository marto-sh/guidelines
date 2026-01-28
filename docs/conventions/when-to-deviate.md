# When to Deviate

Deviate from these conventions only when you have a compelling, well-justified reason. The goal is working, maintainable, and predictable code, not blind adherence to rules.

## Rationale

- **Pragmatic approach**: Recognizes that real-world constraints sometimes require flexibility
- **Documentation requirement**: Ensures deviations are intentional and well-documented rather than accidental
- **Performance optimization**: Allows for necessary optimizations when data-driven evidence supports them
- **API stability**: Maintains compatibility with existing interfaces and contracts
- **Code quality**: Prioritizes readability and maintainability over rigid rule-following
- **Tooling limitations**: Acknowledges that automated tools aren't perfect and may need overrides

Always document the reason for the deviation, either in a code comment or, for larger decisions, in an Architecture Decision Record (ADR).

Some common reasons for deviation include:

1.  **Performance**: When profiling shows that a non-standard approach provides a significant performance gain.
2.  **API Compatibility**: To maintain compatibility with an existing public API or a third-party service.
3.  **False Positives**: When an automated tool (like `clippy`) gives a false positive. In this case, use an `#[allow(...)]` attribute with a comment explaining why.
4.  **Clarity**: If following a convention would make the code *less* clear or more complex in a specific context.