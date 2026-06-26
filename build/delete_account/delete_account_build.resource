*** Settings ***
Resource    ../../steps/main_steps.resource

*** Keywords ***

the user deletes the account
    Delete logged account

the account should be deleted successfully
    Validate account deleted message visible
