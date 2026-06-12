*** Settings ***
Resource    ../../elements/selenium/main_elements.resource
Resource    ../../variables/login_variables.resource

*** Keywords ***
Access Login Signup Screen
    Wait Until Element Is Visible    ${HOME.SIGNUP_LOGIN}    ${timeout}
    Click Element    ${HOME.SIGNUP_LOGIN}

Validate Login Form Visible
    Wait Until Page Contains    ${LOGIN_PAGE_TITLE}    ${timeout}

Fill Login Form With Incorrect Credentials
    Wait Until Element Is Visible    ${LOGIN.EMAIL}    ${timeout}
    Input Text    ${LOGIN.EMAIL}    ${email_invalid}
    Wait Until Element Is Visible    ${LOGIN.PASSWORD}    ${timeout}
    Input Password    ${LOGIN.PASSWORD}    ${password_invalid}

Submit Login Form
    Wait Until Element Is Visible    ${LOGIN.BUTTON}    ${timeout}
    Wait Until Element Is Enabled    ${LOGIN.BUTTON}    ${timeout}
    Click Button    ${LOGIN.BUTTON}

Validate Invalid Login Error Visible
    Wait Until Element Is Visible    ${LOGIN.INVALID_CREDENTIALS}    ${timeout}
    ${error_message}=    Get Text    ${LOGIN.INVALID_CREDENTIALS}
    Log    Actual error message: ${error_message}
    Should Be Equal    ${error_message}    ${MSG004}