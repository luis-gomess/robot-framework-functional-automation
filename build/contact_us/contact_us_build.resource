*** Settings ***
Resource    ../../steps/main_steps.resource

*** Keywords ***
the user accesses the contact us screen
    Validate home page visible
    Access contact us screen
    Validate contact us form visible

the user submits the contact us form with valid information
    Fill contact us form
    Upload contact us attachment
    Submit contact us form
    Accept contact us submission alert

the contact request should be submitted successfully
    Validate contact us success message visible

the user should return to the home page
    Return to home from contact us
    Validate home page visible
