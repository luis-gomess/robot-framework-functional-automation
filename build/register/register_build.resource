*** Settings ***
Resource    ../../steps/main_steps.resource

*** Keywords ***

the user starts the account registration
    Access Login Signup Screen
    Validate Signup Form Visible

the user completes the account registration
    ${user}=    Generate New User
    Fill Initial Signup Form    ${user}
    Submit Initial Signup Form
    Validate Account Information Form Visible
    Fill Account Information    ${user}
    Confirm Account Creation

the account should be created successfully
    Validate Account Created Message Visible
    Continue After Account Creation

the user should be authenticated
    Validate Logged User Message Visible