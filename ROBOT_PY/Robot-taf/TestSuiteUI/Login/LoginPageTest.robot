[Metadata]    Author    Owais Jilani
*** Settings ***  
Library         SeleniumLibrary
Resource        ..${/}..${/}Settings${/}config.robot
Resource        ..${/}..${/}StepDefinitions${/}LoginPageSteps.robot
Resource        ..${/}..${/}Library${/}TestSetup.robot

Test Setup      Run Keywords    TestSetup.Begin Web Test
...             AND   LoginPageSteps.Go To Login Page

Test Teardown   TestSetup.End Web Test

Test Tags       LOGIN   REGRESSION

*** Test Cases ***
TC001 - Valid Login
    [Documentation]  Verify that a user can log in with valid credentials
    Login With Valid Credentials in SauceDemo
    Location Should Be   ${ACCESS_MANAGEMENT_URL}

TC002 - Invalid Login
    [Documentation]  Verify that a user cannot log in with invalid credentials
    Login With Invalid Credentials in SauceDemo
    Page Should Contain  ${pInvalidLoginMsg}

TC003 - Add Item to Cart
    [Documentation]  Verify that a user can add an item to the cart
    Login With Valid Credentials in SauceDemo
    Click Button  ${addToCart}
    Element Text Should Be  ${shoppingCartBadge}  1

TC004 - Remove Item from Cart
    [Documentation]  Verify that a user can remove an item from the cart
    Login With Valid Credentials in SauceDemo
    Click Button  ${addToCart}
    Click Button  ${removeButton}
    Page Should Not Contain Element  ${shoppingCartBadge}

TC005 - View Cart
    [Documentation]  Verify that a user can view their cart
    Login With Valid Credentials in SauceDemo
    Click Element  ${shoopingCartLink}
    Location Should Be   ${CartUrl}

TC006 - Clear Cart
    [Documentation]  Verify that a user can clear their cart
    Login With Valid Credentials in SauceDemo
    Click Button  ${addToCart}
    Click Element  ${shoopingCartLink}
    Click Button  ${removeButton}
    Page Should Not Contain Element  ${shoppingCartBadge}

TC007 - Complete Checkout with Valid Information
    [Documentation]  Verify that a user can complete the checkout process with valid information
    Login With Valid Credentials in SauceDemo
    Add Item To Cart
    Navigate To Cart Page
    Click Button  ${ocheckoutButton}
    Enter Checkout Information  John  Doe  12345
    Click Button  ${finishButton}
    Wait Until Page Contains  ${porderDispachedMsg}

TC008 - Incomplete Checkout with Missing Information
    [Documentation]  Verify that a user cannot complete the checkout process with missing information
    Login With Valid Credentials in SauceDemo
    Add Item To Cart
    Navigate To Cart Page
    Click Button  ${ocheckoutButton}
    Enter Checkout Information  John  Doe  ${EMPTY}
    Click Button  ${oContinueButton}
    Wait Until Page Contains  ${pPostalCodeRequired}

TC009 - Cancel Checkout
    [Documentation]  Verify that a user can cancel the checkout process
    Login With Valid Credentials in SauceDemo
    Add Item To Cart
    Navigate To Cart Page
    Click Button  ${ocheckoutButton}
    Click Button  ${ocancelButton}
    Location Should Be  ${CartUrl} 

TC010 - Complete Checkout with Invalid Information
    [Documentation]  Verify that a user cannot complete the checkout process with invalid information
    Login With Valid Credentials in SauceDemo
    Add Item To Cart
    Navigate To Cart Page
    Click Button  ${ocheckoutButton}
    Enter Checkout Information  ${EMPTY}  ${EMPTY}  ${EMPTY}
    Click Button  ${oContinueButton}
    Wait Until Page Contains  ${pFirstnameMsg}

#APP-1064 Verify, Login as an Manager role with Valid details
#    [Tags]    SMOKE
#    [Template]      LoginPageSteps.Login with valid credentials
#    ${MANAGER_USER.USERNAME}       ${MANAGER_USER.PASSWORD}    ${ACCESS_MANAGEMENT_URL}
#
#APP-1067 Verify, Login with blank username and password fields
#    [Template]      LoginPageSteps.Login Without Username Should Fail
#    ${EMPTY}         ${ADM_USER.PASSWORD}
#
#TC-1444 Username with space
#    [Template]      LoginPageSteps.Login With Invalid Credentials in SauceDemo Should Fail
#    mana ger1        ${MANAGER_USER.PASSWORD}