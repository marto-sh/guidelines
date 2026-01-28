# Philosophy: Agents Are First-Class Citizens

Our core philosophy is that **AI agents are first-class citizens in the development process**. We design our codebase and structure our workflows to be easily understood, parsed, and augmented by AI agents. Humans and agents collaborate on all aspects of the project, including architecture, behavior specification, requirements, and implementation.

This has a profound implication: **increased boilerplate is not an issue if it helps the agent do a better job.**

## Rationale

- **Agent-human collaboration**: Recognizes that modern software development involves both human and AI contributors
- **Boilerplate justification**: Accepts that some redundancy is beneficial if it improves agent comprehension and reliability
- **Tooling leverage**: Emphasizes using Rust's strong type system and compiler as machine-readable documentation
- **Predictability focus**: Prioritizes consistency and explicitness to reduce ambiguity for all contributors
- **Standardization**: Favors established patterns that provide common ground for diverse team members
- **Automation priority**: Uses tools like clippy to handle routine enforcement, freeing humans for higher-level work
- **Security integration**: Treats security as a fundamental concern rather than an add-on feature
- **Evolutionary approach**: Encourages continuous refinement of conventions by all team members, including AI agents

From this central principle, several other key philosophies emerge:

*   **The Compiler is Your First Line of Defense:** We leverage Rust's strong type system and compiler checks to provide clear, machine-readable feedback, which is invaluable for both human and agent developers.

*   **Explicit is Better than Implicit:** Code should make its dependencies, contracts, and behaviors obvious. This reduces ambiguity and makes the codebase easier for an agent to reason about.

*   **Value Predictability:** A consistent and predictable codebase is easier for both humans and agents to navigate and modify. Two developers (or two agents) should solve the same problem in a similar way.

*   **Follow Established Standards:** We adhere to established standards and patterns (like those in the Rust `stdlib`) because they are well-documented and provide a common ground for both humans and agents.
    *   [Rust API Guidelines](https://rust-lang.github.io/api-guidelines/)
    *   [Rust by Example](https://doc.rust-lang.org/stable/rust-by-example/)

*   **Clarity Over Cleverness:** We prioritize straightforward code over complex or obscure language features. Clear code is more maintainable and easier for agents to parse and generate.

*   **Use `clippy` for Enforcement:** We automate the enforcement of conventions using `clippy`. This provides fast, consistent feedback for everyone.

*   **Keep Manual Conventions Minimal:** We only document what cannot be automated. This keeps the focus on what requires human attention.

*   **Security is Not an Afterthought:** Security considerations are integrated from the beginning, with an emphasis on leveraging Rust's safety features to their fullest extent.

*   **Embrace Continuous Improvement:** The conventions themselves are not static. We encourage the team (including our AI agents) to challenge, refine, and improve these guidelines over time.