# Testing Strategy

Our testing strategy is designed to be comprehensive and easy to follow, balancing agent productivity with human-readable behavior validation.

## Rationale

- **Clear separation of concerns**: Unit tests focus on individual components while integration tests verify system behavior
- **Standard Rust conventions**: Follows idiomatic Rust testing patterns that developers and agents are already familiar with
- **Behavior-Driven Development**: Uses Cucumber for expressing core business requirements in human-readable format
- **Scalability**: Structure works well for projects of any size, from small libraries to large applications
- **Maintainability**: Clear organization makes it easy to find and update tests as the codebase evolves
- **Tooling compatibility**: Works seamlessly with Rust's built-in test runner and cargo test commands
- **Async support**: Handles async behavior effectively through Cucumber's tokio integration

> **Note**: This strategy is documented in [ADR 0003: Use Rust Standard Testing with Cucumber for BDD](../design/DECISIONS/0003-use-rust-standard-testing-with-cucumber-for-bdd.md)

- **Unit Tests**: These test a small, isolated piece of code (a single function or struct). They should be placed in the same file as the code they are testing, within a `#[cfg(test)]` module.

  ```rust
  // Unit tests - alongside the code
  #[cfg(test)]
  mod tests {
      use super::*;
      
      #[test]
      fn test_functionality() {
          // Test implementation
      }
  }
  ```

- **Integration Tests**: These test how multiple components work together. They should be placed in the `tests/` directory in the root of the crate. Each file in this directory is a separate integration test crate.

  ```rust
  // tests/my_feature_test.rs
  
  use my_crate::my_function;
  
  #[test]
  fn test_my_feature() {
      // Test implementation that calls into the library crate
  }
  ```

- **Behavior-Driven Development (BDD) Tests**: These test core business behaviors using the Cucumber framework. They consist of Gherkin feature files and Rust step definitions.

  **Feature Files** (in `features/` directory):
  ```gherkin
  # features/core_behavior.feature
  Feature: Core Business Behavior
    Scenario: Successful workflow execution
      Given the system is initialized
      When the workflow is executed
      Then the expected outcome is achieved
  ```

  **Step Definitions** (in `tests/cucumber.rs`):
  ```rust
  // tests/cucumber.rs
  use cucumber::{given, when, then, World};
  
  #[derive(Debug, Default, World)]
  struct TestWorld {
      // State for scenarios
  }
  
  #[given("the system is initialized")]
  async fn setup_system(world: &mut TestWorld) {
      // Setup code
  }
  
  #[when("the workflow is executed")]
  async fn execute_workflow(world: &mut TestWorld) {
      // Action code
  }
  
  #[then("the expected outcome is achieved")]
  async fn verify_outcome(world: &mut TestWorld) {
      // Assertion code
  }
  
  #[tokio::main]
  async fn main() {
      TestWorld::run("features").await;
  }
  ```

## Running Tests

**Run all tests (unit + integration + BDD):**
```bash
cargo test
```

**Run only unit and integration tests:**
```bash
cargo test --lib
cargo test --test integration
```

**Run only BDD tests:**
```bash
cargo test --test cucumber
```

**Run specific BDD scenarios:**
```bash
cargo test --test cucumber -- --tags @specific_tag
```

## Project Structure

```
my_project/
├── src/
│   └── lib.rs          # Main code with unit tests
├── tests/
│   ├── integration.rs  # Standard integration tests
│   └── cucumber.rs     # Cucumber step definitions
├── features/
│   └── *.feature       # Gherkin feature files
└── Cargo.toml          # Configuration
```