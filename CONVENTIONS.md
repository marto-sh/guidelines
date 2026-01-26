# Rust Conventions - Automation-First Approach

## Philosophy

**Automate what can be automated. Document only what must be manual.**

This repository takes a pragmatic, automation-first approach to Rust conventions:

1. **Use clippy for enforcement** - Automated tools catch issues immediately
2. **Keep manual conventions minimal** - Only document what clippy can't handle
3. **Follow Rust stdlib patterns** - Don't reinvent what's already proven
4. **Be pragmatic, not dogmatic** - Rules should serve the code, not vice versa
5. **Value predictability** - Two developers should solve the same problem the same way

## How This Works

### 1. Automated Conventions (clippy.toml)

The majority of conventions are enforced automatically via `clippy.toml`. This includes:

- **Naming conventions** (via clippy lints)
- **Code quality** (complexity, style, patterns)
- **Error handling** (unwrap usage, error types)
- **Module organization** (imports, structure)

**Run with:**
```bash
cargo clippy --all-targets --all-features -- -D warnings
```

### 2. Minimal Manual Conventions

Only a few key decisions require manual documentation:

#### Error Handling
```rust
// Libraries: Structured errors with thiserror
#[derive(thiserror::Error, Debug)]
enum MyError {
    #[error("Something went wrong: {0}")]
    Failure(String),
}

// Applications: Ergonomic errors with anyhow
use anyhow::{Context, Result};

fn process() -> Result<()> {
    do_something().context("Failed to do something")?;
    Ok(())
}
```

#### Module Organization
```
my_crate/
├── src/
│   ├── lib.rs          # Main entry point
│   ├── user/           # Domain module
│   │   ├── mod.rs      # Module declaration
│   │   ├── auth.rs      # Specific functionality
│   │   └── profile.rs   # Specific functionality
│   └── tests/          # Integration tests
└── tests/              # Also for integration tests
```

#### Async Patterns
```rust
// ✅ Good
async fn fetch_data() -> Result<Data, FetchError>

// ❌ Avoid
async fn fetch_data_async() -> Result<Data, FetchError>
```

### 3. Testing Strategy

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

// Integration tests - in tests/ directory
// tests/my_feature_test.rs
```

## Key Principles

### 1. Maximum Type Safety

**Strive for maximum type safety in all code:**

- **Use the type system aggressively** - Let the compiler catch errors at compile time
- **Avoid runtime errors** - Prefer compile-time validation through types
- **Use newtypes for domain concepts** - Create specific types for domain entities
- **Leverage Rust's type system** - Enums, structs, generics, and traits for safety
- **Avoid stringly-typed code** - Replace strings with proper enum types
- **Use phantom types** - For compile-time guarantees about state and behavior

### 2. Predictability and Consistency

**Make the codebase predictable and consistent:**

- **Consistent naming**: Use predictable patterns for functions, variables, and types
- **Standardized organization**: Follow the same module structure everywhere
- **Uniform problem solving**: Two developers should implement the same feature identically
- **Clear conventions**: Document patterns so everyone follows them

**Why predictability matters:**
- **Reduces cognitive load**: Developers don't need to "figure out" how things work
- **Improves collaboration**: Team members can predict each other's code
- **Eases maintenance**: Consistent patterns make the codebase easier to navigate
- **Accelerates onboarding**: New team members learn the patterns once and apply them everywhere

### 2. Follow Rust Idioms

- **Use stdlib patterns** - When in doubt, check how stdlib does it
- **Prefer proven crates** - thiserror, anyhow, tokio, serde, etc.
- **Don't reinvent** - Use existing conventions rather than creating new ones

### 2. Automate Enforcement

- **Clippy catches most issues** - Run it in CI
- **Compiler catches the rest** - Use strict compiler settings
- **Manual review for exceptions** - Only when automation can't decide
- **Type safety first** - Let the compiler be your first line of defense

### 3. Be Pragmatic

- **Complexity is sometimes necessary** - Don't enforce arbitrary limits
- **Performance matters** - Optimize when profiling shows it's needed
- **Developer experience matters** - Make the easy way the right way
- **Type safety over convenience** - When in doubt, choose safety
- **Predictability over cleverness** - Choose clear, consistent patterns over clever solutions

### 4. Predictability and Consistency

**Predictability is paramount:**

- **File location**: Follow consistent module organization patterns
- **Naming conventions**: Use predictable names for functions, variables, and traits
- **Code structure**: Organize code in a way that's intuitive to navigate
- **Problem solving**: Two developers should implement the same feature similarly

**Benefits of predictability:**
- **Faster onboarding**: New team members can find things easily
- **Easier maintenance**: Consistent patterns reduce cognitive load
- **Better collaboration**: Team members can predict each other's code
- **Reduced bugs**: Consistent patterns mean fewer surprises

### 5. Strategic Artifact Organization

**Location of key design documents:**
```
project_root/
├── docs/
│   ├── design/              # Strategic design artifacts
│   │   ├── DOMAIN_VISION.md  # Domain vision statement
│   │   ├── UBIQUITOUS_LANGUAGE.md  # Ubiquitous language glossary
│   │   ├── CONTEXT_MAP.md     # Context mapping and boundaries
│   │   ├── ARCHITECTURE.md     # High-level architecture decisions
│   │   └── DECISIONS/         # Architecture decision records (ADRs)
│   │       ├── 0001-use-rust.md
│   │       └── 0002-error-handling-strategy.md
│   └── technical/           # Technical documentation
│       ├── API.md           # API documentation
│       ├── DEPLOYMENT.md    # Deployment guide
│       └── PERFORMANCE.md   # Performance characteristics
└── DESIGN_NOTES.md          # Quick reference for developers (optional)
```

**Purpose of each artifact:**
- `DOMAIN_VISION.md` - High-level domain vision and strategic goals
- `UBIQUITOUS_LANGUAGE.md` - Glossary of domain terms with precise definitions
- `CONTEXT_MAP.md` - Visual context map showing bounded contexts and relationships
- `ARCHITECTURE.md` - High-level architecture overview and key decisions
- `DECISIONS/` - Architecture Decision Records (ADRs) for major technical choices

### 6. Commit Message Conventions

**Use Conventional Commits format:**
```
<type>(<scope>): <description>
[optional body]
[optional footer(s)]
```

**Common types:**
- `feat`: New feature
- `fix`: Bug fix
- `docs`: Documentation changes
- `style`: Code style changes (formatting, missing semicolons)
- `refactor`: Code refactoring (no functional changes)
- `perf`: Performance improvements
- `test`: Adding or modifying tests
- `build`: Build system or dependency changes
- `ci`: CI configuration changes
- `chore`: Other changes that don't modify src or test files
- `revert`: Reverts a previous commit

**Examples:**
```bash
# Feature with scope
git commit -m "feat(auth): add JWT authentication support"

