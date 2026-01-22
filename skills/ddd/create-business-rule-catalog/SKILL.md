---
name: ddd/create-business-rule-catalog
description: Helps create a central catalog of critical business rules and invariants.
---

# Skill: ddd/create-business-rule-catalog

## When to use

Activate this skill when you need to make the core business logic of your application explicit and verifiable by non-technical stakeholders. It is particularly useful for complex domains where a shared understanding of the rules is critical.

## Instructions

1.  **Explain the Goal.** Inform the user that this skill will help them create a `BUSINESS_RULES.md` file to catalog critical business rules and invariants.

2.  **Detail Rules (Iterative).**
    *   Explain that you will now loop through the business rules.
    *   Start the loop by asking for the first rule: "**In plain language, what is a critical business rule the system must follow?** (e.g., 'A customer's credit limit cannot be exceeded'). Type 'done' when you have no more rules."
    *   For each rule provided:
        *   Ask: "**Provide a short, unique ID for this rule.**" (e.g., "BR-001").
        *   Ask: "**What is the scope of this rule?** (e.g., 'Orders Context', 'Shipment Aggregate')."
        *   Ask: "**Is this a hard 'Invariant' (must never be broken) or a softer 'Policy' (can sometimes be overridden)?**"
    *   Repeat this loop until the user types 'done'.

3.  **Generate the Document.**
    *   Read the template file from `skills/ddd/create-business-rule-catalog/assets/business_rule_catalog_template.md`.
    *   For each rule the user detailed, add a new row to the markdown table.
    *   Use the `write_file` tool to create a new file named `BUSINESS_RULES.md` in the current directory with the completed content.
    *   Inform the user that the catalog has been created and can be used for validation with domain experts.
