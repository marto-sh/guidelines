# Automate Conventions Skill

**ID**: `automate-conventions`
**Category**: Conventions
**Version**: 1.0.0

## Description

This skill helps automate Rust convention enforcement and provides practical guidance on using automated tools rather than manual checking.

## Capabilities

### Automated Convention Enforcement
- **Run clippy with project conventions** - Execute clippy with the configured rules
- **Explain clippy warnings** - Help understand and fix clippy issues
- **Suggest clippy configurations** - Recommend appropriate lint settings
- **Generate clippy.toml** - Create a sensible default configuration

### Practical Guidance
- **Explain Rust idioms** - Show stdlib patterns and conventions
- **Recommend proven crates** - Suggest thiserror, anyhow, tokio, etc.
- **Show automation setup** - Help configure CI/CD for convention enforcement
- **Provide minimal manual conventions** - Only what can't be automated

### Code Improvement
- **Suggest automated fixes** - Show how to apply clippy suggestions
- **Explain error handling patterns** - thiserror vs anyhow guidance
- **Recommend testing strategies** - Standard Rust testing approaches
- **Show module organization** - Practical, not dogmatic patterns

## Usage Examples

### Running Clippy with Project Conventions
```
User: "Run clippy on my project with our conventions"
Agent: "Running: cargo clippy --all-targets --all-features -- -D warnings"
[Executes clippy and shows results]
```

### Understanding Clippy Warnings
```
User: "What does 'clippy::module_name_repetitions' mean and how do I fix it?"
Agent: "This lint warns when a module name is repeated in its contents. For example:

❌ Bad: mod user { struct User { ... } }
✅ Good: mod user { struct Profile { ... } }

To fix: Rename the inner item to avoid repetition or use #[allow(clippy::module_name_repetitions)] if the repetition is intentional."
```

### Setting Up CI/CD
```
User: "How do I add clippy to my GitHub Actions workflow?"
Agent: "Add this step to your workflow:

```yaml
- name: Run clippy
  run: cargo clippy --all-targets --all-features -- -D warnings
```

This will fail the build if there are any clippy warnings, enforcing your conventions automatically."
```

### Error Handling Guidance
```
User: "Should I use thiserror or anyhow for my library?"
Agent: "For libraries, use thiserror:

```rust
#[derive(thiserror::Error, Debug)]
enum MyError {
    #[error("Invalid input: {0}")]
    InvalidInput(String),
    #[error("Network error")]
    Network(#[from] reqwest::Error),
}
```

This provides structured errors that library users can pattern match on. Use anyhow only for application code."
```

## Implementation

### Knowledge Sources
- **Primary**: `clippy.toml` and `CONVENTIONS.md` in the project
- **Secondary**: Rust standard library patterns
- **Tertiary**: Proven community crates (thiserror, anyhow, tokio, serde)

### Decision Making
1. **Prefer automation** - Always suggest automated solutions first
2. **Follow stdlib patterns** - When in doubt, show how stdlib does it
3. **Be pragmatic** - Don't enforce arbitrary rules
4. **Provide actionable advice** - Show exactly how to fix issues

### Response Format
```
Issue: [description]
Automated Fix: [clippy command or tool]
Manual Fix: [specific steps if needed]
Rationale: [why this matters]
Example: [good vs bad code]
```

## Skill Workflow

### Convention Query Handling
1. **Check if clippy can enforce it** - Prefer automated solutions
2. **Show the clippy command** - Provide exact invocation
3. **Explain the issue** - Help understand the problem
4. **Show how to fix** - Provide concrete examples
5. **Offer automation setup** - Help prevent future issues

### Code Review Assistance
1. **Suggest running clippy** - Always the first recommendation
2. **Explain clippy warnings** - Help interpret results
3. **Show automated fixes** - Use cargo fix where possible
4. **Provide manual guidance** - Only when automation isn't enough

## Practical Examples

### Setting Up Clippy
```
User: "How do I set up clippy for my project?"
Skill: "1. Install clippy: rustup component add clippy
        2. Copy clippy.toml to your project root
        3. Run: cargo clippy --all-targets --all-features -- -D warnings
        4. Add to CI/CD to enforce automatically"
```

### Fixing Common Issues
```
User: "How do I fix 'too many arguments' warning?"
Skill: "Options:
1. Use a builder pattern
2. Group related parameters into a struct
3. Add #[allow(clippy::too_many_arguments)] if justified

Example:
```rust
// Instead of:
fn create_user(name: String, email: String, age: u32, admin: bool) { ... }

// Use:
struct UserParams {
    name: String,
    email: String,
    age: u32,
    admin: bool,
}

fn create_user(params: UserParams) { ... }
```"
```

## Integration

This skill integrates with:
- **Clippy** - For automated convention enforcement
- **CI/CD systems** - For continuous enforcement
- **Rust analyzer** - For IDE integration
- **Cargo** - For build-time checking

## Limitations

- **Not a linter replacement** - Still relies on clippy for enforcement
- **Requires clippy setup** - Most effective when clippy is configured
- **Focuses on automation** - Manual conventions are minimal by design

## Future Enhancements

- **Automated clippy.toml generation** - Create sensible defaults
- **CI/CD configuration generation** - Help set up automated enforcement
- **Code refactoring assistance** - Help apply automated fixes
- **Performance profiling integration** - Help optimize when needed

## Quick Reference

### Essential Commands
```bash
# Run clippy
cargo clippy --all-targets --all-features -- -D warnings

# Run clippy and fix simple issues
cargo fix --clippy

# Check specific package
cargo clippy -p my_package

# Update clippy
rustup update
```

### When to Use This Skill
- **Setting up a new Rust project** - Configure automation early
- **Adding clippy to existing project** - Get started with enforcement
- **Understanding clippy warnings** - Learn how to fix issues
- **Configuring CI/CD** - Set up automated checking
- **Learning Rust idioms** - Understand stdlib patterns

## Maintenance

- **Keep clippy.toml updated** - Add new useful lints
- **Review allow/deny lists** - Adjust as needed
- **Update with new Rust versions** - Take advantage of new features
- **Keep manual conventions minimal** - Automate whenever possible