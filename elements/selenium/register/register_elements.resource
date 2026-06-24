*** Settings ***
Resource    ../../../config/settings.resource

*** Variables ***

&{header}
...    logged_user=css:a[href="/delete_account"] > i.fa-user
...    logged_user_link=xpath=//a[contains(.,'Logged in as')]
...    logout=css:a[href="/logout"]
...    delete_account=css:a[href="/delete_account"]

&{account}
...    title_mr=id:id_gender1
...    password=css:input[data-qa="password"]

...    day=css:select[data-qa="days"]
...    month=css:select[data-qa="months"]
...    year=css:select[data-qa="years"]

...    newsletter=id:newsletter
...    offers=id:optin

...    first_name=css:input[data-qa="first_name"]
...    last_name=css:input[data-qa="last_name"]
...    company=css:input[data-qa="company"]
...    address1=css:input[data-qa="address"]
...    address2=css:input[data-qa="address2"]

...    country=css:select[data-qa="country"]

...    state=css:input[data-qa="state"]
...    city=css:input[data-qa="city"]
...    zipcode=css:input[data-qa="zipcode"]
...    mobile=css:input[data-qa="mobile_number"]

...    create_button=css:button[data-qa="create-account"]

...    continue_button=css:a[data-qa="continue-button"]
...    deleted_title=css:h2[data-qa="account-deleted"]
