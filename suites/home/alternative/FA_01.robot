*** Settings ***
Resource    ../../../build/main_build.resource
Resource    ../../../shared/setup_teardown.resource
Test Setup    Start Test
Test Teardown    Finish Test

*** Test Cases ***
FA 01 - Verify Subscription in Home Page
    [Tags]    regression    home    alternative    selenium
    [Documentation]    This test case verifies that a user can subscribe successfully from the home page footer.

    Given the user is on the home page
    When the user subscribes from the home page footer
    Then the subscription should be completed successfully
