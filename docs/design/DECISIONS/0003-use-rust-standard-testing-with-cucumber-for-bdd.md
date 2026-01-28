# Architecture Decision Record (ADR) 0003: Use Rust Standard Testing with Cucumber for BDD

## Status
Accepted

## Context
We need a comprehensive testing strategy for our Rust projects that balances agent productivity with human-readable behavior validation. The testing approach must:

* Support both unit testing (for individual components) and integration testing (for system behavior)
* Enable behavior-driven development (BDD) for expressing core business requirements
* Handle async behavior effectively
* Work seamlessly with Rust's built-in test runner
* Provide dedicated feature files for documentation and agent discoverability
* Scale well across multiple projects with reusable setup

## Decision
We will use a **hybrid testing approach**:

1. **Standard Rust Testing Framework** for unit and integration tests (agent productivity)
2. **Cucumber Framework** for behavior-driven development (human validation)

### Standard Rust Testing Framework
For unit and integration tests, we will use Rust's built-in testing framework:

- **Unit Tests**: Placed in the same file as the code being tested within `#[cfg(test)]` modules
- **Integration Tests**: Placed in the `tests/` directory as separate test crates

### Cucumber Framework for BDD
For behavior-driven development, we will use the `cucumber` crate to:
- Write executable specifications in Gherkin syntax (`.feature` files)
- Connect Gherkin scenarios to Rust step definitions with async support
- Enable collaboration between agents and human stakeholders
- Provide living documentation for core business behaviors

## Rationale

### Why This Hybrid Approach
1. **Agent Productivity**: Standard Rust tests provide fast feedback loops for agent-generated code
2. **Human Validation**: Cucumber provides business-readable specifications for core behaviors
3. **Async Support**: Cucumber's tokio integration handles async behavior effectively
4. **Documentation**: Dedicated feature files serve as living documentation
5. **Reusable Setup**: One-time cucumber configuration can be reused across projects

### Why Standard Rust Testing Framework
1. **Idiomatic and Familiar**: Uses patterns that Rust developers and agents already know
2. **No Additional Dependencies**: Built into the language and toolchain
3. **Excellent Tooling Support**: Works seamlessly with `cargo test` and IDE integrations
4. **Performance**: Native Rust execution without additional runtime overhead
5. **Comprehensive Coverage**: Can test everything from units to full system integration

### Why Cucumber for BDD
1. **Business-Readable Specifications**: Gherkin syntax allows clear expression of business requirements
2. **Living Documentation**: Feature files serve as both tests and up-to-date documentation
3. **Async Support**: Built-in tokio integration for testing async behavior
4. **Agent Compatibility**: Agents can easily discover and generate step definitions from feature files
5. **Behavior-First Approach**: Encourages thinking about system behavior before implementation
6. **Rust Ecosystem Support**: Well-maintained crate with good community adoption

### Why Not Other Approaches
1. **Standard Rust Only**: Would lack the business-readable specification format and living documentation benefits
2. **Alternative BDD Crates**: Other options either lack async support or have smaller ecosystems
3. **Custom Test Framework**: Would require significant maintenance effort and lack community support

## Implementation

### Project Structure
```
my_project/
├── src/
│   └── lib.rs          # Main code with unit tests
├── tests/
│   ├── integration.rs  # Standard integration tests
│   └── cucumber.rs     # Cucumber step definitions
├── features/
│   └── core_behavior.feature  # Gherkin feature files
└── Cargo.toml          # Configuration
```

### Standard Rust Testing Setup

**Unit Tests** (in source files):
```rust
// src/my_module.rs
#[cfg(test)]
mod tests {
    use super::*;
    
    #[test]
    fn test_agent_operation() {
        // Fast feedback for agent-generated code
        let result = agent_operation();
        assert_eq!(result, expected_value());
    }
}
```

**Integration Tests** (in tests/ directory):
```rust
// tests/integration.rs
use my_crate::*;

#[test]
fn test_system_integration() {
    // Test how multiple components work together
    let system = setup_system();
    let result = system.execute_workflow();
    assert!(result.is_ok());
}
```

