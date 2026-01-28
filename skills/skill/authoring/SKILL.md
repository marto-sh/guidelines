---
name: skill/authoring
description: A skill for authoring new agent skills based on user requests and provided documentation, following the open Agent Skills standard for portability and extensibility.
---

# Skill: skill/authoring

## When to use

This skill should be activated when the user requests the creation of a new skill or capability.

This skill should _not_ be used for:

- One-off tasks or simple queries that do not represent a new, general-purpose capability
- Requests that can be handled by existing skills without creating new ones
- Situations where the user needs immediate execution rather than skill creation
- Cases where the requested functionality is too specific or not reusable

## Instructions

1. **Clarify the Objective:** Fully understand the user's goal. Identify the new, reusable capability the agent needs to acquire. Ensure this represents contextual knowledge that can be provided on-demand.
2. **Gather Information:** Use all available resources to understand the task thoroughly:
   - If the user provides source information (URL, file, or text), use appropriate tools like `web_fetch` or `read_file` to extract relevant information.
   - If no source information is provided, actively search for documentation, examples, or references using available tools.
   - Examine existing skills for reference to understand established patterns, naming conventions, and best practices.
   - Ask clarifying follow-up questions to ensure complete understanding of requirements and constraints.
3. **Define Skill Anatomy:** Based on the gathered information, structure the new skill following the open Agent Skills standard. A skill is a directory containing:
   - **`SKILL.md` (Required):** The core skill file with:
     - **YAML Frontmatter:** Metadata including:
       - `name`: Unique, descriptive, atomic identifier using **action-oriented naming** with verb-noun pattern (e.g., `architecture/create-adr`, `bdd/author-and-implement-features`, `ddd/write-domain-vision`, `strategy/find-competitors`). Avoid noun-only names like `adr-best-practices` or `competitor-analysis`.
       - `description`: Detailed explanation of what the skill does and when to use it
       - `allowed-tools` (optional): List of specific tools the skill is permitted to use
     - **Markdown Body:** Detailed, step-by-step instructions for the agent
   - **`scripts/` (Optional):** Directory for executable code the skill might use
   - **`references/` (Optional):** Additional documentation or reference materials
   - **`assets/` (Optional):** Static files like templates, data files, or images
4. **Create Supporting Directories:** Strongly consider creating the optional directories when they would enhance the skill:
   - **`scripts/`:** Create this directory if the skill requires executable code, automation scripts, or helper utilities. Include well-documented, reusable scripts that follow best practices.
   - **`references/`:** Create this directory for supplementary documentation, API references, or detailed explanations that support the skill's functionality.
   - **`assets/`:** Create this directory for templates, sample files, configuration examples, or other static resources that the skill might reference or use.

   These directories significantly enhance skill portability, maintainability, and usability. Even if empty initially, creating them provides a clear structure for future expansion.

5. **Write Activation Criteria:** In the "When to Use" section, write precise activation criteria. Clearly state when the skill SHOULD and SHOULD NOT be used, following the progressive disclosure principle where the agent should only load detailed instructions when needed.
6. **Refine Instructions:** When writing the instructions, adhere to the following best practices:
   - **Atomicity:** Each step should correspond to a single, distinct action.
   - **Clarity:** Use lists and bullet points to break down complex ideas. Prefer bullet points over long, comma-separated sentences.
   - **Tool Mapping:** Map each action to a specific, available tool (e.g., `run_shell_command`, `read_file`, `replace`).
   - **Context Awareness:** Instruct the agent to analyze existing project files, code, and conventions before making changes.
   - **Safety and Verification:** Include steps for verification, such as running tests, linters, or build commands after a modification.
   - **Planning:** For complex workflows, the first instruction should be to create a plan.
   - **Portability:** Ensure instructions work across different environments and AI agents.
7. **Format and Output:** Present the completed skill in the structured `SKILL.md` format, detailing the Skill Name, the "When to Use" criteria, and the numbered "Instructions". Ensure the skill follows the open standard for maximum portability and extensibility.
