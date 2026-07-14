*** Settings ***
Resource    ../../steps/main_steps.resource

*** Keywords ***
the user is on the all products page
    Validate home page visible
    Access products screen
    Validate all products page visible
    Validate products list visible

the user opens the first product details
    Open first product details

the product details should be displayed successfully
    Validate product details visible
