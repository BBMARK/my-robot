*** Settings ***
Library    SeleniumLibrary
Library    OperatingSystem
Library    Collections
Library    BuiltIn
Library    JSONLibrary

Suite Teardown    Close Browser

Resource    ..//resources/Keywords.resource

*** Test Cases ***
Test Login User 1 From JSON standard_user
    [Documentation]    ทดสอบการล็อกอินด้วยข้อมูลจาก JSON สำหรับผู้ใช้ที่ 1
    ${data}=    Load JSON From File    D:/AutomatedDriver/data/Addass.json
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
    Add to cart Sauce Labs Backpack
    Add to cart Sauce Labs Bike Light
    Sauce Labs Bolt T-Shirt
    Test.allTheThings() T-Shirt (Red)
    SeleniumLibrary.Click Element    ${shopping_cart} 
    Click Button    ${removebackpack}
    Click Button    ${checkout}
    
    SeleniumLibrary.Wait Until Element Contains  ${titleCheckout}  Checkout: Your Information

    Input User Password
    
    # Get Item 1 - Sauce Labs Bike Light
    ${item1_name}=    Get Text    ${Item1name}
    Should Be Equal As Strings    ${item1_name}    Sauce Labs Bike Light
    ${item1_price}=    Get Text    ${Item1price}
    ${item1_price}=    Evaluate    float("${item1_price.replace('$', '')}")    # แปลงราคาจาก "$9.99" เป็น 9.99
    Should Be Equal As Numbers    ${item1_price}    9.99

    # Get Item 2 - Sauce Labs Bolt T-Shirt
    ${item2_name}=    Get Text    ${Item2name}
    Should Be Equal As Strings    ${item2_name}    Sauce Labs Bolt T-Shirt
    ${item2_price}=    Get Text    ${Item2price}
    ${item2_price}=    Evaluate    float("${item2_price.replace('$', '')}")    # แปลงราคาจาก "$15.99" เป็น 15.99
    Should Be Equal As Numbers    ${item2_price}    15.99

    # Get Item 3 - Test.allTheThings() T-Shirt (Red)
    ${item3_name}=    Get Text    ${Item3name}
    Should Be Equal As Strings    ${item3_name}    Test.allTheThings() T-Shirt (Red)
    ${item3_price}=    Get Text    ${Item3price}
    ${item3_price}=    Evaluate    float("${item3_price.replace('$', '')}")    # แปลงราคาจาก "$15.99" เป็น 15.99
    Should Be Equal As Numbers    ${item3_price}    15.99

    #ตรวจสอบราคาสุทธิ
    ${sum}=    Evaluate    ${item1_price} + ${item2_price} + ${item3_price}
    #Log    Total sum: ${sum}
    # ดึงข้อมูล
    ${subtotal_element}=    Get Text    xpath=//div[@class='summary_subtotal_label' and @data-test='subtotal-label']
    ${subtotal}=    Evaluate    float("${subtotal_element.replace('Item total: $', '')}")
    # ตรวจสอบราคาหน้าเว็บให้ตรงกัน
    Should Be Equal As Numbers    ${sum}    ${subtotal}
    #Log    ${subtotal}
    #Log    ${sum}

    # คำนวณและปัดเศษค่าภาษี
    ${tax} =    Evaluate    ${sum} * ${TAX_RATE}
    ${tax_rounded} =    Evaluate    round(${tax}, 2)
    # คำนวณราคาสุทธิรวมภาษี
    ${total_price} =    Evaluate    ${sum} + ${tax_rounded}
    #Log    Tax: ${tax_rounded}, Total Price with Tax: ${total_price}
    # ดึงค่าภาษีจากหน้าเว็บ
    ${tax_from_page}=    Get Text    xpath=//div[@data-test='tax-label']
    # แปลงข้อความภาษีให้เป็นตัวเลข
    ${tax_value}=    Evaluate    float("${tax_from_page.replace('Tax: $', '')}")
    # ตรวจสอบว่าค่าภาษีจากหน้าเว็บตรงกับค่าภาษีที่ปัดเศษแล้ว
    Should Be Equal As Numbers    ${tax_value}    ${tax_rounded}
    # แสดงค่าภาษี
    #Log    Tax from page: ${tax_value}, Calculated tax: ${tax_rounded}

    # คำนวณราคารวมสุทธิ
    ${total_price} =    Evaluate    ${sum} + ${tax_value}
    # ดึงราคาสุทธิจากหน้าเว็บ
    ${total_from_page}=    Get Text    xpath=//div[@data-test='total-label']
    ${total_value}=    Evaluate    float("${total_from_page.replace('Total: $', '')}")
    # ตรวจสอบว่าราคาสุทธิที่คำนวณได้ตรงกับค่าที่แสดงบนเว็บ
    Should Be Equal As Numbers    ${total_value}    ${total_price}
    # แสดงค่าที่ใช้ตรวจสอบใน Log
    #Log    Calculated Total: ${total_price}, Total from page: ${total_value}
    
    Click Element    ${finish}
    sleep  1s
    Element Should Contain    xpath=//h2[@data-test="complete-header"]    Thank you for your order!
    Click Element    xpath=//button[@id='back-to-products']
    sleep  1s
    Element Should Contain    ${LOGIN_LOGO_XPATH}    Swag Labs
   
