*** Settings ***
Resource    ../../../build/main_build.resource
Resource    ../../../shared/setup_teardown.resource
Test Setup     Start Test
Test Teardown  Finish Test

*** Test Cases ***
Basic Flow - Verify Test Cases Page Successfully
    [Tags]    regression    test_cases    success    selenium
    [Documentation]   This test case verifies that a user can navigate to the Test Cases page successfully.

    Given the home page is visible
    When the user accesses the test cases screen
    Then the test cases page should be visible
