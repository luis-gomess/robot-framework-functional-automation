*** Settings ***
Resource    ../../../config/settings.resource

*** Variables ***

&{HEADER}
...    LOGGED_USER=css:a[href="/delete_account"] > i.fa-user
...    LOGGED_USER_LINK=xpath=//a[contains(.,'Logged in as')]
...    LOGOUT=css:a[href="/logout"]
...    DELETE_ACCOUNT=css:a[href="/delete_account"]

&{ACCOUNT}
...    TITLE_MR=id:id_gender1
...    PASSWORD=css:input[data-qa="password"]

...    DAY=css:select[data-qa="days"]
...    MONTH=css:select[data-qa="months"]
...    YEAR=css:select[data-qa="years"]

...    NEWSLETTER=id:newsletter
...    OFFERS=id:optin

...    FIRST_NAME=css:input[data-qa="first_name"]
...    LAST_NAME=css:input[data-qa="last_name"]
...    COMPANY=css:input[data-qa="company"]
...    ADDRESS1=css:input[data-qa="address"]
...    ADDRESS2=css:input[data-qa="address2"]

...    COUNTRY=css:select[data-qa="country"]

...    STATE=css:input[data-qa="state"]
...    CITY=css:input[data-qa="city"]
...    ZIPCODE=css:input[data-qa="zipcode"]
...    MOBILE=css:input[data-qa="mobile_number"]

...    CREATE_BUTTON=css:button[data-qa="create-account"]

...    CONTINUE_BUTTON=css:a[data-qa="continue-button"]
