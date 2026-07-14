*** Settings ***
Resource    ../../../config/settings.resource

*** Variables ***

&{contact_us}
...    menu_link=css:a[href="/contact_us"]
...    title=xpath://h2[normalize-space(.)="Get In Touch"]
...    name=css:input[data-qa="name"]
...    email=css:input[data-qa="email"]
...    subject=css:input[data-qa="subject"]
...    message=css:textarea[data-qa="message"]
...    upload=css:input[name="upload_file"]
...    submit=css:input[data-qa="submit-button"]
...    success_message=xpath://div[contains(@class,"alert-success") and normalize-space(.)="Success! Your details have been submitted successfully."]
...    home_button=css:#form-section a[href="/"]
