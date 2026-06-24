*** Settings ***
Resource    ../../../build/login/login_build.resource
Resource    ../../../shared/setup_teardown.resource
Test Setup    Start Test
Test Teardown    Finish Test

*** Test Cases ***
Basic Flow - Login User Successfully
    [Tags]    regression    login    success    selenium
    [Documentation]    This test case verifies that a user can successfully login with correct credentials.

    Given the user has a valid registered account
    And the user accesses the login screen
    When the user tries to login with correct credentials
    Then the user should be authenticated
    And the user deletes the account
    And the account should be deleted successfully