Test Login User 2 From JSON locked_out_user
    [Documentation]    ทดสอบการล็อกอินด้วยข้อมูลจาก JSON สำหรับผู้ใช้ที่ 2
    ${data}=    Load JSON From File    D:/AutomatedDriver/data/Addass.json
    ${user}=    Get From Dictionary    ${data}    users    {}
    ${first_user}=    Get From Dictionary    ${user[1]}    username    "default"  # ใช้คีย์ "username" จากตัวแปรแรกใน users
    ${password}=    Get From Dictionary    ${user[1]}    password    "default"  # ใช้คีย์ "password" จากตัวแปรแรกใน users
    Log    ${first_user}  # ดูข้อมูล username
    Log    ${password}    # ดูข้อมูล password
    Open Web Swag Labs
    Input Text    ${USERNAME_XPATH}    ${first_user}
    Input Text    ${PASSWORD_XPATH}    ${password}
    Sleep    1s
    Click Button    ${LOGIN_BUTTON_XPATH}
    Wait Until Element Is Visible    ${ERROR_MESSAGE_XPATH}    timeout=1s
    Element Should Contain    ${ERROR_MESSAGE_XPATH}    Epic sadface: Sorry, this user has been locked out.
    
Test Login User 3 From JSON problem_user
    [Documentation]    ทดสอบการล็อกอินด้วยข้อมูลจาก JSON สำหรับผู้ใช้ที่ 3 ใช้การทดสอบเดียวกันกับ Test Login User 1 From JSON standard_user
    ${data}=    Load JSON From File    D:/AutomatedDriver/data/Addass.json
    ${user}=    Get From Dictionary    ${data}    users    {}
    ${first_user}=    Get From Dictionary    ${user[2]}    username    "default"  # ใช้คีย์ "username" จากตัวแปรแรกใน users
    ${password}=    Get From Dictionary    ${user[2]}    password    "default"  # ใช้คีย์ "password" จากตัวแปรแรกใน users
    #Log    ${first_user}  # ดูข้อมูล username
    #Log    ${password}    # ดูข้อมูล password
    Open Web Swag Labs
    Input Text    ${USERNAME_XPATH}    ${first_user}
    Input Text    ${PASSWORD_XPATH}    ${password}
    Sleep    1s
    Click Button    ${LOGIN_BUTTON_XPATH}
    Add to cart Sauce Labs Backpack
    Add to cart Sauce Labs Bike Light
    Sauce Labs Bolt T-Shirt
    Test.allTheThings() T-Shirt (Red)
    SeleniumLibrary.Click Element    ${shopping_cart} 
    Click Button    ${removebackpack}
    Click Button    ${checkout}
    
    SeleniumLibrary.Wait Until Element Contains  ${titleCheckout}  Checkout: Your Information

    Input User Password
    
    # Get Item 1 - Sauce Labs Bike Light
    ${item1_name}=    Get Text    ${Item1name}
    Should Be Equal As Strings    ${item1_name}    Sauce Labs Bike Light
    ${item1_price}=    Get Text    ${Item1price}
    ${item1_price}=    Evaluate    float("${item1_price.replace('$', '')}")    # แปลงราคาจาก "$9.99" เป็น 9.99
    Should Be Equal As Numbers    ${item1_price}    9.99

    # Get Item 2 - Sauce Labs Bolt T-Shirt
    ${item2_name}=    Get Text    ${Item2name}
    Should Be Equal As Strings    ${item2_name}    Sauce Labs Bolt T-Shirt
    ${item2_price}=    Get Text    ${Item2price}
    ${item2_price}=    Evaluate    float("${item2_price.replace('$', '')}")    # แปลงราคาจาก "$15.99" เป็น 15.99
    Should Be Equal As Numbers    ${item2_price}    15.99

    # Get Item 3 - Test.allTheThings() T-Shirt (Red)
    ${item3_name}=    Get Text    ${Item3name}
    Should Be Equal As Strings    ${item3_name}    Test.allTheThings() T-Shirt (Red)
    ${item3_price}=    Get Text    ${Item3price}
    ${item3_price}=    Evaluate    float("${item3_price.replace('$', '')}")    # แปลงราคาจาก "$15.99" เป็น 15.99
    Should Be Equal As Numbers    ${item3_price}    15.99

    #ตรวจสอบราคาสุทธิ
    ${sum}=    Evaluate    ${item1_price} + ${item2_price} + ${item3_price}
    #Log    Total sum: ${sum}
    # ดึงข้อมูล
    ${subtotal_element}=    Get Text    xpath=//div[@class='summary_subtotal_label' and @data-test='subtotal-label']
    ${subtotal}=    Evaluate    float("${subtotal_element.replace('Item total: $', '')}")
    # ตรวจสอบราคาหน้าเว็บให้ตรงกัน
    Should Be Equal As Numbers    ${sum}    ${subtotal}
    #Log    ${subtotal}
    #Log    ${sum}

    # คำนวณและปัดเศษค่าภาษี
    ${tax} =    Evaluate    ${sum} * ${TAX_RATE}
    ${tax_rounded} =    Evaluate    round(${tax}, 2)
    # คำนวณราคาสุทธิรวมภาษี
    ${total_price} =    Evaluate    ${sum} + ${tax_rounded}
    #Log    Tax: ${tax_rounded}, Total Price with Tax: ${total_price}
    # ดึงค่าภาษีจากหน้าเว็บ
    ${tax_from_page}=    Get Text    xpath=//div[@data-test='tax-label']
    # แปลงข้อความภาษีให้เป็นตัวเลข
    ${tax_value}=    Evaluate    float("${tax_from_page.replace('Tax: $', '')}")
    # ตรวจสอบว่าค่าภาษีจากหน้าเว็บตรงกับค่าภาษีที่ปัดเศษแล้ว
    Should Be Equal As Numbers    ${tax_value}    ${tax_rounded}
    # แสดงค่าภาษี
    #Log    Tax from page: ${tax_value}, Calculated tax: ${tax_rounded}

    # คำนวณราคารวมสุทธิ
    ${total_price} =    Evaluate    ${sum} + ${tax_value}
    # ดึงราคาสุทธิจากหน้าเว็บ
    ${total_from_page}=    Get Text    xpath=//div[@data-test='total-label']
    ${total_value}=    Evaluate    float("${total_from_page.replace('Total: $', '')}")
    # ตรวจสอบว่าราคาสุทธิที่คำนวณได้ตรงกับค่าที่แสดงบนเว็บ
    Should Be Equal As Numbers    ${total_value}    ${total_price}
    # แสดงค่าที่ใช้ตรวจสอบใน Log
    #Log    Calculated Total: ${total_price}, Total from page: ${total_value}
    
    Click Element    ${finish}
    sleep  1s
    Element Should Contain    xpath=//h2[@data-test="complete-header"]    Thank you for your order!
    Click Element    id=back-to-products
    sleep  1s
    Element Should Contain    ${LOGIN_LOGO_XPATH}    Swag Labs
    
