---
name: ddd/write-domain-vision
description: Guides the creation of a concise Domain Vision Statement by asking a series of structured questions.
---

# Skill: ddd/write-domain-vision

## When to use

Activate this skill at the beginning of a project or when a new major domain is being defined. Use it to establish a "North Star" for the project, ensuring all stakeholders and team members have a shared, high-level understanding of the problem, the solution, and the unique value proposition.

## Instructions

1.  **Explain the Goal.** Inform the user that you will guide them through creating a Domain Vision Statement by asking a series of questions. The final output will be a `DOMAIN_VISION.md` file in their current directory.

2.  **Gather Information for "The Problem".**
    *   Ask the user: "**Who is the primary target user or customer for this domain?**" (e.g., "Online Shoppers", "Warehouse Managers").
    *   Ask the user: "**What is the core need or opportunity that they are facing?**" (e.g., "need to find products quickly", "struggle with inventory tracking").

3.  **Gather Information for "The Solution".**
    *   Ask the user: "**What is the name of the product or domain we are building?**"
    *   Ask the user: "**What category does this product belong to?**" (e.g., "e-commerce platform", "inventory management system").
    *   Ask the user: "**What is the single most important benefit it provides? What is the compelling reason to use it?**" (e.g., "provides a highly personalized shopping experience", "automates stock level adjustments in real-time").

4.  **Gather Information for "The Differentiation".**
    *   Ask the user: "**What is the main alternative or competitor our users might otherwise use?**" (e.g., "Amazon", "manual spreadsheet tracking").
    *   Ask the user: "**What is the single most significant thing that makes our solution different and better?**" (e.g., "curates products from ethical sources only", "integrates directly with our existing logistics software").

5.  **Generate the Document.**
    *   Read the template file from `skills/ddd/write-domain-vision/assets/domain_vision_template.md`.
    *   Replace the placeholders in the template with the user's answers.
    *   Use the `write_file` tool to create a new file named `DOMAIN_VISION.md` in the current directory with the completed content.
    *   Inform the user that the `DOMAIN_VISION.md` has been created.
