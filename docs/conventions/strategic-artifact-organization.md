# Strategic Artifact Organization

The location of key design documents should be consistent and predictable across all projects. This makes it easy for anyone to find the information they need to understand the project's architecture and design decisions.

## Rationale

- **Agent accessibility**: Makes it easy for AI agents to locate and parse architectural information

## Design Documents

All strategic design artifacts are located in the `docs/design/` directory.

```
project_root/
└── docs/
    └── design/              # Strategic design artifacts
        ├── DOMAIN_VISION.md  # Domain vision statement
        ├── UBIQUITOUS_LANGUAGE.md  # Ubiquitous language glossary
        ├── CONTEXT_MAP.md     # Context mapping and boundaries
        ├── ARCHITECTURE.md     # High-level architecture decisions
        └── DECISIONS/         # Architecture Decision Records (ADRs)
            ├── 0001-use-rust.md
            └── 0002-error-handling-strategy.md
```

## Purpose of Each Artifact

- `DOMAIN_VISION.md`: A high-level description of the domain, its strategic importance, and the problems it solves.
- `UBIQUITOUS_LANGUAGE.md`: A glossary of domain terms with precise, unambiguous definitions, shared between technical and non-technical team members.
- `CONTEXT_MAP.md`: A visual representation of the system's bounded contexts and the relationships between them.
- `ARCHITECTURE.md`: An overview of the high-level architecture, major components, and key design principles.
- `DECISIONS/`: A collection of Architecture Decision Records (ADRs) that document significant architectural choices, their context, and their consequences.

## References

- [Architecture Decision Records](https://adr.github.io/)

