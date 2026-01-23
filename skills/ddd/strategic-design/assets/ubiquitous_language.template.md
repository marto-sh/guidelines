# Ubiquitous Language Glossary

This document is a single source of truth for the terminology used in this domain. It should be developed collaboratively by developers, domain experts, and stakeholders.

| Term | Definition | Business Rules / Invariants |
| --- | --- | --- |
| **[Term Name]** | A clear, concise, and unambiguous definition of the term as it's used in this specific context. | List any rules or constraints associated with this term. E.g., "A Premium Customer must have a total lifetime spend of over $1000." |
| **Customer** | An individual or organization that has placed at least one order. | A customer is identified by a unique Customer ID. |
| **Order** | A customer's request to purchase one or more products. An order has a lifecycle (e.g., pending, paid, shipped, cancelled). | An order must be associated with a valid Customer. An order must contain at least one line item. |
| | | |
