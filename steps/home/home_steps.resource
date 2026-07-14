*** Settings ***
Resource    ../../elements/selenium/main_elements.resource

*** Keywords ***
Validate home page visible
    Wait Until Element Is Visible    ${home_page.slider}    ${timeout}