Test Login User 4 From JSON performance_glitch_user
    [Documentation]    ทดสอบการล็อกอินด้วยข้อมูลจาก JSON สำหรับผู้ใช้ที่ 4 ใช้การทดสอบเดียวกันกับ Test Login User 1 From JSON standard_user
    ${data}=    Load JSON From File    D:/AutomatedDriver/data/Addass.json
    ${user}=    Get From Dictionary    ${data}    users    {}
    ${first_user}=    Get From Dictionary    ${user[3]}    username    "default"  # ใช้คีย์ "username" จากตัวแปรแรกใน users
    ${password}=    Get From Dictionary    ${user[3]}    password    "default"  # ใช้คีย์ "password" จากตัวแปรแรกใน users
    #Log    ${first_user}  # ดูข้อมูล username
    #Log    ${password}    # ดูข้อมูล password
    Open Web Swag Labs
    Input Text    ${USERNAME_XPATH}    ${first_user}
    Input Text    ${PASSWORD_XPATH}    ${password}
    Sleep    1s
    Click Button    ${LOGIN_BUTTON_XPATH}
    Add to cart Sauce Labs Backpack
    Add to cart Sauce Labs Bike Light
    Sauce Labs Bolt T-Shirt
    Test.allTheThings() T-Shirt (Red)
    SeleniumLibrary.Click Element    ${shopping_cart} 
    Click Button    ${removebackpack}
    Click Button    ${checkout}
    
    SeleniumLibrary.Wait Until Element Contains  ${titleCheckout}  Checkout: Your Information

    Input User Password
    
    # Get Item 1 - Sauce Labs Bike Light
    ${item1_name}=    Get Text    ${Item1name}
    Should Be Equal As Strings    ${item1_name}    Sauce Labs Bike Light
    ${item1_price}=    Get Text    ${Item1price}
    ${item1_price}=    Evaluate    float("${item1_price.replace('$', '')}")    # แปลงราคาจาก "$9.99" เป็น 9.99
    Should Be Equal As Numbers    ${item1_price}    9.99

    # Get Item 2 - Sauce Labs Bolt T-Shirt
    ${item2_name}=    Get Text    ${Item2name}
    Should Be Equal As Strings    ${item2_name}    Sauce Labs Bolt T-Shirt
    ${item2_price}=    Get Text    ${Item2price}
    ${item2_price}=    Evaluate    float("${item2_price.replace('$', '')}")    # แปลงราคาจาก "$15.99" เป็น 15.99
    Should Be Equal As Numbers    ${item2_price}    15.99

    # Get Item 3 - Test.allTheThings() T-Shirt (Red)
    ${item3_name}=    Get Text    ${Item3name}
    Should Be Equal As Strings    ${item3_name}    Test.allTheThings() T-Shirt (Red)
    ${item3_price}=    Get Text    ${Item3price}
    ${item3_price}=    Evaluate    float("${item3_price.replace('$', '')}")    # แปลงราคาจาก "$15.99" เป็น 15.99
    Should Be Equal As Numbers    ${item3_price}    15.99

    #ตรวจสอบราคาสุทธิ
    ${sum}=    Evaluate    ${item1_price} + ${item2_price} + ${item3_price}
    #Log    Total sum: ${sum}
    # ดึงข้อมูล
    ${subtotal_element}=    Get Text    xpath=//div[@class='summary_subtotal_label' and @data-test='subtotal-label']
    ${subtotal}=    Evaluate    float("${subtotal_element.replace('Item total: $', '')}")
    # ตรวจสอบราคาหน้าเว็บให้ตรงกัน
    Should Be Equal As Numbers    ${sum}    ${subtotal}
    #Log    ${subtotal}
    #Log    ${sum}

    # คำนวณและปัดเศษค่าภาษี
    ${tax} =    Evaluate    ${sum} * ${TAX_RATE}
    ${tax_rounded} =    Evaluate    round(${tax}, 2)
    # คำนวณราคาสุทธิรวมภาษี
    ${total_price} =    Evaluate    ${sum} + ${tax_rounded}
    #Log    Tax: ${tax_rounded}, Total Price with Tax: ${total_price}
    # ดึงค่าภาษีจากหน้าเว็บ
    ${tax_from_page}=    Get Text    xpath=//div[@data-test='tax-label']
    # แปลงข้อความภาษีให้เป็นตัวเลข
    ${tax_value}=    Evaluate    float("${tax_from_page.replace('Tax: $', '')}")
    # ตรวจสอบว่าค่าภาษีจากหน้าเว็บตรงกับค่าภาษีที่ปัดเศษแล้ว
    Should Be Equal As Numbers    ${tax_value}    ${tax_rounded}
    # แสดงค่าภาษี
    #Log    Tax from page: ${tax_value}, Calculated tax: ${tax_rounded}

    # คำนวณราคารวมสุทธิ
    ${total_price} =    Evaluate    ${sum} + ${tax_value}
    # ดึงราคาสุทธิจากหน้าเว็บ
    ${total_from_page}=    Get Text    xpath=//div[@data-test='total-label']
    ${total_value}=    Evaluate    float("${total_from_page.replace('Total: $', '')}")
    # ตรวจสอบว่าราคาสุทธิที่คำนวณได้ตรงกับค่าที่แสดงบนเว็บ
    Should Be Equal As Numbers    ${total_value}    ${total_price}
    # แสดงค่าที่ใช้ตรวจสอบใน Log
    #Log    Calculated Total: ${total_price}, Total from page: ${total_value}
    
    Click Element    ${finish}
    sleep  1s
    Element Should Contain    xpath=//h2[@data-test="complete-header"]    Thank you for your order!
    Click Element    id=back-to-products
    sleep  1s
    Element Should Contain    ${LOGIN_LOGO_XPATH}    Swag Labs

