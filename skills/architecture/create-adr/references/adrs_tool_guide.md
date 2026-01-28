# The adrs Tool Guide

This guide covers the `adrs` CLI tool used for creating and managing Architecture Decision Records.

> **💡 MCP Integration Available:** The `adrs` tool includes built-in support for the Model Context Protocol (MCP), enabling direct integration with MCP-compatible AI clients. See the [MCP Server Integration](#mcp-server-integration) section for setup instructions.

## What is adrs?

**adrs** is a Rust-based command-line utility that provides modern, feature-rich functionality for ADR management. It's compatible with traditional adr-tools while adding powerful new capabilities.

**GitHub:** https://github.com/joshrotenberg/adrs

## Installation

Choose the method that works best for your environment:

### Homebrew (macOS/Linux)
```bash
brew install joshrotenberg/brew/adrs
```

### Cargo (Rust)
```bash
cargo install adrs
```

### Docker
```bash
docker run --rm -v $(pwd):/work ghcr.io/joshrotenberg/adrs
```

### Binary Releases
Download pre-built binaries for macOS, Linux, and Windows from:
https://github.com/joshrotenberg/adrs/releases

## Quick Start

### 1. Initialize Repository
```bash
adrs init
```

This creates:
- `doc/adr/` directory (configurable)
- `.adr-dir` file pointing to the ADR directory
- First ADR template (optional)

### 2. Create Your First ADR
```bash
adrs new "Record Architecture Decisions"
```

This creates a numbered ADR file (e.g., `0001-record-architecture-decisions.md`) with a pre-populated template.

### 3. List ADRs
```bash
adrs list
```

Shows all ADRs with their numbers, titles, and status.

### 4. Update Status
```bash
adrs status 1 accepted
```

Changes the status of ADR 1 to "accepted".

## Core Commands

### Creation Commands

**Basic ADR Creation:**
```bash
adrs new "Use PostgreSQL for Primary Database"
```

**MADR Format:**
```bash
adrs new --format madr "Use PostgreSQL"
```

**Minimal Template:**
```bash
adrs new --variant minimal "Quick Decision"
```

**Supersede Existing ADR:**
```bash
adrs new --supersedes 5 "Use MySQL Instead"
```

### Management Commands

**List All ADRs:**
```bash
adrs list
```

**Filter by Status:**
```bash
adrs list --status accepted
adrs list --status proposed
```

**Search ADR Content:**
```bash
adrs search "database"
adrs search "postgresql"
```

**Update ADR Status:**
```bash
adrs status <NUMBER> <STATUS>

# Valid statuses: proposed, accepted, rejected, deprecated, superseded
adrs status 3 accepted
adrs status 5 deprecated
```

**Link ADRs:**
```bash
adrs link <SOURCE> <RELATIONSHIP> <TARGET>

# Examples:
adrs link 3 Amends 1        # ADR 3 amends ADR 1
adrs link 4 Supersedes 2    # ADR 4 supersedes ADR 2
adrs link 5 Relates 3       # ADR 5 relates to ADR 3
adrs link 6 Extends 4       # ADR 6 extends ADR 4
```

### Documentation Commands

**Generate Table of Contents:**
```bash
adrs generate toc > doc/adr/README.md
```

**Generate Dependency Graph:**
```bash
adrs generate graph | dot -Tsvg > doc/adr/graph.svg
```

Requires Graphviz to be installed (`brew install graphviz` or `apt-get install graphviz`).

**Generate mdbook:**
```bash
adrs generate book
cd book && mdbook serve
```

Requires mdbook to be installed (`cargo install mdbook`).

### Maintenance Commands

**Health Check:**
```bash
adrs doctor
```

Checks for:
- Missing ADR files
- Broken links
- Invalid status transitions
- Other repository issues

**Show Configuration:**
```bash
adrs config
```

Displays current configuration including ADR directory location and format preferences.

## Advanced Features

### NextGen Mode

Enable advanced features with YAML frontmatter and tags:

```bash
adrs --ng new --tags security,api "Use JWT for Authentication"
```

**Benefits:**
- Tag-based categorization
- Structured metadata
- Enhanced searchability

**Filter by Tags:**
```bash
adrs --ng list --tag security
```

### Format Support

**Nygard Format (Default):**
The classic ADR format from Michael Nygard's 2011 article.
- Simple, proven structure
- Context, Decision, Consequences
- Status tracking

**MADR 4.0.0:**
Markdown Architecture Decision Records format.
- More comprehensive template
- Decision drivers section
- Detailed pros/cons analysis

Choose format when creating:
```bash
adrs new --format madr "Title"
```

### Template Variants

**Full (Default):**
- Complete template with all sections
- Best for comprehensive decisions
- Recommended for significant architectural choices

**Minimal:**
- Streamlined template
- Fewer sections
- Good for straightforward decisions

**Bare:**
- Skeleton structure only
- Maximum flexibility
- For custom workflows

Usage:
```bash
adrs new --variant minimal "Title"
adrs new --variant bare "Title"
```

### Import/Export

**Export to JSON-ADR:**
```bash
adrs export json > decisions.json
```

**Import from JSON:**
```bash
adrs import decisions.json
```

**Renumber on Import:**
```bash
adrs import decisions.json --renumber
```

Useful for:
- Moving ADRs between repositories
- Backup and restore
- Federation across multiple projects

## Workflow Examples

### Standard Workflow

1. **Initialize** (once per project):
   ```bash
   adrs init
   ```

2. **Create ADR** (mark as proposed):
   ```bash
   adrs new "Use GraphQL for API"
   # Edit the created file
   ```

3. **Socialize** (share with team, gather feedback):
   - Commit to version control
   - Create PR for review
   - Gather feedback

4. **Accept** (after approval):
   ```bash
   adrs status 3 accepted
   ```

5. **Update Index** (after any changes):
   ```bash
   adrs generate toc > doc/adr/README.md
   ```

### Superseding Workflow

When a decision needs to change:

1. **Create new ADR** that supersedes the old:
   ```bash
   adrs new --supersedes 3 "Use REST instead of GraphQL"
   # Explain why the decision changed
   ```

2. The tool automatically:
   - Updates the old ADR's status to "superseded"
   - Creates bidirectional links
   - Maintains decision history

3. **Verify** the link:
   ```bash
   adrs list
   # Shows ADR 3 as superseded
   ```

### Search and Discovery Workflow

When joining a project or investigating a decision:

1. **List all ADRs**:
   ```bash
   adrs list
   ```

2. **Search for specific topic**:
   ```bash
   adrs search "database"
   ```

3. **Filter by status**:
   ```bash
   adrs list --status accepted
   ```

4. **View dependencies**:
   ```bash
   adrs generate graph | dot -Tpng > graph.png
   open graph.png
   ```

## Configuration

### ADR Directory Location

Default: `doc/adr/`

The `.adr-dir` file specifies the location. To use a different directory:

```bash
# Manual approach
mkdir -p docs/decisions
echo "docs/decisions" > .adr-dir
adrs list  # Verify new location
```

### Default Format

To use MADR by default, you can create an alias:

```bash
# In ~/.bashrc or ~/.zshrc
alias adrs-madr='adrs new --format madr'

# Usage
adrs-madr "Use PostgreSQL"
```

## Troubleshooting

### ADRs Not Found

**Problem:** `adrs list` shows no ADRs

**Solutions:**
1. Check if repository is initialized: `ls -la | grep .adr-dir`
2. Verify ADR directory exists: `cat .adr-dir && ls $(cat .adr-dir)`
3. Run health check: `adrs doctor`

### Numbering Issues

**Problem:** ADR numbers are not sequential

**Solution:**
- Use `adrs import` with `--renumber` flag
- Or manually rename files (not recommended)

### Broken Links

**Problem:** `adrs doctor` reports broken links

**Solutions:**
1. Check if target ADR exists
2. Verify ADR numbers in link relationships
3. Re-create links: `adrs link SOURCE RELATIONSHIP TARGET`

### Template Issues

**Problem:** Template doesn't match expectations

**Solutions:**
1. Try different variant: `--variant minimal` or `--variant bare`
2. Try different format: `--format madr`
3. Edit template after creation

## Best Practices

### DO:
- ✓ Run `adrs doctor` regularly
- ✓ Generate TOC after creating/updating ADRs: `adrs generate toc > doc/adr/README.md`
- ✓ Use meaningful, descriptive titles
- ✓ Update status when decisions are accepted
- ✓ Link related ADRs for traceability
- ✓ Commit ADRs to version control
- ✓ Search before creating to avoid duplicates

### DON'T:
- ✗ Edit ADR numbers manually (breaks tooling)
- ✗ Skip initialization (`adrs init`)
- ✗ Forget to update status (leaves everything as "proposed")
- ✗ Ignore `adrs doctor` warnings
- ✗ Manually edit the TOC (regenerate with `adrs generate toc`)

## Integration with Version Control

### Git Workflow

**Initial Setup:**
```bash
git init
adrs init
adrs new "Record Architecture Decisions"
adrs status 1 accepted
adrs generate toc > doc/adr/README.md
git add .
git commit -m "chore: initialize ADR repository"
```

**Creating ADR:**
```bash
git checkout -b adr/use-postgresql
adrs new "Use PostgreSQL for Primary Database"
# Edit the ADR file
adrs generate toc > doc/adr/README.md
git add doc/adr/
git commit -m "docs: add ADR for PostgreSQL decision"
git push -u origin adr/use-postgresql
# Create PR for review
```

**After PR Approval:**
```bash
git checkout main
git pull
adrs status 5 accepted
git add doc/adr/
git commit -m "docs: accept ADR 5"
git push
```

## MCP Server Integration

The `adrs` tool includes an MCP (Model Context Protocol) server for AI agent integration.

**Build with MCP:**
```bash
cargo install adrs --features mcp
```

**Configure in MCP-compatible AI client:**

Example configuration (format varies by client):
```json
{
  "mcpServers": {
    "adrs": {
      "command": "adrs",
      "args": ["serve"]
    }
  }
}
```

**Available MCP Tools:**
- 15+ ADR management functions
- Direct integration with MCP-compatible AI clients
- Automated ADR operations

## Resources

- **GitHub Repository:** https://github.com/joshrotenberg/adrs
- **Issue Tracker:** https://github.com/joshrotenberg/adrs/issues
- **Releases:** https://github.com/joshrotenberg/adrs/releases
- **Rust Crate (adrs-core):** https://crates.io/crates/adrs-core
- **API Documentation:** https://docs.rs/adrs-core

## Quick Reference Card

```bash
# Setup
adrs init                           # Initialize repository
adrs config                         # Show configuration

# Creation
adrs new "Title"                    # Create ADR (Nygard)
adrs new --format madr "Title"      # Create ADR (MADR)
adrs new --variant minimal "Title"  # Minimal template
adrs new --supersedes N "Title"     # Supersede ADR N

# Management
adrs list                           # List all ADRs
adrs list --status accepted         # Filter by status
adrs search "query"                 # Search content
adrs status N <status>              # Update status
adrs link N1 <rel> N2              # Link ADRs

# Documentation
adrs generate toc                   # Generate TOC
adrs generate graph                 # Generate graph
adrs generate book                  # Generate mdbook

# Maintenance
adrs doctor                         # Health check
adrs export json                    # Export to JSON
adrs import file.json               # Import from JSON
```
