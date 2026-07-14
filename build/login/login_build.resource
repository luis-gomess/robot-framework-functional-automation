*** Settings ***
Resource    ../../steps/main_steps.resource
Resource    ../register/register_build.resource

*** Keywords ***
the user has a valid registered account
    the user starts the account registration
    the user completes the account registration
    the account should be created successfully
    Log out from account

the user accesses the login screen
    Access login signup screen
    Validate login form visible

the user tries to login with correct credentials
    Fill login form with correct credentials
    Submit login form

the user tries to login with incorrect credentials
    Fill login form with incorrect credentials
    Submit login form

the incorrect login error message should be visible
    Validate invalid login error visible

the user logs out from account
    Log out from account

the user should be redirected to the login screen
    Validate login form visible
