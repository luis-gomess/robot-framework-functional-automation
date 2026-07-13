*** Settings ***
Resource    ../../../build/main_build.resource
Resource    ../../../shared/setup_teardown.resource
Test Setup    Start Test
Test Teardown    Finish Test

*** Test Cases ***
FE 01 - Register User With Existing Email
    [Tags]    regression    register    exception    selenium
    [Documentation]    This test case verifies that a user cannot register using an email address that is already registered.

    Given the user has a valid registered account
    And the user starts the account registration
    When the user tries to register with an existing email
    Then the existing email error message should be visible
