*** Variables **
### Open Browser ###
${URL}    https://www.saucedemo.com
${BROWSER}    Chrome
### Login ##
${LOGIN_LOGO_XPATH}    xpath=//div[text()='Swag Labs']
${USERNAME_XPATH}    //*[@id="user-name"]
${PASSWORD_XPATH}    //*[@id="password"]
${LOGIN_BUTTON_XPATH}    //*[@id="login-button"]

### คลิปปุ่ม ###
${shopping_cart}    xpath=//*[@id="shopping_cart_container"]
${removebackpack}    //*[@id="remove-sauce-labs-backpack"]
${checkout}    //*[@id="checkout"]
${titleCheckout}    xpath=//span[@data-test="title"]

###หน้า Checkout: Your Information ###
${firstName}    xpath=//input[@data-test="firstName"] 
${lastName}    xpath=//input[@data-test="lastName"] 
${postalCode}    xpath=//input[@data-test="postalCode"] 
${finish}    xpath=//button[@id='finish']

###Test Login User 2 From JSON locked_out_user เช็ค Error
${ERROR_MESSAGE_XPATH}    //div[@class="error-message-container error"]/h3

###เก็บ TAX ###
${TAX_RATE}    0.08  # อัตราภาษี 8%

### Get Item ###
### เก็บชื่อไว้ไปเช็ค ### 
${ITEMS1}    Sauce Labs Backpack
${ITEMS2}    Sauce Labs Bike Light
${ITEMS3}    Sauce Labs Bolt T-Shirt
${ITEMS4}    Test.allTheThings() T-Shirt (Red)
${Item1name}    xpath=//div[@data-test="inventory-item-name" and text()="Sauce Labs Bike Light"]
${Item1price}    xpath=//div[@data-test="inventory-item-name" and text()="Sauce Labs Bike Light"]/ancestor::div[@data-test="inventory-item"]/descendant::div[@data-test="inventory-item-price"]
${Item2name}    xpath=//div[@data-test="inventory-item-name" and text()="Sauce Labs Bolt T-Shirt"]
${Item2price}    xpath=//div[@data-test="inventory-item-name" and text()="Sauce Labs Bolt T-Shirt"]/ancestor::div[@data-test="inventory-item"]/descendant::div[@data-test="inventory-item-price"]
${Item3name}    xpath=//div[@data-test="inventory-item-name" and text()="Test.allTheThings() T-Shirt (Red)"]
${Item3price}    xpath=//div[@data-test="inventory-item-name" and text()="Test.allTheThings() T-Shirt (Red)"]/ancestor::div[@data-test="inventory-item"]/descendant::div[@data-test="inventory-item-price"]