### Cucumber BDD Setup

**1. Add dependencies to `Cargo.toml`:**
```toml
[dev-dependencies]
cucumber = "0.22"
tokio = { version = "1", features = ["macros", "rt-multi-thread"] }
```

**2. Configure the cucumber test runner in `Cargo.toml`:**
```toml
[[test]]
name = "cucumber"
harness = false  # We provide our own test harness
```

**3. Create feature files (e.g., `features/core_behavior.feature`):**
```gherkin
# features/core_behavior.feature
Feature: Core Application Behavior
  As a system user
  I want the core workflow to function correctly
  So that the business requirements are met

  Scenario: Successful core workflow execution
    Given the system is properly initialized
    When the agent executes the core workflow
    Then the expected business outcome should be achieved
    And all side effects should be persisted

  Scenario: Error handling in core workflow
    Given the system is initialized with invalid data
    When the agent attempts to execute the workflow
    Then an appropriate error should be returned
    And the system state should remain consistent
```

**4. Implement step definitions (e.g., `tests/cucumber.rs`):**
```rust
// tests/cucumber.rs
use cucumber::{given, when, then, World};
use my_crate::*;

#[derive(Debug, Default, World)]
struct CoreBehaviorWorld {
    system: Option<System>,
    result: Option<Result<BusinessOutcome, WorkflowError>>,
}

#[given("the system is properly initialized")]
async fn setup_valid_system(world: &mut CoreBehaviorWorld) {
    world.system = Some(setup_valid_system_for_testing());
}

#[given("the system is initialized with invalid data")]
async fn setup_invalid_system(world: &mut CoreBehaviorWorld) {
    world.system = Some(setup_invalid_system_for_testing());
}

#[when("the agent executes the core workflow")]
async fn execute_workflow(world: &mut CoreBehaviorWorld) {
    let system = world.system.as_ref().expect("System not initialized");
    world.result = Some(system.execute_core_workflow().await);
}

#[when("the agent attempts to execute the workflow")]
async fn attempt_execute_workflow(world: &mut CoreBehaviorWorld) {
    // Same as above, but we expect it to fail
    execute_workflow(world).await;
}

#[then("the expected business outcome should be achieved")]
async fn verify_successful_outcome(world: &mut CoreBehaviorWorld) {
    let result = world.result.as_ref().expect("No result");
    assert!(result.is_ok());
    let outcome = result.as_ref().unwrap();
    assert_eq!(outcome, &expected_business_outcome());
}

#[then("an appropriate error should be returned")]
async fn verify_error_returned(world: &mut CoreBehaviorWorld) {
    let result = world.result.as_ref().expect("No result");
    assert!(result.is_err());
    // Could add specific error type checking here
}

#[then("all side effects should be persisted")]
async fn verify_side_effects(world: &mut CoreBehaviorWorld) {
    // Verify database changes, file operations, etc.
    verify_persistence().await;
}

#[then("the system state should remain consistent")]
async fn verify_system_consistency(world: &mut CoreBehaviorWorld) {
    let system = world.system.as_ref().expect("System not initialized");
    assert!(system.is_consistent());
}

#[tokio::main]
async fn main() {
    // Run all feature files in the features directory
    CoreBehaviorWorld::run("features").await;
}
```

### Running Tests

**Run all tests (unit + integration + cucumber):**
```bash
cargo test
```

**Run only standard tests:**
```bash
cargo test --lib
cargo test --test integration
```

**Run only cucumber tests:**
```bash
cargo test --test cucumber
```

**Run specific cucumber scenario:**
```bash
cargo test --test cucumber -- --tags @specific_tag
```

## Alternatives Considered

### 1. Standard Rust Testing Only
* **Pros**: Simpler setup, fewer dependencies, pure Rust ecosystem
* **Cons**: Lacks business-readable specification format, harder for human stakeholders to validate core behaviors, no living documentation aspect

### 2. Alternative BDD Frameworks (e.g., rstest-bdd)
* **Pros**: Lighter weight, no separate feature files
* **Cons**: No async support, less business-readable, smaller ecosystem, harder for agents to discover test scenarios

