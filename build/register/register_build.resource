*** Settings ***
Resource    ../../steps/main_steps.resource

*** Keywords ***

the user starts the account registration
    Access login signup screen
    Validate Signup Form Visible

the user completes the account registration
    Generate New User
    Fill Initial Signup Form
    Submit Initial Signup Form
    Fill Account Information
    Confirm Account Creation

the account should be created successfully
    Validate Account Created Message Visible
    Continue After Account Creation

the user should be authenticated
    Validate Logged User Message Visible
