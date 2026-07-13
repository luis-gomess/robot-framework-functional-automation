*** Settings ***
Resource    ../../elements/selenium/main_elements.resource

*** Keywords ***
Access test cases screen
    Wait Until Element Is Visible    ${test_cases.menu_link}    ${timeout}
    Click Element    ${test_cases.menu_link}

Validate test cases page visible
    Wait Until Element Is Visible    ${test_cases.title}    ${timeout}
