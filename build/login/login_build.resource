*** Settings ***
Resource    ../../steps/main_steps.resource

*** Keywords ***
the user accesses the login screen
    Access Login Signup Screen
    Validate Login Form Visible

the user tries to login with incorrect credentials
    Fill Login Form With Incorrect Credentials
    Submit Login Form

the incorrect login error message should be visible
    Validate Invalid Login Error Visible