Test Login User 5 From JSON error_user
    [Documentation]    ทดสอบการล็อกอินด้วยข้อมูลจาก JSON สำหรับผู้ใช้ที่ 5 ใช้การทดสอบเดียวกันกับ Test Login User 1 From JSON standard_user
    ${data}=    Load JSON From File    D:/AutomatedDriver/data/Addass.json
    ${user}=    Get From Dictionary    ${data}    users    {}
    ${first_user}=    Get From Dictionary    ${user[4]}    username    "default"  # ใช้คีย์ "username" จากตัวแปรแรกใน users
    ${password}=    Get From Dictionary    ${user[4]}    password    "default"  # ใช้คีย์ "password" จากตัวแปรแรกใน users
    #Log    ${first_user}  # ดูข้อมูล username
    #Log    ${password}    # ดูข้อมูล password
    Open Web Swag Labs
    Input Text    ${USERNAME_XPATH}    ${first_user}
    Input Text    ${PASSWORD_XPATH}    ${password}
    Sleep    1s
    Click Button    ${LOGIN_BUTTON_XPATH}
    Add to cart Sauce Labs Backpack
    Add to cart Sauce Labs Bike Light
    Sauce Labs Bolt T-Shirt
    Test.allTheThings() T-Shirt (Red)
    SeleniumLibrary.Click Element    ${shopping_cart} 
    Click Button    ${removebackpack}
    Click Button    ${checkout}
    
    SeleniumLibrary.Wait Until Element Contains  ${titleCheckout}  Checkout: Your Information

    Input User Password
    
    # Get Item 1 - Sauce Labs Bike Light
    ${item1_name}=    Get Text    ${Item1name}
    Should Be Equal As Strings    ${item1_name}    Sauce Labs Bike Light
    ${item1_price}=    Get Text    ${Item1price}
    ${item1_price}=    Evaluate    float("${item1_price.replace('$', '')}")    # แปลงราคาจาก "$9.99" เป็น 9.99
    Should Be Equal As Numbers    ${item1_price}    9.99

    # Get Item 2 - Sauce Labs Bolt T-Shirt
    ${item2_name}=    Get Text    ${Item2name}
    Should Be Equal As Strings    ${item2_name}    Sauce Labs Bolt T-Shirt
    ${item2_price}=    Get Text    ${Item2price}
    ${item2_price}=    Evaluate    float("${item2_price.replace('$', '')}")    # แปลงราคาจาก "$15.99" เป็น 15.99
    Should Be Equal As Numbers    ${item2_price}    15.99

    # Get Item 3 - Test.allTheThings() T-Shirt (Red)
    ${item3_name}=    Get Text    ${Item3name}
    Should Be Equal As Strings    ${item3_name}    Test.allTheThings() T-Shirt (Red)
    ${item3_price}=    Get Text    ${Item3price}
    ${item3_price}=    Evaluate    float("${item3_price.replace('$', '')}")    # แปลงราคาจาก "$15.99" เป็น 15.99
    Should Be Equal As Numbers    ${item3_price}    15.99

    #ตรวจสอบราคาสุทธิ
    ${sum}=    Evaluate    ${item1_price} + ${item2_price} + ${item3_price}
    #Log    Total sum: ${sum}
    # ดึงข้อมูล
    ${subtotal_element}=    Get Text    xpath=//div[@class='summary_subtotal_label' and @data-test='subtotal-label']
    ${subtotal}=    Evaluate    float("${subtotal_element.replace('Item total: $', '')}")
    # ตรวจสอบราคาหน้าเว็บให้ตรงกัน
    Should Be Equal As Numbers    ${sum}    ${subtotal}
    #Log    ${subtotal}
    #Log    ${sum}

    # คำนวณและปัดเศษค่าภาษี
    ${tax} =    Evaluate    ${sum} * ${TAX_RATE}
    ${tax_rounded} =    Evaluate    round(${tax}, 2)
    # คำนวณราคาสุทธิรวมภาษี
    ${total_price} =    Evaluate    ${sum} + ${tax_rounded}
    #Log    Tax: ${tax_rounded}, Total Price with Tax: ${total_price}
    # ดึงค่าภาษีจากหน้าเว็บ
    ${tax_from_page}=    Get Text    xpath=//div[@data-test='tax-label']
    # แปลงข้อความภาษีให้เป็นตัวเลข
    ${tax_value}=    Evaluate    float("${tax_from_page.replace('Tax: $', '')}")
    # ตรวจสอบว่าค่าภาษีจากหน้าเว็บตรงกับค่าภาษีที่ปัดเศษแล้ว
    Should Be Equal As Numbers    ${tax_value}    ${tax_rounded}
    # แสดงค่าภาษี
    #Log    Tax from page: ${tax_value}, Calculated tax: ${tax_rounded}

    # คำนวณราคารวมสุทธิ
    ${total_price} =    Evaluate    ${sum} + ${tax_value}
    # ดึงราคาสุทธิจากหน้าเว็บ
    ${total_from_page}=    Get Text    xpath=//div[@data-test='total-label']
    ${total_value}=    Evaluate    float("${total_from_page.replace('Total: $', '')}")
    # ตรวจสอบว่าราคาสุทธิที่คำนวณได้ตรงกับค่าที่แสดงบนเว็บ
    Should Be Equal As Numbers    ${total_value}    ${total_price}
    # แสดงค่าที่ใช้ตรวจสอบใน Log
    #Log    Calculated Total: ${total_price}, Total from page: ${total_value}
    
    Click Element    ${finish}
    sleep  1s
    Element Should Contain    xpath=//h2[@data-test="complete-header"]    Thank you for your order!
    Click Element    id=back-to-products
    sleep  1s
    Element Should Contain    ${LOGIN_LOGO_XPATH}    Swag Labs
    

