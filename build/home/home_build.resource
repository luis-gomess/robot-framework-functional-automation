*** Settings ***
Resource    ../../steps/main_steps.resource
Resource    ../../variables/home_variables.resource

*** Keywords ***
the user is on the home page
    Validate home page visible

the user subscribes from the home page footer
    Submit subscription email    ${subscription_email}

the subscription should be completed successfully
    Validate subscription success message visible    ${subscription_success_message}
