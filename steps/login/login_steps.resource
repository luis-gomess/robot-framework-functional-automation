*** Settings ***
Resource    ../../elements/selenium/main_elements.resource

*** Keywords ***

Access Login Signup Screen
    Wait Until Element Is Visible    ${HOME.SIGNUP_LOGIN}    10
    Click Element    ${HOME.SIGNUP_LOGIN}

Access Login Page
    Access Login Signup Screen

Validate Signup Form Visible
    Wait Until Page Contains    New User Signup!    10

Validate Login Form Visible
    Wait Until Page Contains    Login to your account    10

Fill Login Form With Incorrect Credentials
    Wait Until Element Is Visible    ${LOGIN.EMAIL}    10
    Input Text    ${LOGIN.EMAIL}    invalid.user@email.com
    Wait Until Element Is Visible    ${LOGIN.PASSWORD}    10
    Input Password    ${LOGIN.PASSWORD}    Invalid@123

Submit Login Form
    Wait Until Element Is Visible    ${LOGIN.BUTTON}    10
    Wait Until Element Is Enabled    ${LOGIN.BUTTON}    10
    Click Button    ${LOGIN.BUTTON}

Validate Invalid Login Error Visible
    Wait Until Element Is Visible    ${LOGIN.INVALID_CREDENTIALS}    10
    ${error_message}=    Get Text    ${LOGIN.INVALID_CREDENTIALS}
    Log    Actual error message: ${error_message}
    Should Be Equal    ${error_message}    Your email or password is incorrect!