### 3. Custom Test Framework
* **Pros**: Could be tailored exactly to our needs
* **Cons**: Significant development and maintenance overhead, lack of community support and tooling integration

### 4. Property-Based Testing Frameworks (e.g., proptest)
* **Pros**: Excellent for testing edge cases and generating test data
* **Cons**: Doesn't replace unit/integration testing, more complex to set up, not suitable for BDD scenarios

## Consequences

### Positive
* **Agent Productivity**: Standard Rust tests provide fast feedback loops for agent-generated code
* **Human Validation**: Cucumber provides clear, business-readable specifications for core behaviors
* **Comprehensive Coverage**: Both implementation details and business requirements are thoroughly tested
* **Living Documentation**: Feature files serve as both tests and up-to-date documentation
* **Async Support**: Cucumber's tokio integration handles async behavior effectively
* **Reusable Setup**: One-time configuration can be reused across multiple projects
* **Clear Separation**: Different testing approaches for different concerns
* **Tooling Compatibility**: Works with existing Rust toolchain and IDE support

### Negative
* **Additional Dependencies**: Requires the `cucumber` and `tokio` crates for BDD testing
* **Learning Curve**: Team members need to learn both standard Rust testing and cucumber patterns
* **Setup Complexity**: Initial cucumber setup is more complex than standard Rust testing
* **Test Execution Time**: Comprehensive test suites may take longer to run
* **Maintenance Overhead**: Need to maintain both test approaches and ensure they stay in sync

### Architectural Implications
* Encourages outside-in development approach (BDD driving implementation)
* Promotes clear separation between business behavior and implementation details
* May influence how async code is structured to be testable

### Development Implications
* Developers need to learn both standard Rust testing and cucumber BDD patterns
* Feature files need to be maintained alongside code
* CI/CD pipelines need to run both standard tests and cucumber tests
* Agents need to be capable of generating both test types

### Operational Implications
* Test execution time may increase with comprehensive test suites
* Need to ensure cucumber tests are included in CI/CD pipelines
* Feature files become part of the documentation that needs to be kept up-to-date

## Future Considerations

* **Test Organization**: As the project grows, consider organizing feature files by domain or module
* **Performance Optimization**: For large test suites, explore parallel test execution
* **Advanced Cucumber Features**: Consider using tags, hooks, and background steps for more complex scenarios
* **Test Coverage**: Integrate test coverage tools to ensure both code and behavior are adequately covered
* **Agent Integration**: Enhance agent capabilities to automatically generate cucumber step definitions from feature files
* **Documentation Generation**: Explore tools to generate documentation from feature files
* **Cross-Project Reuse**: Develop templates and patterns for cucumber setup that can be reused across projects

## Best Practices

### For Agents
1. **Unit Tests**: Generate comprehensive unit tests for all agent-generated code
2. **Integration Tests**: Create integration tests for component interactions
3. **Step Definitions**: Generate cucumber step definitions from feature files
4. **Test Naming**: Use clear, descriptive names that indicate what's being tested

### For Human Reviewers
1. **Feature Files**: Focus on writing clear, business-oriented Gherkin scenarios
2. **Core Behaviors**: Use cucumber for validating critical business workflows
3. **Review Process**: Use feature files as living documentation during code reviews
4. **Scenario Design**: Write scenarios that cover happy paths, edge cases, and error conditions

### For Both
1. **Test Maintenance**: Keep tests in sync with code changes
2. **Performance**: Be mindful of test execution time
3. **Coverage**: Ensure both code paths and business behaviors are covered
4. **Documentation**: Use tests as documentation of expected behavior

## References

* [Rust Testing Documentation](https://doc.rust-lang.org/book/ch11-00-testing.html)
* [Cucumber Rust Documentation](https://docs.rs/cucumber)
* [Tokio Documentation](https://docs.rs/tokio)
* [Gherkin Reference](https://cucumber.io/docs/gherkin/)
* [Cucumber Rust GitHub](https://github.com/cucumber-rs/cucumber)

---