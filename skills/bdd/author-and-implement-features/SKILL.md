---
name: bdd/author-and-implement-features
description: Guides the user in writing and implementing BDD features using Gherkin and the Cucumber framework for Rust.
---

# Skill: bdd/author-and-implement-features

## Persona

**The Collaborator:** You bridge the gap between business stakeholders and the development team. You are focused on clearly defining system behavior in a way that is understandable to everyone. You ensure that the software being built is the software that is needed.

## When to Use

Activate this skill when you need to define or implement a specific piece of system behavior. This skill is typically orchestrated by a process skill like `process/bdd-outside-in`, but can be used standalone to write or test any feature.

## Instructions

This skill guides you through writing a feature in Gherkin and implementing the test code in Rust using the `cucumber` crate.

### Phase 1: Author the Behavior

1.  **Create a Feature File:**
    *   **Instruction:** Every feature starts in a `.feature` file. Use the `init_bdd_feature.sh` script to create a new one. This script uses the template located in `assets/`.
    *   **Action:** `run_shell_command(command: "./skills/bdd/author-and-implement-features/scripts/init_bdd_feature.sh <YourFeatureName>")`
    *   **Example:** `run_shell_command(command: "./skills/bdd/author-and-implement-features/scripts/init_bdd_feature.sh \"User Authentication\"")`

2.  **Write Scenarios in Gherkin:**
    *   **Instruction:** Open the newly created `.feature` file and describe the feature's behavior using `Scenario`, `Given`, `When`, and `Then`. Write from the user's perspective. Be specific and deterministic.
    *   **Example:**
        ```gherkin
        Feature: User Authentication

          Scenario: Successful login with valid credentials
            Given I am a registered user with the username "testuser"
            And I am on the login page
            When I enter my username "testuser" and password "password123"
            And I click the "Login" button
            Then I should be redirected to my dashboard
        ```

### Phase 2: Implement the Test Code (Rust)

To make your Gherkin scenarios executable, you need to write "step definitions" in Rust using the `cucumber` crate.

1.  **Project Setup:**
    *   **Instruction:** Ensure your `Cargo.toml` is configured for cucumber tests.
    *   **Reference:** For a complete, one-time setup guide, see the [Cucumber Setup Guide](./references/bdd/README.md).

2.  **Define the World:**
    *   **Instruction:** In your test runner file (e.g., `tests/cucumber.rs`), define a `World` struct. This struct holds the state for each scenario (e.g., the user, the system under test, etc.).
    *   **Reference:** The [Cucumber Setup Guide](./references/bdd/README.md) contains a full example of a `World` struct.

3.  **Write Step Definitions:**
    *   **Instruction:** For each Gherkin step (`Given`, `When`, `Then`), write a corresponding Rust function annotated with a `cucumber` macro. Use regular expressions to capture arguments from the step.
    *   **Example:**
        ```rust
        // In tests/cucumber.rs

        use cucumber::{given, when, then, World};

        // Assume `MyWorld` struct and a `User` struct exist

        #[given(regex = r#"I am a registered user with the username \"(\w+)\""#)]
        fn registered_user(world: &mut MyWorld, username: String) {
            // Logic to create or fetch a user and store it in the world
            world.user = Some(User::new(&username));
        }

        #[when(regex = r#"I enter my username \"(\w+)\" and password \"(\w+)\""#)]
        fn enter_credentials(world: &mut MyWorld, user: String, pass: String) {
            // Logic to perform the login action
            world.login_result = world.auth_service.login(&user, &pass);
        }

        #[then(regex = r#"I should be redirected to my dashboard"#)]
        fn redirected_to_dashboard(world: &mut MyWorld) {
            // Assert that the login result was successful
            assert!(world.login_result.is_ok());
        }
        ```

### Phase 3: Run the Tests

*   **Instruction:** Execute the BDD tests using the `cargo test` command, specifying the test runner name you configured in `Cargo.toml`.
*   **Action:** `run_shell_command(command: "cargo test --test cucumber")`

This command will run all `.feature` files and report the results.
