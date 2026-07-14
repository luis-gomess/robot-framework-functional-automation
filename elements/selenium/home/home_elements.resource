*** Settings ***
Resource    ../../../config/settings.resource

*** Variables ***

&{home_page}
...    slider=css:#slider-carousel
...    subscription_title=xpath=//footer[@id='footer']//h2[normalize-space(.)='Subscription']
...    subscription_email=css:input#susbscribe_email
...    subscription_button=css:button#subscribe
...    subscription_success_message=css:div#success-subscribe
