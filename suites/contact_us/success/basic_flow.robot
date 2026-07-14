*** Settings ***
Resource    ../../../build/main_build.resource
Resource    ../../../shared/setup_teardown.resource
Test Setup     Start Test
Test Teardown  Finish Test

*** Test Cases ***
Basic Flow - Submit Contact Us Form Successfully
    [Tags]    regression    contact_us    success    selenium
    [Documentation]   This test case verifies that a user can successfully submit the Contact Us form and return to the home page.

    Given the user accesses the contact us screen
    When the user submits the contact us form with valid information
    Then the contact request should be submitted successfully
    And the user should return to the home page
