*** Settings ***
Resource    ../../steps/main_steps.resource

*** Keywords ***

the user starts the account registration
    Access login signup screen
    Validate signup form visible

the user completes the account registration
    Generate new user
    Fill initial signup form
    Submit initial signup form
    Fill account information
    Confirm account creation

the account should be created successfully
    Validate account created message visible
    Continue after account creation

the user should be authenticated
    Validate logged user message visible
