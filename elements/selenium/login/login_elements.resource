*** Settings ***
Resource    ../../../config/settings.resource

*** Variables ***

&{HOME}
...    SIGNUP_LOGIN=css:a[href="/login"]

&{LOGIN}
...    EMAIL=css:input[data-qa="login-email"]
...    PASSWORD=css:input[data-qa="login-password"]
...    BUTTON=css:button[data-qa="login-button"]
...    INVALID_CREDENTIALS=xpath=//p[contains(.,'Your email or password is incorrect!')]

&{SIGNUP}
...    NAME=css:input[data-qa="signup-name"]
...    EMAIL=css:input[data-qa="signup-email"]
...    BUTTON=css:button[data-qa="signup-button"]
...    EMAIL_ALREADY_EXISTS=xpath=//p[contains(.,'Email Address already exist!')]
