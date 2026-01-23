# Reference: Ubiquitous Language

The Ubiquitous Language is a shared, rigorous language developed by the team (developers, domain experts, business stakeholders) to talk about the domain. In DDD, this language should be used in all forms of communication, including conversations, documentation, and the code itself.

## Key Principles

1.  **Shared:** Everyone on the team must use and understand the language. If a developer uses one term and a domain expert uses another for the same concept, the language is not shared.
2.  **Unambiguous:** Each term should have a single, precise definition within a given Bounded Context. A term like "Product" might mean one thing in the "Sales" context and something completely different in the "Shipping" context. This is a sign that you have two different concepts and two Bounded Contexts.
3.  **Reflected in the Code:** This is the most crucial aspect. Class names, method names, variable names, and module names should all be drawn from the Ubiquitous Language. If the business calls it a "Booking," the class should not be named `Reservation`.
4.  **Living Document:** The language is not set in stone. As the team's understanding of the domain deepens, the language will evolve. The glossary should be treated as a living document that is updated regularly.

## Building the Glossary

- **Start Early:** Begin defining terms from the very first conversation with domain experts.
- **Be Explicit:** Don't assume everyone knows what a term means. Write it down.
- **Challenge Ambiguity:** When a term is used in a fuzzy way, stop and ask for clarification. "When you say 'customer,' are you referring to the person browsing the site, the person who pays, or the person who receives the shipment?"
- **Use a Central, Visible Location:** The glossary should be easily accessible to everyone on the team. A `UBIQUITOUS_LANGUAGE.md` file in the root of the project repository is a common and effective practice.
