*** Settings ***
Resource    ../../elements/selenium/main_elements.resource
Resource    ../../variables/contact_us_variables.resource

*** Keywords ***
Access contact us screen
    Wait Until Element Is Visible    ${contact_us.menu_link}    ${timeout}
    Click Element    ${contact_us.menu_link}

Validate contact us form visible
    Wait Until Element Is Visible    ${contact_us.title}    ${timeout}

Fill contact us form
    Wait Until Element Is Visible    ${contact_us.name}    ${timeout}
    Input Text    ${contact_us.name}    ${contact_name}
    Wait Until Element Is Visible    ${contact_us.email}    ${timeout}
    Input Text    ${contact_us.email}    ${contact_email}
    Wait Until Element Is Visible    ${contact_us.subject}    ${timeout}
    Input Text    ${contact_us.subject}    ${contact_subject}
    Wait Until Element Is Visible    ${contact_us.message}    ${timeout}
    Input Text    ${contact_us.message}    ${contact_message}

Upload contact us attachment
    Choose File    ${contact_us.upload}    ${contact_us_attachment_path}

Submit contact us form
    Wait Until Element Is Visible    ${contact_us.submit}    ${timeout}
    Wait Until Element Is Enabled    ${contact_us.submit}    ${timeout}
    Click Button    ${contact_us.submit}

Accept contact us submission alert
    Handle Alert    ACCEPT

Validate contact us success message visible
    Wait Until Element Is Visible    ${contact_us.success_message}    ${timeout}
    ${success_message}=    Get Text    ${contact_us.success_message}
    Log    Actual contact us success message: ${success_message}
    Should Be Equal    ${success_message}    ${MSG001_contact_us}

Return to home from contact us
    Wait Until Element Is Visible    ${contact_us.home_button}    ${timeout}
    Click Element    ${contact_us.home_button}