# Bug fix with body
git commit -m "fix(parser): handle empty input gracefully

Previously would panic on empty strings. Now returns Ok(None) for empty input."

# Breaking change with footer
git commit -m "feat(api): remove deprecated v1 endpoints

BREAKING CHANGE: v1 API endpoints have been removed. Migrate to v2 endpoints."

# Documentation
git commit -m "docs: add architecture decision record for error handling"

# Refactoring
git commit -m "refactor(user): extract authentication logic into separate module"
```

**Benefits:**
- **Consistent commit history** - Easy to read and understand
- **Automated changelog generation** - Tools can generate changelogs from commits
- **Better version management** - Clear indication of breaking changes
- **Improved collaboration** - Team members understand changes quickly

**Tooling integration:**
```bash
# Install commitlint for local validation
npm install --save-dev @commitlint/{cli,config-conventional}
echo "module.exports = {extends: ['@commitlint/config-conventional']}" > commitlint.config.js

# Add husky hook for pre-commit validation
npx husky-add .husky/commit-msg 'npx --no -- commitlint --edit $1'
```

## Getting Started

### 1. Automation Setup

1. **Add clippy to your project:**
   ```bash
   rustup component add clippy
   ```

2. **Copy clippy.toml to your project root**

3. **Add to your CI/CD pipeline:**
   ```yaml
   - name: Run clippy
     run: cargo clippy --all-targets --all-features -- -D warnings
   ```

4. **Run locally:**
   ```bash
   cargo clippy
   ```

### 2. Strategic Artifacts Setup

1. **Create design documentation structure:**
   ```bash
   mkdir -p docs/design/DECISIONS
   ```

2. **Copy template files:**
   ```bash
   cp path/to/templates/* docs/design/
   ```

3. **Initialize first ADR:**
   ```bash
   cp docs/design/DECISIONS/0000-TEMPLATE.md docs/design/DECISIONS/0001-first-decision.md
   ```

### 3. Commit Message Setup

1. **Install commitlint and husky:**
   ```bash
   npm install --save-dev @commitlint/{cli,config-conventional} husky
   ```

2. **Configure commitlint:**
   ```bash
   echo "module.exports = {extends: ['@commitlint/config-conventional']}" > commitlint.config.js
   ```

3. **Set up pre-commit hook:**
   ```bash
   npx husky-add .husky/commit-msg 'npx --no -- commitlint --edit $1'
   ```

## When to Deviation

Deviate from these conventions when:

1. **Clippy gives a false positive** - Use `#[allow(clippy::lint_name)]`
2. **Performance requires it** - Profile first, then optimize
3. **API compatibility demands it** - Maintain existing contracts
4. **The alternative is worse** - Use judgment
5. **Type safety would be compromised** - Never sacrifice safety for convenience
6. **Predictability would be improved** - When a better pattern emerges

## Maintenance

- **Update clippy.toml periodically** - Keep up with new lints
- **Review allow/deny lists** - Adjust as the codebase evolves
- **Keep manual conventions minimal** - Automate whenever possible
- **Enforce predictability** - Ensure all team members follow the same patterns

## Complete Example: Putting It All Together

### Project Structure
```
my_project/
├── .husky/
│   └── commit-msg          # Commit message validation
├── docs/
│   ├── design/
│   │   ├── DOMAIN_VISION.md # Domain vision
│   │   ├── UBIQUITOUS_LANGUAGE.md # Ubiquitous language
│   │   ├── CONTEXT_MAP.md   # Context mapping
│   │   ├── ARCHITECTURE.md   # Architecture overview
│   │   └── DECISIONS/
│   │       ├── 0000-TEMPLATE.md
│   │       └── 0001-use-conventional-commits.md
│   └── technical/
│       ├── API.md
│       └── DEPLOYMENT.md
├── src/
│   ├── lib.rs
│   ├── user/
│   │   ├── mod.rs
│   │   ├── auth.rs
│   │   └── profile.rs
│   └── tests/
├── clippy.toml             # Automated conventions
├── commitlint.config.js    # Commit message validation
├── Cargo.toml
└── README.md
```

### Development Workflow

1. **Start new feature:**
   ```bash
   # Create branch with conventional commit style
   git checkout -b feat/user-authentication
   ```

2. **Implement feature:**
   ```rust
   // src/user/auth.rs
   pub struct UserAuthenticator {
       // implementation
   }
   
   impl UserAuthenticator {
       pub fn new() -> Self { /* ... */ }
       pub fn authenticate(&self, credentials: Credentials) -> Result<Session, AuthError> { /* ... */ }
   }
   ```

3. **Run automated checks:**
   ```bash
   cargo clippy --all-targets -- -D warnings
   cargo test
   ```

4. **Commit with conventional format:**
   ```bash
   git add src/user/auth.rs
   git commit -m "feat(auth): implement JWT authentication"
   # commitlint validates the message format
   ```

5. **Create ADR for major decisions:**
   ```bash
   cp docs/design/DECISIONS/0000-TEMPLATE.md docs/design/DECISIONS/0002-use-jwt.md
   # Edit the new ADR to document the JWT decision
   ```

6. **Push and create PR:**
   ```bash
   git push origin feat/user-authentication
   # CI runs clippy and other checks automatically
   ```

### Commit Message Examples

```bash
# Feature addition
feat(auth): add OAuth2 support for Google and GitHub

