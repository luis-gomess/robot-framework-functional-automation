*** Settings ***
Resource    ../../elements/selenium/main_elements.resource

*** Keywords ***
Access products screen
    Wait Until Element Is Visible    ${products.menu_link}    ${timeout}
    Click Element    ${products.menu_link}

Validate all products page visible
    Wait Until Element Is Visible    ${products.page_title}    ${timeout}

Validate products list visible
    Wait Until Element Is Visible    ${products.product_card}    ${timeout}
    ${products_count}=    Get Element Count    ${products.product_card}
    Should Be True    ${products_count} > 0

Open first product details
    Wait Until Element Is Visible    ${products.first_view_product}    ${timeout}
    Scroll Element Into View    ${products.first_view_product}
    Wait Until Element Is Visible    ${products.first_view_product}    ${timeout}
    Click Element    ${products.first_view_product}

Validate product details visible
    Wait Until Element Is Visible    ${products.details_container}    ${timeout}
    Wait Until Element Is Visible    ${products.product_name}    ${timeout}
    ${product_name}=    Get Text    ${products.product_name}
    Should Not Be Empty    ${product_name}
    Wait Until Element Is Visible    ${products.category}    ${timeout}
    ${category}=    Get Text    ${products.category}
    Should Contain    ${category}    Category:
    Should Not Be Empty    ${category}
    Wait Until Element Is Visible    ${products.price}    ${timeout}
    ${price}=    Get Text    ${products.price}
    Should Not Be Empty    ${price}
    Wait Until Element Is Visible    ${products.availability}    ${timeout}
    ${availability}=    Get Text    ${products.availability}
    Should Contain    ${availability}    Availability:
    Should Not Be Empty    ${availability}
    Wait Until Element Is Visible    ${products.condition}    ${timeout}
    ${condition}=    Get Text    ${products.condition}
    Should Contain    ${condition}    Condition:
    Should Not Be Empty    ${condition}
    Wait Until Element Is Visible    ${products.brand}    ${timeout}
    ${brand}=    Get Text    ${products.brand}
    Should Contain    ${brand}    Brand:
    Should Not Be Empty    ${brand}
