*** Settings ***  
Library  SeleniumLibrary  
  
*** Variables ***  
${URL}  https://www.saucedemo.com/  
${USERNAME_VALID}  standard_user  
${PASSWORD_VALID}  secret_sauce  
${USERNAME_INVALID}  invalid_user  
${PASSWORD_INVALID}  invalid_password  
  
*** Keywords ***  
Open Sauce Demo Website  
    Open Browser  ${URL}  browser=chrome  
    Maximize Browser Window  
  
Login With Credentials  
    [Arguments]  ${username}  ${password}  
    Input Text  id=user-name  ${username}  
    Input Text  id=password  ${password}  
    Click Button  id=login-button  
  
Login With Valid Credentials  
    Login With Credentials  ${USERNAME_VALID}  ${PASSWORD_VALID}  
  
Login With Invalid Credentials  
    Login With Credentials  ${USERNAME_INVALID}  ${PASSWORD_INVALID}  

Add Item To Cart  
    Click Button  xpath=//button[text()='Add to cart']  
  
Navigate To Cart Page  
    Click Element  xpath=//a[contains(@class, 'shopping_cart_link')]  
  
Enter Checkout Information  
    [Arguments]  ${first_name}  ${last_name}  ${postal_code}  
    Input Text  id=first-name  ${first_name}  
    Input Text  id=last-name  ${last_name}  
    Input Text  id=postal-code  ${postal_code}  
    Click Button  id=continue  
  
*** Test Cases ***  
TC001 - Valid Login  
    [Documentation]  Verify that a user can log in with valid credentials  
    Open Sauce Demo Website  
    Login With Valid Credentials  
    Location Should Be  ${URL}inventory.html  
    [Teardown]  Close Browser  
  
TC002 - Invalid Login  
    [Documentation]  Verify that a user cannot log in with invalid credentials  
    Open Sauce Demo Website  
    Login With Invalid Credentials  
    Page Should Contain  Epic sadface: Username and password do not match any user in this service 
    [Teardown]  Close Browser  
  
TC003 - Add Item to Cart  
    [Documentation]  Verify that a user can add an item to the cart  
    Open Sauce Demo Website  
    Login With Valid Credentials  
    Click Button  xpath=//button[text()='Add to cart']  
    Element Text Should Be  xpath=//span[@class='shopping_cart_badge']  1  
    [Teardown]  Close Browser  
  
TC004 - Remove Item from Cart  
    [Documentation]  Verify that a user can remove an item from the cart  
    Open Sauce Demo Website  
    Login With Valid Credentials  
    Click Button  xpath=//button[text()='Add to cart']  
    Click Button  xpath=//button[text()='Remove']  
    Page Should Not Contain Element  xpath=//span[@class='shopping_cart_badge']  
    [Teardown]  Close Browser  
  
TC005 - View Cart  
    [Documentation]  Verify that a user can view their cart  
    Open Sauce Demo Website  
    Login With Valid Credentials  
    Click Element  xpath=//a[contains(@class, 'shopping_cart_link')]  
    Location Should Be  ${URL}cart.html  
    [Teardown]  Close Browser  
  
TC006 - Clear Cart  
    [Documentation]  Verify that a user can clear their cart  
    Open Sauce Demo Website  
    Login With Valid Credentials  
    Click Button  xpath=//button[text()='Add to cart']  
    Click Element  xpath=//a[contains(@class, 'shopping_cart_link')]  
    Click Button  xpath=//button[text()='Remove']  
    Page Should Not Contain Element  xpath=//span[@class='shopping_cart_badge']  
    [Teardown]  Close Browser  

TC007 - Complete Checkout with Valid Information  
    [Documentation]  Verify that a user can complete the checkout process with valid information  
    Open Sauce Demo Website  
    Login With Valid Credentials  
    Add Item To Cart  
    Navigate To Cart Page  
    Click Button  id=checkout  
    Enter Checkout Information  John  Doe  12345  
    Click Button  id=finish  
    Wait Until Page Contains  Your order has been dispatched  
    [Teardown]  Close Browser  
  
TC008 - Incomplete Checkout with Missing Information  
    [Documentation]  Verify that a user cannot complete the checkout process with missing information  
    Open Sauce Demo Website  
    Login With Valid Credentials  
    Add Item To Cart  
    Navigate To Cart Page  
    Click Button  id=checkout  
    Enter Checkout Information  John  Doe  ${EMPTY}  
    Click Button  id=continue  
    Wait Until Page Contains  Error: Postal Code is required  
    [Teardown]  Close Browser  
  
TC009 - Cancel Checkout  
    [Documentation]  Verify that a user can cancel the checkout process  
    Open Sauce Demo Website  
    Login With Valid Credentials  
    Add Item To Cart  
    Navigate To Cart Page  
    Click Button  id=checkout  
    Click Button  id=cancel  
    Location Should Be  ${URL}cart.html  
    [Teardown]  Close Browser  
  
TC010 - Complete Checkout with Invalid Information  
    [Documentation]  Verify that a user cannot complete the checkout process with invalid information  
    Open Sauce Demo Website  
    Login With Valid Credentials  
    Add Item To Cart  
    Navigate To Cart Page  
    Click Button  id=checkout  
    Enter Checkout Information  ${EMPTY}  ${EMPTY}  ${EMPTY}  
    Click Button  id=continue  
    Wait Until Page Contains  Error: First Name is required  
    [Teardown]  Close Browser  