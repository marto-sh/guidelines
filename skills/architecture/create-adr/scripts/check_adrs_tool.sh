#!/usr/bin/env bash
# Check if adrs tool is installed and provide installation instructions if not

set -e

if command -v adrs &> /dev/null; then
    echo "✓ adrs tool is installed (version: $(adrs --version))"
    exit 0
else
    echo "✗ adrs tool is not installed"
    echo ""
    echo "To install adrs, choose one of the following methods:"
    echo ""
    echo "Homebrew:"
    echo "  brew install joshrotenberg/brew/adrs"
    echo ""
    echo "Cargo (Rust):"
    echo "  cargo install adrs"
    echo ""
    echo "Docker:"
    echo "  docker run --rm -v \$(pwd):/work ghcr.io/joshrotenberg/adrs"
    echo ""
    echo "Binary releases: https://github.com/joshrotenberg/adrs/releases"
    echo ""
    exit 1
fi
