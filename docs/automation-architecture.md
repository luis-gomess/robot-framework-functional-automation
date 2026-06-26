# Functional Test Automation Architecture

## Overview

This project contains functional test automations for the website:

```text
https://automationexercise.com/
```

The automations are built with **Robot Framework** and **SeleniumLibrary**, following a layered and domain-oriented architecture.

The main goal of this architecture is to make it easier to add new test scenarios by reusing as many existing keywords, locators, data, and validations as possible.

The structure was designed to keep the test automation code:

* readable;
* reusable;
* easy to maintain;
* organized by functional domain;
* separated by responsibility;
* simple to evolve as new scenarios are added.

---

## Architecture Goal

The architecture exists to clearly separate:

```text
what the user does
from
how the automation executes it
```

The test case should describe the user behavior, while the implementation details should remain isolated in lower layers.

Main architecture flow:

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

Each layer has a specific responsibility.

---

## Architecture Layers

### Test Cases

The `suites/` layer contains the test scenarios.

This layer represents only the functional user flow using BDD.

Example:

```robot
*** Test Cases ***

Basic Flow - Register User Successfully
    [Tags]    regression    register    success    selenium
    [Documentation]    This test case verifies that a user can successfully register an account on the website.

    Given the user starts the account registration
    When the user completes the account registration
    Then the account should be created successfully
    And the user should be authenticated
```

Responsibilities:

* describe the user behavior;
* use BDD syntax;
* keep the scenario readable;
* define tags and scenario documentation.

This layer must not contain:

* Selenium actions;
* locators;
* waits;
* test data generation;
* technical logic;
* flow implementation details.

The Test Case answers:

```text
What user behavior is being validated?
```

---

### Build

The `build/` layer represents the functional orchestration of the flow.

It connects the BDD text from the Test Case with reusable actions from the Steps layer.

Example:

```robot
the user starts the account registration
    Access login signup screen
    Validate Signup Form Visible

the user completes the account registration
    Generate New User
    Fill Initial Signup Form
    Submit Initial Signup Form
    Fill Account Information
    Confirm Account Creation

the account should be created successfully
    Validate Account Created Message Visible
    Continue After Account Creation

the user should be authenticated
    Validate Logged User Message Visible
```

Responsibilities:

* orchestrate the functional flow;
* reuse existing Steps;
* compose business behavior;
* avoid duplicated workflows between scenarios.

This layer must not contain:

* direct Selenium usage;
* locators;
* technical waits;
* direct field input;
* technical UI validations.

The Build layer answers:

```text
Which functional actions must happen to validate this behavior?
```

---

### Steps

The `steps/` layer contains reusable functional actions.

In the current project architecture, Steps execute UI interactions using SeleniumLibrary and locators defined in the Elements layer.

Example:

```robot
Access login signup screen
    Wait Until Element Is Visible    ${home.signup_login}    ${timeout}
    Click Element    ${home.signup_login}

Fill login form with correct credentials
    Wait Until Element Is Visible    ${login.email}    ${timeout}
    Input Text    ${login.email}    ${default_email}
    Wait Until Element Is Visible    ${login.password}    ${timeout}
    Input Password    ${login.password}    ${default_password}

Submit login form
    Wait Until Element Is Visible    ${login.button}    ${timeout}
    Wait Until Element Is Enabled    ${login.button}    ${timeout}
    Click Button    ${login.button}
```

Responsibilities:

* execute reusable functional actions;
* interact with the UI;
* use locators from Elements;
* use data from Variables;
* apply explicit waits;
* perform functional validations;
* generate useful logs for analysis.

This layer must not contain:

* BDD scenarios;
* full business flow orchestration;
* duplicated actions already available in another Step;
* locators declared directly inside keywords.

The Step layer answers:

```text
Which reusable functional action will be executed?
```

---

### Elements

The `elements/` layer contains the UI element mapping.

In the current project architecture, Elements store only locators organized by domain or page.

Example:

```robot
*** Settings ***
Resource    ../../../config/settings.resource

*** Variables ***

&{login}
...    email=css:input[data-qa="login-email"]
...    password=css:input[data-qa="login-password"]
...    button=css:button[data-qa="login-button"]
...    invalid_credentials=xpath=//p[contains(.,'Your email or password is incorrect!')]

&{account}
...    create_button=css:button[data-qa="create-account"]
...    continue_button=css:a[data-qa="continue-button"]
```

Responsibilities:

* store locators;
* group elements by domain or page;
* make UI maintenance easier when selectors change.

This layer must not contain:

* keywords;
* click actions;
* input actions;
* waits;
* assertions;
* UI text extraction;
* business rules.

The Elements layer answers:

```text
Where is the element located on the screen?
```

Locator priority:

```text
1. data-qa
2. id
3. name
4. css selector
5. relative xpath, only when necessary
```

Avoid:

```text
absolute xpath
fragile selectors
unnecessary xpath when data-qa is available
```

---

### Variables

The `variables/` layer contains reusable domain data.

Example:

```robot
*** Variables ***

${MSG001_register}    Email Address already exist!

${default_domain}    @email.com
${default_password}    Test@123
${first_name}    John
${last_name}    Doe
${company}    Automation
${country}    Canada
```

