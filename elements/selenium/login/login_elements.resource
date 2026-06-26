*** Settings ***
Resource    ../../../config/settings.resource

*** Variables ***

&{home}
...    signup_login=css:a[href="/login"]

&{login}
...    email=css:input[data-qa="login-email"]
...    password=css:input[data-qa="login-password"]
...    button=css:button[data-qa="login-button"]
...    invalid_credentials=xpath=//p[normalize-space(.)='Your email or password is incorrect!']

&{signup}
...    name=css:input[data-qa="signup-name"]
...    email=css:input[data-qa="signup-email"]
...    button=css:button[data-qa="signup-button"]
...    email_already_exists=xpath=//p[normalize-space(.)='Email Address already exist!']
