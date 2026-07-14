*** Settings ***
Resource    ../../elements/selenium/main_elements.resource
Resource    ../../variables/products_variables.resource

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

Search products by name
    [Arguments]    ${search_term}
    Wait Until Element Is Visible    ${products.search_input}    ${timeout}
    Input Text    ${products.search_input}    ${search_term}
    Wait Until Element Is Visible    ${products.search_button}    ${timeout}
    Wait Until Element Is Enabled    ${products.search_button}    ${timeout}
    Scroll Element Into View    ${products.search_button}
    Click Button    ${products.search_button}

Validate searched products for term
    [Arguments]    ${search_term}
    Wait Until Element Is Visible    ${products.searched_products_title}    ${timeout}
    Wait Until Element Is Visible    ${products.searched_product_names}    ${timeout}

    ${product_elements}=    Get WebElements    ${products.searched_product_names}
    ${products_count}=    Get Length    ${product_elements}
    Should Be True    ${products_count} > 0

    ${normalized_search_term}=    Convert To Lower Case    ${search_term}

    FOR    ${product_element}    IN    @{product_elements}
        Element Should Be Visible    ${product_element}
        ${product_name}=    Get Text    ${product_element}
        Should Not Be Empty    ${product_name}
        ${normalized_product_name}=    Convert To Lower Case    ${product_name}
        Should Contain    ${normalized_product_name}    ${normalized_search_term}
    END