Responsibilities:

* store expected messages;
* store reusable test data;
* centralize functional data used by Steps.

This layer must not contain:

* locators;
* Selenium actions;
* business flows;
* environment configuration.

The Variables layer answers:

```text
Which reusable data or messages does this domain need?
```

---

### Shared

The `shared/` layer contains cross-cutting resources.

Currently, the main shared resource is the test setup and teardown.

Example:

```robot
Start Test
    Open Browser    ${geral.url}    ${geral.browser}
    Maximize Browser Window

Finish Test
    Close All Browsers
```

Responsibilities:

* setup;
* teardown;
* generic utilities when needed.

This layer must not contain:

* login-specific logic;
* register-specific logic;
* page-specific locators;
* scenario-specific data.

The Shared layer answers:

```text
What is common to multiple tests and does not belong to a specific domain?
```

---

### Config

The `config/` layer contains environment configuration.

The project uses this file as a reference:

```text
config/settings_example.resource
```

Example:

```robot
${timeout}    5

&{geral}
...     url=https://automationexercise.com/
...     browser=chrome
```

Responsibilities:

* base URL;
* browser;
* timeout;
* global execution settings.

This layer must not contain:

* functional flows;
* scenario-specific test data;
* locators;
* validations.

The Config layer answers:

```text
How is the execution environment configured?
```

---

## Current Project Structure

```text
project/

|-- suites/
|   |-- login/
|   |   |-- success/
|   |   |   `-- basic_flow.robot
|   |   `-- exception/
|   |       `-- FE_01.robot
|   |
|   `-- register/
|       `-- success/
|           `-- basic_flow.robot
|
|-- build/
|   |-- login/
|   |   `-- login_build.resource
|   |-- register/
|   |   `-- register_build.resource
|   `-- main_build.resource
|
|-- steps/
|   |-- login/
|   |   `-- login_steps.resource
|   |-- register/
|   |   `-- register_steps.resource
|   `-- main_steps.resource
|
|-- elements/
|   `-- selenium/
|       |-- login/
|       |   `-- login_elements.resource
|       |-- register/
|       |   `-- register_elements.resource
|       `-- main_elements.resource
|
|-- variables/
|   |-- login_variables.resource
|   `-- register_variables.resource
|
|-- shared/
|   `-- setup_teardown.resource
|
|-- config/
|   `-- settings_example.resource
|
`-- results/
```

---

## Suite Organization

Suites are organized by domain and scenario type.

Format:

```text
suites/
    domain/
        scenario_type/
            test_file.robot
```

Current examples:

```text
suites/register/success/basic_flow.robot
suites/login/success/basic_flow.robot
suites/login/exception/FE_01.robot
```

Scenario types:

```text
success
alternative
exception
```

Naming convention:

```text
success/basic_flow.robot
alternative/FA_01.robot
exception/FE_01.robot
```

---

## Resource Aggregators

The project uses resource aggregators to centralize imports by layer.

Current aggregators:

```text
build/main_build.resource
steps/main_steps.resource
elements/selenium/main_elements.resource
```

They reduce repeated imports and make cross-domain reuse easier.

Example:

```robot
*** Settings ***
Resource    login/login_build.resource
Resource    register/register_build.resource
```

Benefits:

* fewer direct imports in suites;
* centralized dependencies;
* easier domain reuse;
* simpler maintenance.

---

## Example: Creating the Register User Scenario

This example shows how the architecture is used to create a successful user registration scenario.

---

### 1. Create the Test Case

File:

```text
suites/register/success/basic_flow.robot
```

Content:

```robot
*** Settings ***
Resource    ../../../build/register/register_build.resource
Resource    ../../../shared/setup_teardown.resource
Test Setup    Start Test
Test Teardown    Finish Test

*** Test Cases ***
Basic Flow - Register User Successfully
    [Tags]    regression    register    success    selenium
    [Documentation]    This test case verifies that a user can successfully register an account on the website.

    Given the user starts the account registration
    When the user completes the account registration
    Then the account should be created successfully
    And the user should be authenticated
```

The Test Case does not know how to click, fill fields, or perform technical validations.

It only describes the functional user flow.

---

### 2. Implement the Flow in Build

File:

```text
build/register/register_build.resource
```

Example:

```robot
*** Settings ***
Resource    ../../steps/main_steps.resource

*** Keywords ***

the user starts the account registration
    Access login signup screen
    Validate Signup Form Visible

the user completes the account registration
    Generate New User
    Fill Initial Signup Form
    Submit Initial Signup Form
    Fill Account Information
    Confirm Account Creation

the account should be created successfully
    Validate Account Created Message Visible
    Continue After Account Creation

the user should be authenticated
    Validate Logged User Message Visible
```

The Build layer organizes the registration flow using reusable Steps.

---

### 3. Create or Reuse Steps

File:

```text
steps/register/register_steps.resource
```

Example:

