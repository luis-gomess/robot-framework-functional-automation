*** Settings ***
Resource    ../../../build/login/login_build.resource
Resource    ../../../shared/setup_teardown.resource
Test Setup    Start Test
Test Teardown    Finish Test

*** Test Cases ***
FE 01 - Login With Incorrect Credentials
    [Tags]    regression    login    exception    selenium
    [Documentation]    This test case verifies that a user cannot login using incorrect email and password.

    Given the user accesses the login screen
    When the user tries to login with incorrect credentials
    Then the incorrect login error message should be visible