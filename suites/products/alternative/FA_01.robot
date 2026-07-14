*** Settings ***
Resource    ../../../build/main_build.resource
Resource    ../../../shared/setup_teardown.resource
Test Setup    Start Test
Test Teardown    Finish Test

*** Test Cases ***
FA 01 - Search Product Successfully
    [Tags]    regression    products    alternative    selenium
    [Documentation]    This test case verifies that a user can search for products by name and see only related results.

    Given the user is on the all products page
    When the user searches for products by name
    Then the searched products should be displayed