```robot
Generate New User
    ${random}=    Generate Random String    5    [LOWER]
    Set Test Variable    ${default_username}    user_${random}
    Set Test Variable    ${default_email}    ${random}${default_domain}

Fill Initial Signup Form
    Wait Until Element Is Visible    ${signup.name}    ${timeout}
    Input Text    ${signup.name}     ${default_username}
    Wait Until Element Is Visible    ${signup.email}    ${timeout}
    Input Text    ${signup.email}    ${default_email}

Submit Initial Signup Form
    Wait Until Element Is Visible    ${signup.button}    ${timeout}
    Wait Until Element Is Enabled    ${signup.button}    ${timeout}
    Click Button    ${signup.button}
```

Steps execute reusable functional actions.

---

### 4. Use Locators from Elements

File:

```text
elements/selenium/login/login_elements.resource
```

Example:

```robot
&{signup}
...    name=css:input[data-qa="signup-name"]
...    email=css:input[data-qa="signup-email"]
...    button=css:button[data-qa="signup-button"]
```

Locators stay isolated in Elements.

If a selector changes, maintenance is done in one place.

---

### 5. Use Data from Variables

File:

```text
variables/register_variables.resource
```

Example:

```robot
${default_domain}    @email.com
${default_password}    Test@123
${first_name}    John
${last_name}    Doe
${country}    Canada
```

Reusable data stays outside the Test Case and outside the Build layer.

---

## Why This Architecture Improves Reuse

The main advantage of this architecture is that each behavior can be reused in other scenarios.

Example:

A successful login scenario needs a valid registered account.

Instead of duplicating the registration process inside the login flow, the login Build can reuse the existing register flow:

```robot
the user has a valid registered account
    the user starts the account registration
    the user completes the account registration
    the account should be created successfully
    Log out from account
```

Then the login flow can continue using the data generated during registration:

```robot
the user tries to login with correct credentials
    Fill login form with correct credentials
    Submit login form
```

This avoids duplicated flows such as:

```robot
Register User For Login
Create Account Before Login
Fill Register Form Again For Login Test
```

The rule is simple:

```text
If a functional flow already exists, it should be reused.
```

---

## Authenticated User Validation

Authentication validation should not rely only on a page transition.

It should verify functional signs that the user is actually authenticated, such as:

* logged user text is visible;
* expected user name is shown in the header;
* logout option is visible;
* delete account option is visible.

Example:

```robot
Validate Logged User Message Visible
    Authenticated Header Should Be Visible
    ${logged_user}=    Get Logged User Text
    ${expected_user}=    Set Variable    ${default_username}
    Log    Expected user: ${expected_user}
    Log    Actual header text: ${logged_user}
    Should Contain    ${logged_user}    ${expected_user}
```

This approach creates functional evidence and useful execution logs.

---

## Naming Standard

### Test Cases

Test Cases use BDD prefixes:

```robot
Given the user starts the account registration
When the user completes the account registration
Then the account should be created successfully
And the user should be authenticated
```

---

### Build

Build keywords represent the functional phrase called by the Test Case, without the BDD prefix:

```robot
the user starts the account registration
the user completes the account registration
the account should be created successfully
the user should be authenticated
```

---

### Steps

New or modified Step keywords should use sentence case:

```robot
Access login signup screen
Fill login form with correct credentials
Submit login form
Log out from account
Delete logged account
Validate account deleted message visible
```

Avoid Title Case in new implementations:

```robot
Access Login Signup Screen
Fill Login Form With Correct Credentials
Submit Login Form
Validate Account Deleted Message Visible
```

Legacy keywords can be adjusted gradually when touched by new scenarios or controlled refactors.

---

## Project Practices

When creating or changing an automation:

* keep the Test Case focused only on the functional flow;
* reuse existing Build keywords whenever possible;
* create a new Build keyword only when there is a new functional behavior;
* reuse existing Steps;
* create a new Step only when the action or validation is reusable;
* create a new locator only when the element does not already exist;
* keep locators in Elements;
* keep expected messages and reusable data in Variables;
* avoid duplicated flows;
* avoid `Sleep`;
* prefer explicit waits;
* prioritize `data-qa`, `id`, `name`, and stable CSS selectors;
* do not use absolute xpath;
* do not mix large refactors with scenario creation.

---

## Checklist for a New Scenario

Before creating a new keyword, check:

```text
Does this flow already exist in Build?
Does this action already exist in Steps?
Does this locator already exist in Elements?
Does this data already exist in Variables?
```

Recommended order:

```text
1. Create or adjust the Test Case.
2. Reuse an existing Build flow.
3. Create a new Build keyword only if necessary.
4. Reuse existing Steps.
5. Create a new Step only if it is reusable.
6. Create a new locator only if necessary.
7. Validate the scenario with dryrun.
8. Execute the real test.
```

Useful commands:

```powershell
robot --dryrun suites/login/success suites/login/exception suites/register/success
robot suites/login/success
robot suites/login/success suites/login/exception suites/register/success
```

---

## Core Principle

The architecture must always preserve:

```text
functional clarity
+ single responsibility
+ high reuse
+ low coupling
+ simple maintenance
+ domain-driven organization
```

The central rule of the project is:

```text
Add new scenarios by reusing as much existing implementation as possible.
```