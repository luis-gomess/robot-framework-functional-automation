*** Settings ***
Resource    ../config/settings.resource

*** Keywords ***
Start Test
    Open Browser    ${geral.url}    ${geral.browser}
    Maximize Browser Window

Finish Test
    Close All Browsers
