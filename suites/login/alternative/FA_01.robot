*** Settings ***
Resource    ../../../build/main_build.resource
Resource    ../../../shared/setup_teardown.resource
Test Setup    Start Test
Test Teardown    Finish Test

*** Test Cases ***
FA 01 - Logout User
    [Tags]    regression    login    alternative    selenium
    [Documentation]    This test case verifies that an authenticated user can successfully log out and is redirected to the login page.

    Given the user has a valid registered account
    And the user accesses the login screen
    And the user tries to login with correct credentials
    And the user should be authenticated
    When the user logs out from account
    Then the user should be redirected to the login screen
