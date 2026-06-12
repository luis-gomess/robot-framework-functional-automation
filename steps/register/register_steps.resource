*** Settings ***
Resource    ../../elements/selenium/main_elements.resource
Resource    ../../variables/register_variables.resource

*** Keywords ***
Validate Signup Form Visible
    Wait Until Page Contains    ${signup_page_title}    ${timeout}

Generate New User
    ${random}=    Generate Random String    5    [LOWER]
    Set Test Variable    ${default_username}    user${random}
    Set Test Variable    ${default_email}    ${random}${default_domain}

Fill Initial Signup Form
    Wait Until Element Is Visible    ${SIGNUP.NAME}    ${timeout}
    Input Text    ${SIGNUP.NAME}     ${default_username}
    Wait Until Element Is Visible    ${SIGNUP.EMAIL}    ${timeout}
    Input Text    ${SIGNUP.EMAIL}    ${default_email}

Submit Initial Signup Form
    Wait Until Element Is Visible    ${SIGNUP.BUTTON}    ${timeout}
    Wait Until Element Is Enabled    ${SIGNUP.BUTTON}    ${timeout}
    Click Button    ${SIGNUP.BUTTON}

Select Account Title Mr
    Wait Until Element Is Visible    ${ACCOUNT.TITLE_MR}    ${timeout}
    Click Element    ${ACCOUNT.TITLE_MR}

Fill Account Credentials
    [Arguments]    ${password}
    Input Password    ${ACCOUNT.PASSWORD}    ${password}

Fill Account Birth Date
    [Arguments]    ${day}    ${month}    ${year}
    Select From List By Value    ${ACCOUNT.DAY}      ${day}
    Select From List By Value    ${ACCOUNT.MONTH}    ${month}
    Select From List By Value    ${ACCOUNT.YEAR}     ${year}

Select Signup Preferences
    Select Checkbox    ${ACCOUNT.NEWSLETTER}
    Select Checkbox    ${ACCOUNT.OFFERS}

Fill Account Personal Data
    [Arguments]    ${first_name}    ${last_name}    ${company}
    Input Text    ${ACCOUNT.FIRST_NAME}    ${first_name}
    Input Text    ${ACCOUNT.LAST_NAME}     ${last_name}
    Input Text    ${ACCOUNT.COMPANY}       ${company}

Fill Account Address Data
    [Arguments]    ${address1}    ${address2}    ${country}    ${state}    ${city}    ${zipcode}    ${mobile}
    Input Text    ${ACCOUNT.ADDRESS1}      ${address1}
    Input Text    ${ACCOUNT.ADDRESS2}      ${address2}
    Select From List By Label    ${ACCOUNT.COUNTRY}    ${country}
    Input Text    ${ACCOUNT.STATE}         ${state}
    Input Text    ${ACCOUNT.CITY}          ${city}
    Input Text    ${ACCOUNT.ZIPCODE}       ${zipcode}
    Input Text    ${ACCOUNT.MOBILE}        ${mobile}

Fill Account Information
    Select Account Title Mr
    Fill Account Credentials    ${default_password}
    Fill Account Birth Date    ${day}    ${month}    ${year}
    Select Signup Preferences
    Fill Account Personal Data    ${first_name}    ${last_name}    ${company}
    Fill Account Address Data    ${address1}    ${address2}    ${country}    ${state}    ${city}    ${zipcode}    ${mobile}

Confirm Account Creation
    Wait Until Element Is Visible    ${ACCOUNT.CREATE_BUTTON}    ${timeout}
    Wait Until Element Is Enabled    ${ACCOUNT.CREATE_BUTTON}    ${timeout}
    Click Button    ${ACCOUNT.CREATE_BUTTON}

Validate Account Created Message Visible
    Wait Until Element Is Visible    ${ACCOUNT.CONTINUE_BUTTON}    ${timeout}

Continue After Account Creation
    Go To    ${geral.url}

Authenticated Header Should Be Visible
    Wait Until Element Is Visible   ${HEADER.LOGGED_USER_LINK}    ${timeout}
    Wait Until Element Is Visible   ${HEADER.LOGOUT}    ${timeout}
    Wait Until Element Is Visible   ${HEADER.DELETE_ACCOUNT}    ${timeout}

Get Logged User Text
    ${logged_user}=    Get Text   ${HEADER.LOGGED_USER_LINK}
    RETURN    ${logged_user}

Validate Logged User Message Visible
    ${expected_user}=    Set Variable    ${default_username}
    Authenticated Header Should Be Visible
    ${logged_user}=    Get Logged User Text
    Log    Expected user: ${expected_user}
    Log    Actual header text: ${logged_user}
    Should Contain    ${logged_user}    ${expected_user}

Validate Existing Email Error Visible
    Wait Until Element Is Visible    ${SIGNUP.EMAIL_ALREADY_EXISTS}    ${timeout}
    ${error_message}=    Get Text    ${SIGNUP.EMAIL_ALREADY_EXISTS}
    Log    Actual error message: ${error_message}
    Should Be Equal    ${error_message}    ${MSG001} 