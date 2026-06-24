# robot-framework-functional-automation

Functional test automation project for [Automation Exercise](https://automationexercise.com/), built with **Robot Framework** and **SeleniumLibrary**.

This repository automates the test scenarios from the official Automation Exercise test case list:

```text
https://automationexercise.com/test_cases
```

The original test cases were respected as the functional source of truth. Some scenario names and internal organization were adapted only to keep the repository cleaner, more readable, and easier to maintain.

---

## Project Purpose

The goal of this project is not only to automate UI tests, but to structure them in a way that makes future scenarios easier to add and maintain.

The automation was designed around a functional layered architecture focused on:

* reusing existing flows;
* avoiding duplicated keywords;
* keeping test cases readable;
* separating business flow from UI interaction;
* organizing scenarios by functional domain;
* making the project scalable as more test cases are automated.

---

## Test Case Source

The project is based on the **26 test cases** provided by Automation Exercise.

Instead of keeping all scenarios in a flat structure, the tests are organized by domain and scenario type.

Example:

```text
suites/
  login/
    success/
    exception/

  register/
    success/
    exception/
```

Scenario types are used to make the repository easier to navigate:

```text
success      -> happy path scenarios
alternative  -> valid alternative flows
exception    -> invalid or error validation flows
```

---

## Architecture

The project follows a layered functional architecture:

```text
Test Cases
    ↓
Build
    ↓
Steps
    ↓
Elements / Variables
    ↓
Shared / Config
```

Each layer has a clear responsibility, allowing scenarios to be created by reusing existing keywords whenever possible.

For a detailed explanation of how the architecture works, check the documentation:

```text
docs/
```

---

## Current Structure

```text
project/

|-- suites/
|-- build/
|-- steps/
|-- elements/
|-- variables/
|-- shared/
|-- config/
`-- results/
```

---

## Technologies

* Robot Framework
* SeleniumLibrary
* Python
* Browser automation with Selenium
* Functional test organization by domain

---

## Main Idea

The central principle of this repository is:

```text
Add new scenarios by reusing as much existing implementation as possible.
```

The test case should describe what the user does.

The lower layers should handle how the automation executes it.

---

## Example

A test case remains readable and focused on user behavior:

```robot
Basic Flow - Register User Successfully
    [Tags]    regression    register    success    selenium
    [Documentation]    This test case verifies that a user can successfully register an account on the website.

    Given the user starts the account registration
    When the user completes the account registration
    Then the account should be created successfully
    And the user should be authenticated
```

The implementation details are handled by reusable Build and Step keywords.

---

## Repository Focus

This repository is focused on:

* functional UI automation;
* clean scenario organization;
* reusable Robot Framework keywords;
* maintainable Selenium interactions;
* clear separation between test intention and implementation.

The purpose is to keep the automation simple to understand, easy to expand, and consistent across all test scenarios.
