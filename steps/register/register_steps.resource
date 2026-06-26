*** Settings ***
Resource    ../../elements/selenium/main_elements.resource
Resource    ../../variables/register_variables.resource

*** Keywords ***
Validate signup form visible
    Wait Until Page Contains    ${signup_page_title}    ${timeout}

Generate new user
    ${random}=    Generate Random String    5    [LOWER]
    Set Test Variable    ${default_username}    user${random}
    Set Test Variable    ${default_email}    ${random}${default_domain}

Fill initial signup form
    Wait Until Element Is Visible    ${signup.name}    ${timeout}
    Input Text    ${signup.name}     ${default_username}
    Wait Until Element Is Visible    ${signup.email}    ${timeout}
    Input Text    ${signup.email}    ${default_email}

Submit initial signup form
    Wait Until Element Is Visible    ${signup.button}    ${timeout}
    Wait Until Element Is Enabled    ${signup.button}    ${timeout}
    Click Button    ${signup.button}

Select account title Mr
    Wait Until Element Is Visible    ${account.title_mr}    ${timeout}
    Click Element    ${account.title_mr}

Fill account credentials
    [Arguments]    ${password}
    Input Password    ${account.password}    ${password}

Fill account birth date
    [Arguments]    ${day}    ${month}    ${year}
    Select From List By Value    ${account.day}      ${day}
    Select From List By Value    ${account.month}    ${month}
    Select From List By Value    ${account.year}     ${year}

Select signup preferences
    Select Checkbox    ${account.newsletter}
    Select Checkbox    ${account.offers}

Fill account personal data
    [Arguments]    ${first_name}    ${last_name}    ${company}
    Input Text    ${account.first_name}    ${first_name}
    Input Text    ${account.last_name}     ${last_name}
    Input Text    ${account.company}       ${company}

Fill account address data
    [Arguments]    ${address1}    ${address2}    ${country}    ${state}    ${city}    ${zipcode}    ${mobile}
    Input Text    ${account.address1}      ${address1}
    Input Text    ${account.address2}      ${address2}
    Select From List By Label    ${account.country}    ${country}
    Input Text    ${account.state}         ${state}
    Input Text    ${account.city}          ${city}
    Input Text    ${account.zipcode}       ${zipcode}
    Input Text    ${account.mobile}        ${mobile}

Fill account information
    Select account title Mr
    Fill account credentials    ${default_password}
    Fill account birth date    ${day}    ${month}    ${year}
    Select signup preferences
    Fill account personal data    ${first_name}    ${last_name}    ${company}
    Fill account address data    ${address1}    ${address2}    ${country}    ${state}    ${city}    ${zipcode}    ${mobile}

Confirm account creation
    Wait Until Element Is Visible    ${account.create_button}    ${timeout}
    Wait Until Element Is Enabled    ${account.create_button}    ${timeout}
    Click Button    ${account.create_button}

Validate account created message visible
    Wait Until Element Is Visible    ${account.continue_button}    ${timeout}

Continue after account creation
    Wait Until Element Is Visible    ${account.continue_button}    ${timeout}
    Wait Until Element Is Enabled    ${account.continue_button}    ${timeout}
    Click Element    ${account.continue_button}

Authenticated header should be visible
    Wait Until Element Is Visible   ${header.logged_user_link}    ${timeout}
    Wait Until Element Is Visible   ${header.logout}    ${timeout}
    Wait Until Element Is Visible   ${delete_account.button}    ${timeout}

Get logged user text
    ${logged_user}=    Get Text   ${header.logged_user_link}
    RETURN    ${logged_user}

Validate logged user message visible
    ${expected_user}=    Set Variable    ${default_username}
    Authenticated header should be visible
    ${logged_user}=    Get logged user text
    Log    Expected user: ${expected_user}
    Log    Actual header text: ${logged_user}
    Should Contain    ${logged_user}    ${expected_user}

Validate existing email error visible
    Wait Until Element Is Visible    ${signup.email_already_exists}    ${timeout}
    ${error_message}=    Get Text    ${signup.email_already_exists}
    Log    Actual error message: ${error_message}
    Should Be Equal    ${error_message}    ${MSG001_register} 
