*** Settings ***
Resource    ../../elements/selenium/main_elements.resource

*** Keywords ***
Validate home page visible
    Wait Until Element Is Visible    ${home_page.slider}    ${timeout}

Submit subscription email
    [Arguments]    ${email}
    Scroll Element Into View    ${home_page.subscription_title}
    Wait Until Element Is Visible    ${home_page.subscription_title}    ${timeout}
    ${subscription_title}=    Get Text    ${home_page.subscription_title}
    ${normalized_subscription_title}=    Convert To Upper Case    ${subscription_title}
    Should Be Equal    ${normalized_subscription_title}    SUBSCRIPTION
    Wait Until Element Is Visible    ${home_page.subscription_email}    ${timeout}
    Input Text    ${home_page.subscription_email}    ${email}
    Wait Until Element Is Visible    ${home_page.subscription_button}    ${timeout}
    Wait Until Element Is Enabled    ${home_page.subscription_button}    ${timeout}
    Scroll Element Into View    ${home_page.subscription_button}
    Click Button    ${home_page.subscription_button}

Validate subscription success message visible
    [Arguments]    ${expected_message}
    Wait Until Element Is Visible    ${home_page.subscription_success_message}    ${timeout}
    Element Should Be Visible    ${home_page.subscription_success_message}
    ${actual_message}=    Get Text    ${home_page.subscription_success_message}
    Should Not Be Empty    ${actual_message}
    Should Be Equal    ${actual_message}    ${expected_message}
