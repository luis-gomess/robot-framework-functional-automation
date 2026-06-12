*** Settings ***
Library    SeleniumLibrary
Library    RequestsLibrary
Library    Collections
Library    String

*** Variables ***
${timeout}    5

&{geral}
...     url=https://automationexercise.com/
...     browser=chrome

&{personal}
...    user=example@example.com
...    password=example&1234