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





### เช็ค ไอเท็ม ###
Get Item Xpath1
    [Arguments]    ${item_name1}    
    ${xpath1}=    Set Variable    //button[@id="add-to-cart-sauce-labs-backpack"]
    Wait Until Element Is Visible    ${xpath1}    timeout=10s
    RETURN    ${xpath1}

Get Item Xpath2
    [Arguments]    ${item_name2}    
    ${xpath2}=    Set Variable    //button[@id="add-to-cart-sauce-labs-bike-light"]
    Wait Until Element Is Visible    ${xpath2}    timeout=10s
    RETURN    ${xpath2}

Get Item Xpath3
    [Arguments]    ${item_name3}    
    ${xpath3}=    Set Variable    //button[@id="add-to-cart-sauce-labs-bolt-t-shirt"]
    Wait Until Element Is Visible    ${xpath3}    timeout=10s
    RETURN    ${xpath3}

Get Item Xpath4
    [Arguments]    ${item_name4}    
    ${xpath4}=    Set Variable    //button[@id="add-to-cart-test.allthethings()-t-shirt-(red)"]
    Wait Until Element Is Visible    ${xpath4}    timeout=10s
    RETURN    ${xpath4}

Check Item Match1
    [Arguments]    ${item_name1}    ${xpath1}
    ${found_item1}=    Get Text    ${xpath1}
    Log    Found item: ${found_item1}

    IF    '${found_item1}' == '${item_name1}'
        Log    Item '${item_name1}' matched with found item: '${found_item1}'
    ELSE
        Log    Item '${item_name1}' does not match with found item: '${found_item1}'
    END
Check Item Match2
    [Arguments]    ${item_name2}    ${xpath2}
    ${found_item2}=    Get Text    ${xpath2}
    Log    Found item: ${found_item2}

    IF    '${found_item2}' == '${item_name2}'
        Log    Item '${item_name2}' matched with found item: '${found_item2}'
    ELSE
        Log    Item '${item_name2}' does not match with found item: '${found_item2}'
    END

Check Item Match3
    [Arguments]    ${item_name3}    ${xpath3}
    ${found_item3}=    Get Text    ${xpath3}
    Log    Found item: ${found_item3}

    IF    '${found_item3}' == '${item_name3}'
        Log    Item '${item_name3}' matched with found item: '${found_item3}'
    ELSE
        Log    Item '${item_name3}' does not match with found item: '${found_item3}'
    END

Check Item Match4
    [Arguments]    ${item_name4}    ${xpath4}
    ${found_item4}=    Get Text    ${xpath4}
    Log    Found item: ${found_item4}

    IF    '${found_item4}' == '${item_name4}'
        Log    Item '${item_name4}' matched with found item: '${found_item4}'
    ELSE
        Log    Item '${item_name4}' does not match with found item: '${found_item4}'
    END

Add to cart Sauce Labs Backpack
    FOR    ${item}    IN    ${ITEMS1}
        ${xpath1}=    Get Item Xpath1    ${item}
        Check Item Match1    ${item}    ${xpath1}  # ตรวจสอบว่าชื่อไอเท็มตรงกับที่พบหรือไม่
        Run Keyword And Ignore Error    Click Button    ${xpath1}  # คลิกที่ปุ่ม Add to cart
    END
Add to cart Sauce Labs Bike Light
    FOR    ${item}    IN    ${ITEMS2}
        ${xpath2}=    Get Item Xpath2    ${item}
        Check Item Match2    ${item}    ${xpath2}  # ตรวจสอบว่าชื่อไอเท็มตรงกับที่พบหรือไม่
        Run Keyword And Ignore Error    Click Button    ${xpath2}  # คลิกที่ปุ่ม Add to cart
    END
Sauce Labs Bolt T-Shirt
    FOR    ${item}    IN    ${ITEMS3}
        ${xpath3}=    Get Item Xpath3    ${item}
        Check Item Match3    ${item}    ${xpath3}  # ตรวจสอบว่าชื่อไอเท็มตรงกับที่พบหรือไม่
        Run Keyword And Ignore Error    Click Button    ${xpath3}  # คลิกที่ปุ่ม Add to cart
    END
Test.allTheThings() T-Shirt (Red)
    FOR    ${item}    IN    ${ITEMS4}
        ${xpath4}=    Get Item Xpath4    ${item}
        Check Item Match4    ${item}    ${xpath4}  # ตรวจสอบว่าชื่อไอเท็มตรงกับที่พบหรือไม่
        Run Keyword And Ignore Error    Click Button    ${xpath4}  # คลิกที่ปุ่ม Add to cart
    END