Test Login User 6 From JSON visual_user
    [Documentation]    ทดสอบการล็อกอินด้วยข้อมูลจาก JSON สำหรับผู้ใช้ที่ 6 ใช้การทดสอบเดียวกันกับ Test Login User 1 From JSON standard_user
    ${data}=    Load JSON From File    D:/AutomatedDriver/data/Addass.json
    ${user}=    Get From Dictionary    ${data}    users    {}
    ${first_user}=    Get From Dictionary    ${user[5]}    username    "default"  # ใช้คีย์ "username" จากตัวแปรแรกใน users
    ${password}=    Get From Dictionary    ${user[5]}    password    "default"  # ใช้คีย์ "password" จากตัวแปรแรกใน users
    #Log    ${first_user}  # ดูข้อมูล username
    #Log    ${password}    # ดูข้อมูล password
    Open Web Swag Labs
    Input Text    ${USERNAME_XPATH}    ${first_user}
    Input Text    ${PASSWORD_XPATH}    ${password}
    Sleep    1s
    Click Button    ${LOGIN_BUTTON_XPATH}
    Add to cart Sauce Labs Backpack
    Add to cart Sauce Labs Bike Light
    Sauce Labs Bolt T-Shirt
    Test.allTheThings() T-Shirt (Red)
    SeleniumLibrary.Click Element    ${shopping_cart} 
    Click Button    ${removebackpack}
    Click Button    ${checkout}
    
    SeleniumLibrary.Wait Until Element Contains  ${titleCheckout}  Checkout: Your Information

    Input User Password
    
    # Get Item 1 - Sauce Labs Bike Light
    ${item1_name}=    Get Text    ${Item1name}
    Should Be Equal As Strings    ${item1_name}    Sauce Labs Bike Light
    ${item1_price}=    Get Text    ${Item1price}
    ${item1_price}=    Evaluate    float("${item1_price.replace('$', '')}")    # แปลงราคาจาก "$9.99" เป็น 9.99
    Should Be Equal As Numbers    ${item1_price}    9.99

    # Get Item 2 - Sauce Labs Bolt T-Shirt
    ${item2_name}=    Get Text    ${Item2name}
    Should Be Equal As Strings    ${item2_name}    Sauce Labs Bolt T-Shirt
    ${item2_price}=    Get Text    ${Item2price}
    ${item2_price}=    Evaluate    float("${item2_price.replace('$', '')}")    # แปลงราคาจาก "$15.99" เป็น 15.99
    Should Be Equal As Numbers    ${item2_price}    15.99

    # Get Item 3 - Test.allTheThings() T-Shirt (Red)
    ${item3_name}=    Get Text    ${Item3name}
    Should Be Equal As Strings    ${item3_name}    Test.allTheThings() T-Shirt (Red)
    ${item3_price}=    Get Text    ${Item3price}
    ${item3_price}=    Evaluate    float("${item3_price.replace('$', '')}")    # แปลงราคาจาก "$15.99" เป็น 15.99
    Should Be Equal As Numbers    ${item3_price}    15.99


    #ตรวจสอบราคาสุทธิ
    ${sum}=    Evaluate    ${item1_price} + ${item2_price} + ${item3_price}
    #Log    Total sum: ${sum}
    # ดึงข้อมูล
    ${subtotal_element}=    Get Text    xpath=//div[@class='summary_subtotal_label' and @data-test='subtotal-label']
    ${subtotal}=    Evaluate    float("${subtotal_element.replace('Item total: $', '')}")
    # ตรวจสอบราคาหน้าเว็บให้ตรงกัน
    Should Be Equal As Numbers    ${sum}    ${subtotal}
    #Log    ${subtotal}
    #Log    ${sum}

    # คำนวณและปัดเศษค่าภาษี
    ${tax} =    Evaluate    ${sum} * ${TAX_RATE}
    ${tax_rounded} =    Evaluate    round(${tax}, 2)
    # คำนวณราคาสุทธิรวมภาษี
    ${total_price} =    Evaluate    ${sum} + ${tax_rounded}
    #Log    Tax: ${tax_rounded}, Total Price with Tax: ${total_price}
    # ดึงค่าภาษีจากหน้าเว็บ
    ${tax_from_page}=    Get Text    xpath=//div[@data-test='tax-label']
    # แปลงข้อความภาษีให้เป็นตัวเลข
    ${tax_value}=    Evaluate    float("${tax_from_page.replace('Tax: $', '')}")
    # ตรวจสอบว่าค่าภาษีจากหน้าเว็บตรงกับค่าภาษีที่ปัดเศษแล้ว
    Should Be Equal As Numbers    ${tax_value}    ${tax_rounded}
    # แสดงค่าภาษี
    #Log    Tax from page: ${tax_value}, Calculated tax: ${tax_rounded}


    # คำนวณราคารวมสุทธิ
    ${total_price} =    Evaluate    ${sum} + ${tax_value}
    # ดึงราคาสุทธิจากหน้าเว็บ
    ${total_from_page}=    Get Text    xpath=//div[@data-test='total-label']
    ${total_value}=    Evaluate    float("${total_from_page.replace('Total: $', '')}")
    # ตรวจสอบว่าราคาสุทธิที่คำนวณได้ตรงกับค่าที่แสดงบนเว็บ
    Should Be Equal As Numbers    ${total_value}    ${total_price}
    # แสดงค่าที่ใช้ตรวจสอบใน Log
    #Log    Calculated Total: ${total_price}, Total from page: ${total_value}
    

    Click Element    ${finish}
    sleep  1s
    Element Should Contain    xpath=//h2[@data-test="complete-header"]    Thank you for your order!
    Click Element    id=back-to-products
    sleep  1s
    Element Should Contain    ${LOGIN_LOGO_XPATH}    Swag Labs
    


Test Login From JSON
    [Documentation]    ทดสอบการล็อกอินด้วยข้อมูลจาก JSON หน้า Login ต่างๆ และ Capture
    ${data}=    Load JSON From File    D:/AutomatedDriver/data/Addass.json
    #Log    ${data}
    FOR    ${user}    IN    @{data['users']}
    Open Web Swag Labs
    Input Text    ${USERNAME_XPATH}    ${user['username']}
    Input Text    ${PASSWORD_XPATH}    ${user['password']}
    Sleep    1s
    Click Button    ${LOGIN_BUTTON_XPATH}
    Capture Page Screenshot
    END