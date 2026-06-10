*** Settings ***
Resource    ../../../build/register/register_build.resource
Resource    ../../../shared/setup_teardown.resource
Test Setup     Start Test
Test Teardown  Finish Test

*** Test Cases ***
Basic Flow - Register User Successfully
    [Tags]    regression    register    success    selenium
    [Documentation]   This test case verifies that a user can successfully register an account on the website.

    Given the user starts the account registration
    When the user completes the account registration
    Then the account should be created successfully
    And the user should be authenticated
