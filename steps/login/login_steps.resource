*** Settings ***
Resource    ../../elements/selenium/main_elements.resource
Resource    ../../variables/login_variables.resource

*** Keywords ***
Access Login Signup Screen
    Wait Until Element Is Visible    ${home.signup_login}    ${timeout}
    Click Element    ${home.signup_login}

Validate Login Form Visible
    Wait Until Page Contains    ${LOGIN_PAGE_TITLE}    ${timeout}

Fill Login Form With Incorrect Credentials
    Wait Until Element Is Visible    ${login.email}    ${timeout}
    Input Text    ${login.email}    ${email_invalid}
    Wait Until Element Is Visible    ${login.password}    ${timeout}
    Input Password    ${login.password}    ${password_invalid}

Submit Login Form
    Wait Until Element Is Visible    ${login.button}    ${timeout}
    Wait Until Element Is Enabled    ${login.button}    ${timeout}
    Click Button    ${login.button}

Validate Invalid Login Error Visible
    Wait Until Element Is Visible    ${login.invalid_credentials}    ${timeout}
    ${error_message}=    Get Text    ${login.invalid_credentials}
    Log    Actual error message: ${error_message}
    Should Be Equal    ${error_message}    ${MSG004}
