*** Settings ***
Library    SeleniumLibrary
Library    OperatingSystem
Library    Collections
Library    BuiltIn

Resource    Variables.resource

*** Keywords ***   
Open Web Swag Labs
    Open Browser    ${URL}    ${BROWSER}

Test Login From JSON
    [Arguments]    ${file_path}
    ${content}=    Get File    ${file_path}
    ${json}=    Evaluate    json.loads('''${content}''')    modules=json
    RETURN    ${json}

Input User Password
    # Type text into the 'First Name' field
    Input Text    xpath=//input[@data-test="firstName"]    Testfirst
    # Type text into the 'Last Name' field
    Input Text    xpath=//input[@data-test="lastName"]    Testlast
    # Type text into the 'Zip/Postal Code' field
    Input Text    xpath=//input[@data-test="postalCode"]    451123
    Click Element    xpath=//input[@data-test="continue"]


    # เช็ค ไอเท็ม #
Search And Add To Cart
    [Arguments]    ${item}
    Wait Until Page Contains Element    xpath=//div[contains(@class, 'inventory_item_name') and contains(text(), '${item}')]    5s
    Click Element    xpath=//div[contains(text(), '${item}')]/ancestor::div[contains(@class, 'inventory_item_description')]//button[contains(text(), 'Add to cart')]
    Log    '${item} added to cart'    level=INFO

