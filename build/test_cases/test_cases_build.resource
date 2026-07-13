*** Settings ***
Resource    ../../steps/main_steps.resource

*** Keywords ***
the home page is visible
    Validate home page visible

the user accesses the test cases screen
    Access test cases screen

the test cases page should be visible
    Validate test cases page visible
