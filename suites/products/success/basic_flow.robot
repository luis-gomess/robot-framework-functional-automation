*** Settings ***
Resource    ../../../build/main_build.resource
Resource    ../../../shared/setup_teardown.resource
Test Setup    Start Test
Test Teardown    Finish Test

*** Test Cases ***
Basic Flow - Verify Products Catalog and Product Details
    [Tags]    regression    products    success    selenium
    [Documentation]   This test case verifies that the products catalog and the first product details are displayed successfully.

    Given the user is on the all products page
    When the user opens the first product details
    Then the product details should be displayed successfully
