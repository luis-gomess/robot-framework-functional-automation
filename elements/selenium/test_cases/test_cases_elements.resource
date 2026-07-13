*** Settings ***
Resource    ../../../config/settings.resource

*** Variables ***

&{test_cases}
...    menu_link=css:a[href="/test_cases"]
...    title=xpath=//h2[normalize-space(.)="Test Cases"]