# Bug fix
fix(parser): handle malformed JSON in user preferences

# Documentation
 docs: update ubiquitous language with new authentication terms

# Refactoring
efactor(user): extract session management into separate module

# Breaking change
feat(api): remove deprecated v1 authentication endpoints

BREAKING CHANGE: v1 auth endpoints removed. Migrate to v2 endpoints.

# Chore
chore: update clippy to latest version
```

### CI/CD Pipeline Example

```yaml
name: CI
on: [push, pull_request]

jobs:
  test:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - uses: actions-rs/toolchain@v1
        with:
          toolchain: stable
          components: clippy
      - run: cargo clippy --all-targets --all-features -- -D warnings
      - run: cargo test

  commitlint:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - uses: actions/setup-node@v3
      - run: npm install
      - run: npx commitlint --from HEAD~1 --to HEAD --verbose
```

## See Also

- [Rust API Guidelines](https://rust-lang.github.io/api-guidelines/)
- [Clippy Documentation](https://doc.rust-lang.org/stable/clippy/)
- [Rust by Example](https://doc.rust-lang.org/stable/rust-by-example/)
- [Conventional Commits](https://www.conventionalcommits.org/)
- [Architecture Decision Records](https://adr.github.io/)

**Remember:** The goal is working, maintainable, type-safe code - not perfect adherence to rules.