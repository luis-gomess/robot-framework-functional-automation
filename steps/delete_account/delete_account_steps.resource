*** Settings ***
Resource    ../../elements/selenium/main_elements.resource
Resource    ../../variables/delete_account_variables.resource

*** Keywords ***

Delete logged account
    Wait Until Element Is Visible    ${delete_account.button}    ${timeout}
    Click Element    ${delete_account.button}

Validate account deleted message visible
    Wait Until Element Is Visible    ${delete_account.deleted_title}    ${timeout}
    ${deleted_message}=    Get Text    ${delete_account.deleted_title}
    Log    Actual deleted account message: ${deleted_message}
    Should Be Equal    ${deleted_message}    ${MSG001_account_deleted}
