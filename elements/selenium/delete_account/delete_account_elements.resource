*** Settings ***
Resource    ../../../config/settings.resource

*** Variables ***

&{delete_account}
...    button=xpath=//a[@href='/delete_account' and contains(normalize-space(.),'Delete Account')]
...    deleted_title=css:h2[data-qa="account-deleted"]
