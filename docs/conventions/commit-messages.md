# Commit Message Conventions

We use the [Conventional Commits](https://www.conventionalcommits.org/) format. This creates a consistent commit history that is easy to read and can be used to automate changelog generation and versioning.

## Rationale

- **Consistent history**: Creates a uniform, readable commit history that's easy to navigate and understand
- **Automation support**: Enables automatic changelog generation and semantic versioning
- **Tooling integration**: Works with various developer tools and CI/CD systems that understand conventional commits
- **Team communication**: Provides clear, structured information about what changed and why
- **Project maintenance**: Makes it easier to track features, fixes, and breaking changes over time
- **Standard adoption**: Uses a widely-adopted industry standard that developers are likely already familiar with

## Format

```
<type>(<scope>): <description>

[optional body]

[optional footer(s)]
```

## Common Types

- `feat`: A new feature
- `fix`: A bug fix
- `docs`: Documentation changes
- `style`: Code style changes (formatting, etc.)
- `refactor`: Code refactoring without changing functionality
- `perf`: A performance improvement
- `test`: Adding or modifying tests
- `build`: Changes to the build system or dependencies
- `ci`: Changes to CI configuration
- `chore`: Other changes that don't modify source or test files
- `revert`: Reverts a previous commit

## Examples

```bash
# Feature with a scope
git commit -m "feat(auth): add JWT authentication support"

# Bug fix with a body explaining the fix
git commit -m "fix(parser): handle empty input gracefully

Previously, the parser would panic on empty strings. It now returns Ok(None)."

# Breaking change indicated in the footer
git commit -m "feat(api): remove deprecated v1 endpoints

BREAKING CHANGE: The v1 API endpoints have been removed. Please migrate to the v2 endpoints."
```

## Tooling

We use `commitlint-rs` to enforce this format locally before a commit is created.

```bash
# Install commitlint-rs for local validation
cargo install commitlint-rs

# Configure it
cat > commitlint.config.json << EOF
{
  "extends": ["@commitlint/config-conventional"]
}
EOF

# Add a git hook for pre-commit validation
cat > .git/hooks/commit-msg << EOF
#!/bin/sh
commitlint-rs --edit $1
EOF
chmod +x .git/hooks/commit-msg
```

## References
- [Conventional Commits](https://www.conventionalcommits.org/)