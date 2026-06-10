*** Settings ***
Resource    ../../elements/selenium/main_elements.resource

*** Keywords ***

Generate New User
    ${random}=    Generate Random String    5    [LOWER]

    ${user}=    Create Dictionary
    ...    name=User${random}
    ...    email=user${random}@email.com
    ...    password=Test@123
    ...    first_name=John
    ...    last_name=Doe
    ...    company=Automation
    ...    address1=Street 1
    ...    address2=Apartment 101
    ...    state=Ontario
    ...    city=Toronto
    ...    zipcode=12345
    ...    mobile=11999999999

    Set Test Variable    ${USER}    ${user}

    RETURN    ${user}

Fill Initial Signup Form
    [Arguments]    ${user}
    Wait Until Element Is Visible    ${SIGNUP.NAME}    10
    Input Text    ${SIGNUP.NAME}     ${user.name}
    Wait Until Element Is Visible    ${SIGNUP.EMAIL}    10
    Input Text    ${SIGNUP.EMAIL}    ${user.email}

Submit Initial Signup Form
    Wait Until Element Is Visible    ${SIGNUP.BUTTON}    10
    Wait Until Element Is Enabled    ${SIGNUP.BUTTON}    10
    Click Button    ${SIGNUP.BUTTON}

Validate Account Information Form Visible
    Wait Until Element Is Visible    ${ACCOUNT.TITLE_MR}    10

Select Account Title Mr
    Validate Account Information Form Visible
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
    [Arguments]    ${user}
    Select Account Title Mr
    Fill Account Credentials    ${user.password}
    Fill Account Birth Date    10    5    1995
    Select Signup Preferences
    Fill Account Personal Data    ${user.first_name}    ${user.last_name}    ${user.company}
    Fill Account Address Data
    ...    ${user.address1}
    ...    ${user.address2}
    ...    Canada
    ...    ${user.state}
    ...    ${user.city}
    ...    ${user.zipcode}
    ...    ${user.mobile}

Confirm Account Creation
    Wait Until Element Is Visible    ${ACCOUNT.CREATE_BUTTON}    10
    Wait Until Element Is Enabled    ${ACCOUNT.CREATE_BUTTON}    10
    Click Button    ${ACCOUNT.CREATE_BUTTON}

Validate Account Created Message Visible
    Wait Until Element Is Visible    ${ACCOUNT.CONTINUE_BUTTON}    30

Continue After Account Creation
    Go To    ${geral.url}

Authenticated Header Should Be Visible
    Wait Until Element Is Visible   ${HEADER.LOGGED_USER_LINK}    10
    Wait Until Element Is Visible   ${HEADER.LOGOUT}    10
    Wait Until Element Is Visible   ${HEADER.DELETE_ACCOUNT}    10

Get Logged User Text
    ${logged_user}=    Get Text   ${HEADER.LOGGED_USER_LINK}
    RETURN    ${logged_user}

Validate Logged User Message Visible
    ${expected_user}=    Set Variable    ${USER}[name]
    Authenticated Header Should Be Visible
    ${logged_user}=    Get Logged User Text
    Log    Expected user: ${expected_user}
    Log    Actual header text: ${logged_user}
    Should Contain    ${logged_user}    ${expected_user}

Validate Existing Email Error Visible
    Wait Until Element Is Visible    ${SIGNUP.EMAIL_ALREADY_EXISTS}    10
    ${error_message}=    Get Text    ${SIGNUP.EMAIL_ALREADY_EXISTS}
    Log    Actual error message: ${error_message}
    Should Be Equal    ${error_message}    Email Address already exist!