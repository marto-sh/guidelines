# Manual Conventions

Only a few key decisions require manual documentation because they cannot be fully enforced by automated tools.

## Rationale

- **Tooling limitations**: Some conventions like error handling strategy and module organization are too complex or contextual for static analysis tools to enforce automatically
- **Design decisions**: These represent architectural choices that require human judgment and understanding of the specific domain
- **Consistency across projects**: Manual conventions ensure uniformity in areas where automated tools would be inconsistent or overly rigid
- **Developer communication**: Explicit documentation helps onboard new team members and maintain consistency across distributed teams

## Error Handling

- **Use `thiserror` for all error handling**. We use `thiserror` for defining explicit, custom error types in both libraries and applications. This ensures type safety and allows for precise error handling. See [ADR 0002: Use `thiserror` for Error Handling](../design/DECISIONS/0002-use-thiserror-for-error-handling.md) for the full rationale.
  ```rust
  // Define custom error types with thiserror
  #[derive(thiserror::Error, Debug)]
  pub enum MyError {
      #[error("IO error: {0}")]
      Io(#[from] std::io::Error),
      #[error("Parse error: {0}")]
      Parse(#[from] std::num::ParseIntError),
  }
  ```

## Module Organization

Follow a standard, predictable module structure. This makes it easier to locate code and understand the project's architecture.

```
my_crate/
├── src/
│   ├── lib.rs          # Main entry point, public API declaration
│   ├── user/           # Domain module
│   │   ├── mod.rs      # Module declaration, makes `user` a module
│   │   ├── auth.rs     # Specific functionality
│   │   └── profile.rs  # Specific functionality
│   └── tests/          # Integration tests (can also be in root `tests/`)
└── tests/              # Integration tests
```

## Async Patterns

- Suffix async function names with `_async` only when a synchronous version already exists. Otherwise, the `async` keyword is sufficient.

  ```rust
  // ✅ Good: Clear and idiomatic
  async fn fetch_data() -> Result<Data, FetchError>
  
  // ❌ Avoid: Redundant suffix
  async fn fetch_data_async() -> Result<Data, FetchError>
  ```