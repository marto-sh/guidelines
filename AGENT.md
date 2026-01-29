# Agent Instructions

This repository provides a set of guidelines, skills, and documentation to facilitate a robust and efficient agentic development process. It is designed to be included in other repositories to standardize and improve the performance of AI agents working on those codebases.

## Cross-Provider Compatibility

The guidelines and skills in this repository are designed to be cross-provider compatible. They should work with various AI agents and CLIs, including Gemini, OpenCode, Claude, Mistral's Vibe CLI, and others. The goal is to create a universal set of instructions that any capable agent can follow.

## Core Development Process

The development process heavily emphasizes Behavior-Driven Development (BDD) and Domain-Driven Design (DDD).

*   **BDD:** Please refer to the BDD skills located in `skills/bdd/` for authoring and implementing features.
*   **DDD:** For domain modeling and strategic design, consult the DDD skills in `skills/ddd/`.
*   **Development Process:** A detailed explanation of the development process can be found in `DEVELOPMENT_PROCESS.md`.

## Clarifying Requirements

When requirements are unclear or ambiguous, always seek clarification from the human user before proceeding. Do not make assumptions about the user's intent. Ask specific questions to ensure you understand:

*   The desired outcome and acceptance criteria
*   Any constraints or preferences
*   Edge cases or scenarios that need to be handled

It is better to ask for clarification upfront than to deliver something that does not match the user's expectations.

## Skill Authoring

To maintain a high standard of skills, a dedicated skill for authoring new skills is available. Please refer to `skills/skill/authoring/SKILL.md` when you are tasked with creating a new skill. Adhering to this guide will ensure that new skills are well-defined, effective, and consistent with the existing skill set.

Before starting any task, please familiarize yourself with the relevant guidelines and skills in this repository.
