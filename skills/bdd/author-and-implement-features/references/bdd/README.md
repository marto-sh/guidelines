# Behavior-Driven Development (BDD) in Rust with Cucumber

Behavior-Driven Development (BDD) is a software development process that encourages collaboration between developers, QA, and non-technical stakeholders. It achieves this by using a common, natural language to describe a system's behavior. The syntax for this language is called **Gherkin**.

In the Rust ecosystem, the `cucumber` crate is the primary tool for practicing BDD. It parses Gherkin `.feature` files and connects them to Rust code to execute tests.

## The Gherkin Syntax

Gherkin uses a set of keywords to structure executable specifications:

-   `Feature`: Describes a high-level software feature.
-   `Scenario`: A concrete example illustrating a business rule.
-   `Given`: Sets up the initial state before an event occurs.
-   `When`: Describes an event or an action.
-   `Then`: Describes the expected outcome.
-   `And`, `But`: Chains multiple steps together for readability.

## Setting Up a Rust Project for Cucumber

Here’s how to set up `cucumber` in your Rust project.

### Project Structure

Your BDD files should be organized as follows:

```
.
├── Cargo.toml
├── features/
│   └── my_feature.feature       # Your Gherkin feature files
└── tests/
    ├── cucumber.rs               # Test runner: World struct + main() only
    └── steps/
        ├── mod.rs                # Declares step definition modules
        └── my_feature.rs         # Step definitions for the feature
```

Feature files and step definition files have a 1:1 mapping. Each `.feature` file gets a corresponding `.rs` file under `tests/steps/` with the same name (kebab-case to snake_case). The `tests/cucumber.rs` file stays minimal — it only holds the `World` struct and the `main()` entry point. If shared steps emerge across features, they can be extracted into a common module at that point.

The `init_bdd_feature.sh` script in this skill can be used to quickly create new `.feature` files.

### `.gitignore`

Use the template at `assets/.gitignore.template` as a starting point. It will grow as the project adds build artifacts, IDE files, environment variables, etc.

### `Cargo.toml`

You need to add `cucumber` and `tokio` to your dependencies. You also need to declare a new test target to act as the BDD test runner.

```toml
[dependencies]
cucumber = "0.19"
tokio = { version = "1", features = ["macros", "rt-multi-thread"] }

# This tells Cargo to create a test binary named "cucumber"
# that we will write ourselves, instead of the default test harness.
[[test]]
name = "cucumber"
harness = false
```

### Example: A Simple Calculator

Let's walk through testing a simple calculator.

#### The Feature File

**`features/calculator.feature`**
```gherkin
Feature: Calculator
  In order to avoid silly mistakes
  As a math-challenged user
  I want to be told the sum of two numbers

  Scenario: Add two numbers
    Given I have a calculator
    When I add 2 and 3
    Then the result should be 5
```

#### The Rust Implementation

**`tests/cucumber.rs`** — Test runner (World struct + entry point only)
```rust
mod steps;

use cucumber::World;

// This is our domain object.
#[derive(Debug, Default)]
pub struct Calculator {
    pub result: i32,
}

impl Calculator {
    pub fn add(&mut self, a: i32, b: i32) {
        self.result = a + b;
    }
}

// `World` is the shared state between steps in a scenario.
// A new `World` is created for each scenario.
#[derive(Debug, World)]
#[world(init = Self::new)]
pub struct MyWorld {
    pub calculator: Calculator,
}

impl MyWorld {
    fn new() -> Self {
        Self {
            calculator: Calculator::default(),
        }
    }
}

// This function is the entry point for running the cucumber tests.
// It will discover and run all feature files in the `features` directory.
#[tokio::main]
async fn main() {
    MyWorld::run("features").await;
}
```

**`tests/steps/mod.rs`**
```rust
pub mod calculator;
```

**`tests/steps/calculator.rs`** — Step definitions for the calculator feature
```rust
use cucumber::{given, then, when};
use crate::MyWorld;

#[given("I have a calculator")]
fn i_have_a_calculator(_world: &mut MyWorld) {
    // The world is already initialized with a new calculator,
    // so this step is just for declarative clarity.
}

#[when(regex = r"I add (\d+) and (\d+)")]
fn i_add_two_numbers(world: &mut MyWorld, a: i32, b: i32) {
    world.calculator.add(a, b);
}

#[then(regex = r"the result should be (\d+)")]
fn the_result_should_be(world: &mut MyWorld, expected_result: i32) {
    assert_eq!(world.calculator.result, expected_result);
}
```

### Running the Tests

To run your BDD tests, execute the following command:

```bash
cargo test --test cucumber
```

The runner will find your feature files, execute the matching Rust code, and report the results. If a step is missing a Rust implementation, the test will fail and tell you which one is undefined.