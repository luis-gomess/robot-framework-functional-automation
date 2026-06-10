# Enterprise Test Automation Blueprint

## Overview

This project implements a domain-driven test automation framework built with Robot Framework and Selenium Library.

The architecture is designed to maximize:

* Reusability
* Maintainability
* Scalability
* Readability
* Separation of concerns
* Low coupling
* Functional consistency

The framework follows a layered architecture where each layer owns a single responsibility.

```text
Test Cases
    ↓
Build
    ↓
Steps
    ↓
Elements
    ↓
Shared / Config
```

---

# Architecture Layers

| Layer      | Purpose                     | Allowed                                           | Not Allowed                                     |
| ---------- | --------------------------- | ------------------------------------------------- | ----------------------------------------------- |
| Test Cases | User behavior definition    | BDD flow                                          | Selenium, locators, technical logic             |
| Build      | Business flow orchestration | Functional composition                            | Selenium, locators, BDD                         |
| Steps      | Reusable functional actions | Functional validations, Selenium actions and waits | Business orchestration, direct test definitions |
| Elements   | UI mapping layer            | Settings and locator variables                    | Keywords, Selenium actions, business rules      |
| Shared     | Cross-cutting utilities     | Context, waits, setup, teardown, helpers          | Domain-specific logic                           |
| Config     | Environment configuration   | URLs, timeouts, variables                         | Functional behavior                             |
| Results    | Execution artifacts         | Logs, reports, outputs                            | Test implementation                             |

---

# Project Structure

```text
project/

|-- suites/
|   |-- login/
|   |   |-- success/
|   |   |-- alternative/
|   |   `-- exception/
|   |
|   `-- register/
|       |-- success/
|       |-- alternative/
|       `-- exception/
|
|-- build/
|   |-- login/
|   |   `-- login_build.resource
|   |-- register/
|   |   `-- register_build.resource
|   `-- main_build.resource
|-- steps/
|   |-- login/
|   |   `-- login_steps.resource
|   |-- register/
|   |   `-- register_steps.resource
|   `-- main_steps.resource
|-- elements/
|   `-- selenium/
|       |-- login/
|       |   `-- login_elements.resource
|       |-- register/
|       |   `-- register_elements.resource
|       `-- main_elements.resource
|-- shared/
|-- config/
`-- results/
```

---

# Suite Organization

Suites must always follow:

```text
domain -> scenario type
```

Example:

```text
suites/register/success/basic_flow.robot
suites/register/alternative/FA_01.robot
suites/register/exception/FE_01.robot
suites/login/success/basic_flow.robot
suites/login/alternative/FA_01.robot
suites/login/exception/FE_01.robot
```

### Naming Convention

Success:

```text
basic_flow.robot
```

Alternative:

```text
FA_01.robot
FA_02.robot
```

Exception:

```text
FE_01.robot
FE_02.robot
```

---

# Test Case Standard

Test cases represent only the user journey.

```robot
*** Test Cases ***

Basic Flow - Successful Signup

    [Tags]    regression    signup    success

    Given the user starts the account registration
    When the user completes the account registration
    Then the account should be created successfully
    And the user should be authenticated
```

Rules:

* BDD exists only in Test Cases.
* No Selenium usage.
* No locators.
* No technical implementation details.

---

# Build Standard

Build resources orchestrate business behavior.

Example:

```robot
Start Account Registration
    Open Signup Page

Complete Account Registration
    Fill Signup Form With Valid Data
    Submit Signup Form

Validate Account Created Successfully
    Validate Signup Success Message
```

Rules:

* Organized by business flow.
* Reuse existing steps whenever possible.
* Never organized by scenario type.
* No Selenium interaction.

---

# Steps Standard

Steps provide reusable functional actions.

Example:

```robot
Fill Signup Form With Valid Data
    Generate Signup User Data
    Input Signup Name
    Input Signup Email
    Input Signup Password

Submit Signup Form
    Click Signup Button
```

Rules:

* Encapsulate reusable functional behavior.
* Contain functional assertions.
* Consume Element variables.
* Own Selenium interactions, waits and technical validations.
* Avoid business orchestration.

---

# Elements Standard

Elements represent the UI mapping layer.

Responsibilities:

* Settings imports needed by the element resource
* Locators

Forbidden:

* Keywords
* Click actions
* Text input
* Wait strategies
* Technical validations
* UI text extraction
* Business rules

Locator priority:

```text
1. data-qa
2. id
3. name
4. css selector
5. relative xpath (last resort)
```

Example:

```robot
*** Settings ***
Resource    ../../../config/settings.resource

*** Variables ***
&{SIGNUP}
...    BUTTON=css:button[data-qa="signup-button"]
```

---

# Authentication Validation Strategy

Authentication validation must verify:

* Successful login state
* Authenticated user visibility
* Logout availability
* Delete account availability

Example:

```robot
${actual_user}=      Get Authenticated User Text
${expected_user}=    Get Context Value    signup_user_name

Should Contain    ${actual_user}    ${expected_user}

Log    Expected user: ${expected_user}
Log    Actual user: ${actual_user}
```

This approach provides functional validation and auditable execution logs.

---

# Resource Aggregation

Resource aggregators centralize imports by domain.

Example:

```text
build/register/register_build.resource
steps/register/register_steps.resource
elements/selenium/register/register_elements.resource
```

Benefits:

* Reduced coupling
* Simplified imports
* Better maintainability
* Consistent dependency management

---

# Technical Standards

## Selenium

* SeleniumLibrary only
* No JavaScript execution
* No absolute XPath
* Prefer data-qa, id and name
* Avoid Sleep
* Prefer explicit waits

## Robot Framework

* Keywords start with uppercase letters
* Consistent naming
* Modular design
* Maximum reuse
* No duplicated flows
* Avoid parameter overload

---

# Reusability Guidelines

Business flows must be reused across all scenario types.

Variation should be introduced through:

* Test data
* Context values
* Specific validation steps

Never duplicate an existing business flow to support a new scenario.

---

# Future Evolution

The framework supports reusable UI components.

Example:

```text
elements/selenium/components/

├── header_elements.resource
├── modal_elements.resource
├── sidebar_elements.resource
```

Components should be introduced when the same UI behavior appears across multiple pages or domains.

---

# Design Decisions

### BDD Restricted to Test Cases

Keeps business intent readable and isolated from technical implementation.

### Build as Business Orchestration

Promotes reuse and prevents duplicated workflows.

### Steps as Functional Abstraction

Creates a stable contract between business flows and UI interactions.

### Elements as UI Mapping

Isolates locator maintenance from functional logic and Selenium actions.

### Controlled Shared Context

Reduces parameter overload while preserving test readability.

### Resource Aggregators

Simplify dependency management and reduce import complexity.

---

# Quality Checklist

Before implementing a new automation:

* Is the test case purely BDD?
* Is Build only orchestrating?
* Is the Step reusable?
* Is Selenium isolated in Elements?
* Is there any duplicated flow?
* Is Sleep being used unnecessarily?
* Can the locator use data-qa, id or name?
* Is shared context justified?
* Is the file located in the correct domain?
* Does the validation generate auditable evidence?

---

# Core Principle

Every automation must preserve:

```text
Functional clarity
+ Single responsibility
+ High reusability
+ Low coupling
+ Simple maintenance
+ Domain-driven organization
```
