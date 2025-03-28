*** Settings ***
Library    SeleniumLibrary
Library    OperatingSystem
Library    Collections
Library    BuiltIn
Library    JSONLibrary

Suite Teardown    Close Browser

Resource    ..//resources/Keywords.resource

*** Variables ***
${ITEM_1}    Sauce Labs Backpack
${ITEM_2}    Sauce Labs Bike Light
${ITEM_3}    Sauce Labs Bolt T-Shirt
${ITEM_4}    Test.allTheThings() T-Shirt (Red)


*** Test Cases ***
Test Add To Cart
    ${data}=    Load JSON From File    D:/my-robot/data/Addass.json
    ${user}=    Get From Dictionary    ${data}    users    {}
    ${first_user}=    Get From Dictionary    ${user[0]}    username    "default"  # ใช้คีย์ "username" จากตัวแปรแรกใน users
    ${password}=    Get From Dictionary    ${user[0]}    password    "default"  # ใช้คีย์ "password" จากตัวแปรแรกใน users
    Log    ${first_user}  # ดูข้อมูล username
    Log    ${password}    # ดูข้อมูล password
    Open Web Swag Labs
    Input Text    ${USERNAME_XPATH}    ${first_user}
    Input Text    ${PASSWORD_XPATH}    ${password}
    Sleep    1s
    Click Button    ${LOGIN_BUTTON_XPATH}


    Search And Add To Cart    ${ITEM_1}
    Search And Add To Cart    ${ITEM_2}
    Search And Add To Cart    ${ITEM_3}
    Search And Add To Cart    ${ITEM_4}
    
    SeleniumLibrary.Click Element    ${shopping_cart} 
    Click Button    ${removebackpack}
    Click Button    ${checkout}
    Sleep    1s

*** Keywords ***
Search And Add To Cart
    [Arguments]    ${item}
    Wait Until Page Contains Element    xpath=//div[contains(@class, 'inventory_item_name') and contains(text(), '${item}')]    5s
    Click Element    xpath=//div[contains(text(), '${item}')]/ancestor::div[contains(@class, 'inventory_item_description')]//button[contains(text(), 'Add to cart')]
    Log    '${item} added to cart'    level=INFO

