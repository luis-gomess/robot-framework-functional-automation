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
    Wait Until Element Is Visible    ${signup.name}    ${timeout}
    Input Text    ${signup.name}     ${default_username}
    Wait Until Element Is Visible    ${signup.email}    ${timeout}
    Input Text    ${signup.email}    ${default_email}

Submit Initial Signup Form
    Wait Until Element Is Visible    ${signup.button}    ${timeout}
    Wait Until Element Is Enabled    ${signup.button}    ${timeout}
    Click Button    ${signup.button}

Select Account Title Mr
    Wait Until Element Is Visible    ${account.title_mr}    ${timeout}
    Click Element    ${account.title_mr}

Fill Account Credentials
    [Arguments]    ${password}
    Input Password    ${account.password}    ${password}

Fill Account Birth Date
    [Arguments]    ${day}    ${month}    ${year}
    Select From List By Value    ${account.day}      ${day}
    Select From List By Value    ${account.month}    ${month}
    Select From List By Value    ${account.year}     ${year}

Select Signup Preferences
    Select Checkbox    ${account.newsletter}
    Select Checkbox    ${account.offers}

Fill Account Personal Data
    [Arguments]    ${first_name}    ${last_name}    ${company}
    Input Text    ${account.first_name}    ${first_name}
    Input Text    ${account.last_name}     ${last_name}
    Input Text    ${account.company}       ${company}

Fill Account Address Data
    [Arguments]    ${address1}    ${address2}    ${country}    ${state}    ${city}    ${zipcode}    ${mobile}
    Input Text    ${account.address1}      ${address1}
    Input Text    ${account.address2}      ${address2}
    Select From List By Label    ${account.country}    ${country}
    Input Text    ${account.state}         ${state}
    Input Text    ${account.city}          ${city}
    Input Text    ${account.zipcode}       ${zipcode}
    Input Text    ${account.mobile}        ${mobile}

Fill Account Information
    Select Account Title Mr
    Fill Account Credentials    ${default_password}
    Fill Account Birth Date    ${day}    ${month}    ${year}
    Select Signup Preferences
    Fill Account Personal Data    ${first_name}    ${last_name}    ${company}
    Fill Account Address Data    ${address1}    ${address2}    ${country}    ${state}    ${city}    ${zipcode}    ${mobile}

Confirm Account Creation
    Wait Until Element Is Visible    ${account.create_button}    ${timeout}
    Wait Until Element Is Enabled    ${account.create_button}    ${timeout}
    Click Button    ${account.create_button}

Validate Account Created Message Visible
    Wait Until Element Is Visible    ${account.continue_button}    ${timeout}

Continue After Account Creation
    Go To    ${geral.url}

Authenticated Header Should Be Visible
    Wait Until Element Is Visible   ${header.logged_user_link}    ${timeout}
    Wait Until Element Is Visible   ${header.logout}    ${timeout}
    Wait Until Element Is Visible   ${header.delete_account}    ${timeout}

Get Logged User Text
    ${logged_user}=    Get Text   ${header.logged_user_link}
    RETURN    ${logged_user}

Validate Logged User Message Visible
    ${expected_user}=    Set Variable    ${default_username}
    Authenticated Header Should Be Visible
    ${logged_user}=    Get Logged User Text
    Log    Expected user: ${expected_user}
    Log    Actual header text: ${logged_user}
    Should Contain    ${logged_user}    ${expected_user}

Delete logged account
    Wait Until Element Is Visible    ${header.delete_account}    ${timeout}
    Click Element    ${header.delete_account}

Validate account deleted message visible
    Wait Until Element Is Visible    ${account.deleted_title}    ${timeout}
    ${deleted_message}=    Get Text    ${account.deleted_title}
    Log    Actual deleted account message: ${deleted_message}
    Should Be Equal    ${deleted_message}    ${MSG005}

Validate Existing Email Error Visible
    Wait Until Element Is Visible    ${signup.email_already_exists}    ${timeout}
    ${error_message}=    Get Text    ${signup.email_already_exists}
    Log    Actual error message: ${error_message}
    Should Be Equal    ${error_message}    ${MSG001} 
