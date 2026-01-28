# 2. Use `thiserror` for Error Handling

## Status
Accepted

## Context
We need a robust and type-safe error handling strategy for our Rust project. The project involves writing libraries and applications where explicit error types are critical for maintainability, debugging, and user experience. We evaluated several error handling approaches, including the standard library, `thiserror`, `snafu`, `anyhow`, and `eyre`.

## Decision
We will use `thiserror` for defining and handling errors in our project.

## Rationale
1. **Type Safety**:
   - `thiserror` enforces explicit, custom error types, ensuring all errors are statically known and checked by the compiler. This aligns with our principle of maximizing type safety.
   - Example:
     ```rust
     #[derive(thiserror::Error, Debug)]
     enum MyError {
         #[error("IO error: {0}")]
         Io(#[from] std::io::Error),
         #[error("Parse error: {0}")]
         Parse(#[from] std::num::ParseIntError),
     }
     ```

2. **Avoiding Catch-All Errors**:
   - We don't want catch-all errors because code is cheap, and we would rather have the compiler help us by enforcing explicit error handling.
   - Catch-all errors (e.g., `anyhow::Error` or `eyre::Error`) hide the underlying error types, making it harder to reason about and handle errors precisely.
   - By using `thiserror`, we ensure that all errors are explicitly defined and handled, leveraging the compiler's type checking to catch potential issues early.

3. **Minimalism and Simplicity**:
   - `thiserror` is a minimalistic crate that focuses solely on defining custom error types. It does not introduce unnecessary features or complexity.
   - This simplicity makes it easier to reason about error handling and reduces the risk of misuse.

4. **Wider Adoption and Maturity**:
   - `thiserror` has a larger and growing community compared to alternatives like `snafu`. This indicates it is battle-tested and trusted by the Rust community.
   - It is actively maintained and has been stable since its release in 2019.

5. **Agent-Generated Code**:
   - Since agents are writing the code, we don't mind generating custom error types for all kinds of errors. Code generation is cheap and efficient, allowing us to focus on correctness and type safety without worrying about manual labor.
   - This enables us to define fine-grained, explicit error types for every possible error case, improving debugging and user experience.

6. **No Dynamic Dispatch**:
   - Unlike `anyhow` or `eyre`, `thiserror` does not use dynamic error types. All errors are statically typed, which is critical for performance and type safety.

7. **Improvement Over Standard Library**:
   - While the standard library provides basic error handling through `Result<T, E>` and custom error types, `thiserror` simplifies the process by automatically implementing `std::error::Error`, `Display`, and `Debug` for your error types.
   - This reduces boilerplate and ensures consistency across error types.

## Alternatives Considered
1. **Standard Library**:
   - Pros: No external dependencies, full control over error types.
   - Cons: Requires manual implementation of `std::error::Error`, `Display`, and `Debug` for custom error types. This can be tedious and error-prone.

2. **`snafu`**:
   - Pros: Provides automated context addition and backtraces, reducing boilerplate.
   - Cons: Less widely adopted than `thiserror`. While equally type-safe, it introduces more features, which could be unnecessary for our needs.

3. **`anyhow`/`eyre`**:
   - Pros: Ergonomic and easy to use, especially for applications.
   - Cons: Uses dynamic error types, which are less type-safe and not suitable for libraries or projects where explicit error types are required. These crates encourage catch-all errors, which we want to avoid.

## Consequences
- **Positive**:
  - Improved type safety and compile-time checks for errors.
  - Clear and explicit error types that are easy to understand and handle.
  - Better debugging and user experience due to well-defined error types.
  - Alignment with Rust best practices for error handling in libraries.
  - Reduced boilerplate compared to manual error handling with the standard library.
  - Ability to define fine-grained error types for all error cases, thanks to agent-generated code.
  - The compiler helps us catch potential issues early by enforcing explicit error handling.

- **Negative**:
  - Slightly more boilerplate compared to `snafu` or `anyhow`. However, this is mitigated by the use of agents to generate code.
  - No built-in support for backtraces or automated context addition. However, we can manually add context to errors if needed.
  - Additional dependency on the `thiserror` crate.

## Implementation
1. Add `thiserror` to the project dependencies:
   ```toml
   [dependencies]
   thiserror = "1.0"
   ```

2. Define custom error types for each module or component:
   ```rust
   #[derive(thiserror::Error, Debug)]
   pub enum MyError {
       #[error("IO error: {0}")]
       Io(#[from] std::io::Error),
       #[error("Parse error: {0}")]
       Parse(#[from] std::num::ParseIntError),
   }
   ```

3. Use the custom error types in functions:
   ```rust
   pub fn read_file(path: &str) -> Result<String, MyError> {
       std::fs::read_to_string(path).map_err(MyError::Io)
   }
   ```

4. Handle errors explicitly in user code:
   ```rust
   match read_file("config.json") {
       Ok(content) => println!("{}", content),
       Err(MyError::Io(e)) => eprintln!("IO error: {}", e),
       Err(MyError::Parse(e)) => eprintln!("Parse error: {}", e),
   }
   ```

## Future Considerations
- If we find that we need automated context addition or backtraces, we can reevaluate the use of `snafu`. However, given our current needs and the wider adoption of `thiserror`, this is unlikely.
- Monitor the Rust ecosystem for new error handling crates or features that might provide better type safety or ergonomics.

## References
- [`thiserror` documentation](https://docs.rs/thiserror)
- [`snafu` documentation](https://docs.rs/snafu)
- Rust Error Handling Guide: [https://doc.rust-lang.org/book/ch09-00-error-handling.html](https://doc.rust-lang.org/book/ch09-00-error-handling.html)
