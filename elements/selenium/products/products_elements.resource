*** Settings ***
Resource    ../../../config/settings.resource

*** Variables ***

&{products}
...    menu_link=css:a[href="/products"]
...    page_title=xpath=//h2[normalize-space(.)='All Products']
...    product_card=css:.features_items .product-image-wrapper
...    first_view_product=xpath=(//div[contains(@class,'features_items')]//div[contains(@class,'product-image-wrapper')]//div[contains(@class,'choose')]//a[starts-with(@href,'/product_details/') and normalize-space(.)='View Product'])[1]
...    details_container=css:.product-information
...    product_name=css:.product-information h2
...    category=xpath=//div[contains(@class,'product-information')]/p[starts-with(normalize-space(.),'Category:')]
...    price=css:.product-information > span > span
...    availability=xpath=//div[contains(@class,'product-information')]/p[starts-with(normalize-space(.),'Availability:')]
...    condition=xpath=//div[contains(@class,'product-information')]/p[starts-with(normalize-space(.),'Condition:')]
...    brand=xpath=//div[contains(@class,'product-information')]/p[starts-with(normalize-space(.),'Brand:')]