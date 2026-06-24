*** Settings ***
Resource    ../../elements/selenium/main_elements.resource
Resource    ../../variables/login_variables.resource

*** Keywords ***
Access login signup screen
    Wait Until Element Is Visible    ${home.signup_login}    ${timeout}
    Click Element    ${home.signup_login}

Log out from account
    Wait Until Element Is Visible    ${header.logout}    ${timeout}
    Click Element    ${header.logout}

Validate login form visible
    Wait Until Page Contains    ${login_page_title}    ${timeout}

Fill login form with incorrect credentials
    Wait Until Element Is Visible    ${login.email}    ${timeout}
    Input Text    ${login.email}    ${email_invalid}
    Wait Until Element Is Visible    ${login.password}    ${timeout}
    Input Password    ${login.password}    ${password_invalid}

Fill login form with correct credentials
    Wait Until Element Is Visible    ${login.email}    ${timeout}
    Input Text    ${login.email}    ${default_email}
    Wait Until Element Is Visible    ${login.password}    ${timeout}
    Input Password    ${login.password}    ${default_password}

Submit login form
    Wait Until Element Is Visible    ${login.button}    ${timeout}
    Wait Until Element Is Enabled    ${login.button}    ${timeout}
    Click Button    ${login.button}

Validate invalid login error visible
    Wait Until Element Is Visible    ${login.invalid_credentials}    ${timeout}
    ${error_message}=    Get Text    ${login.invalid_credentials}
    Log    Actual error message: ${error_message}
    Should Be Equal    ${error_message}    ${MSG004}
