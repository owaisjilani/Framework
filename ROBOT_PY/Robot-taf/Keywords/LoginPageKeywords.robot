[Metadata]    Author    Owais Jilani
*** Settings ***  
Library     SeleniumLibrary
Library     String
Library     Collections
Library     ..${/}Library${/}CryptoService.py

Resource    ..${/}Library${/}Util.robot

Resource    ..${/}Settings${/}config.robot
Resource    ..${/}Settings${/}users.robot


Variables   ..${/}PageObjects${/}PageText${/}LoginPage.py
Variables   ..${/}PageObjects${/}Locators${/}LoginPageElements.py
Variables   ..${/}PageObjects${/}Locators${/}CommonLocators.py

*** Keywords ***
Launch Google
    Go To  ${${ENV}_APP_LOGIN_URL}

Input Google Search with text BookMyShow
     Input Text    ${searchInput}  Bookmyshow
     Press Keys    ${searchInput}    RETURN   #Pressing Enter Key here
     
Scroll and click BMS Link
    Util.Scroll and Wait For Element     ${oBmsLink}
    Click Element    ${oBmsLink}












Input Username
    [Arguments]  ${username}
    Input Text    ${oLoginUsernameInput}  ${username}
    Press Keys    ${oLoginUsernameInput}    RETURN   #Pressing Enter Key here

Input Password
    [Arguments]  ${password}
    Wait Until Element Is Visible    ${oLoginPasswordInput}
    Input Text    ${oLoginPasswordInput}  ${password}

Click on Login button
    Wait Until Element Is Visible    ${oSignInButton}
    Press Enter Key   ${oLoginUsernameInput}
    ${notLoggedIn} =   Get Element Count   ${oSignInButton}
    Run Keyword If   ${notLoggedIn}>0    Press Enter Key   ${oLoginUsernameInput}

Submit Credentials
    Wait Until Element Is Visible    ${oSignInButton}
    Press Enter Key   ${oLoginUsernameInput}
    Confirm submit credentials

Confirm submit credentials
    Run Keyword And Ignore Error        Wait Until Page Contains Element    ${oLoginWelcomeBadge}      ${DELAY.SHORT}
    Run Keyword And Ignore Error        Click Element                        ${oSignInButton}

Page Should Be Open
    [Arguments]  ${page_url}
    ${new_url}=    Replace String    ${page_url}    ${${ENV}_SSO_URL}    ${empty}     
    Location Should Be    ${new_url}
    Title Should Be       Application Title here

Wait Until Page Is Open
    [Arguments]     ${Page URL}
    Wait Until Keyword Succeeds    6x    500ms    Page Should Be Open    ${Page URL}

Wait Login Page To Be Open
    Wait Until Page Contains Element    ${oLoginUsernameInput}      ${DELAY.VERYLONG}

Login Page Should Be Open
    Page Should Contain Element     ${oLoginUsernameInput}
    Page Should Contain Element     ${oLoginPasswordInput}
    Page Should Be Open             ${AUTO_APP_URL}

Wait until login loader disappear
    Run Keyword And Ignore Error    Wait Until Element Is Not Visible    ${oWaitLoader}

Click on "Forgot your password?"
    Wait Until Element is Visible   ${oForgotPwdLink}
    Click Element                   ${oForgotPwdLink}

Insert ${USER} Email address
    [Arguments]    ${USER}
    Wait Until Element is Visible       ${oForgottonPwInput}
    ${Lowercase User}=  Set Variable    ${USER.lower()}
    Log    Selected case: ${Lowercase User}
    Run Keyword If      '${Lowercase User}' == 'manager'        Input Text    ${oForgottonPwInput}    ${MANAGER_USER.EMAIL}
    Run Keyword If      '${Lowercase User}' == 'tm_manager'     Input Text    ${oForgottonPwInput}    ${TM_MANAGER_USER.EMAIL}
    Run Keyword If      '${Lowercase User}' == 'ctr_manager'    Input Text    ${oForgottonPwInput}    ${CTR_MANAGER_USER.EMAIL}
    Run Keyword If      '${Lowercase User}' == 'analyst'        Input Text    ${oForgottonPwInput}    ${ANALYST_USER.EMAIL}
    Run Keyword If      '${Lowercase User}' == 'tm_analyst'     Input Text    ${oForgottonPwInput}    ${TM_ANALYST_USER.EMAIL}
    Run Keyword If      '${Lowercase User}' == 'ctr_analyst'    Input Text    ${oForgottonPwInput}    ${CTR_ANALYST_USER.EMAIL}
    Run Keyword If      '${Lowercase User}' == 'analyst2'       Input Text    ${oForgottonPwInput}    ${ANALYST2_USER.EMAIL}
    Run Keyword If      '${Lowercase User}' == 'ga_admin'       Input Text    ${oForgottonPwInput}    ${ADM_USER.EMAIL}
    Run Keyword If      '${Lowercase User}' == 'qa'             Input Text    ${oForgottonPwInput}    ${QA_USER.EMAIL}
    Run Keyword If      '${Lowercase User}' == 'default'        Input Text    ${oForgottonPwInput}    ${MANAGER_USER.EMAIL}

Click on "Send Email"
    Wait Until Element is Visible   ${oSendEmail}
    Click Element                   ${oSendEmail}
    Wait Until Element is Visible   ${oChangePasswordSuccess}

Invalid Login message should be displayed
    Page should contain element     ${oInvalidLoginMessage}

Change password to "${PASSWORD}"
    Wait Until Element is Visible       ${oNewPassword}
    Input Text                          ${oNewPassword}         ${PASSWORD}
    Input Text                          ${oConfirmPassword}     ${PASSWORD}
    Click Element                       ${oChangePassword}

Verify the Trademark Name
    [Arguments]     ${Expected Trademark Name}
    Wait Until Element Is Visible          ${oTrademarkName}            timeout=${DELAY.MEDIUM}
    ${Trademark Name Text}=                Get Element Attribute        ${oTrademarkName}    alt
    Should Be Equal                        ${Trademark Name Text}       ${Expected Trademark Name}

Open Browser To Login Page
    [Arguments]   ${browser}=chrome
    Open Browser  ${${ENV}_APP_URL}    ${browser}
    Maximize Browser Window
    Util.Set Page Zoom Level    ${ZOOM_PERCENTAGE}
    LoginPageKeywords.Wait Login Page To Be Open

Go To Login Page
    Go To  ${${ENV}_APP_LOGIN_URL}
    Wait Login Page To Be Open
    Util.Set Page Zoom Level    ${ZOOM_PERCENTAGE}

Login With Username and Password
    [Arguments]  ${username}  ${password}
    Input Username    ${username}
    Set Log Level    NONE    # This will suppress log messages for security reasons
    ${password}    Decrypt Msg    ${password}
    LoginPageKeywords.Input Password    ${password}
    Set Log Level    INFO
    LoginPageKeywords.Click on Login button

Login with valid credentials
    [Arguments]         ${username}     ${password}         ${target_url}
    Login With Username and Password    ${username}         ${password}
    Run Keyword and Ignore Error        Wait Until Keyword Succeeds         ${DELAY.VERYLONG}   ${DELAY.VERYSHORT}   Wait Until Element Is Visible    ${oCommonLoader}
    Run Keyword and Ignore Error        Wait Until Loader Is Not Visible
    Wait For Condition    return document.readyState == "complete"
    Set Suite Variable                  ${Logged Username}  ${username}
    Page Should Contain Element         ${oLogo}
#    Wait Until Page Is Open            ${target_url}

Login Should Have Failed
    [Arguments]                     ${Error Message Locator}
    Location Should Be              ${${ENV}_APP_LOGIN_URL}
    Title Should Be                 Application Title here
    Wait until login loader disappear
    Wait Until Element Is Visible   ${Error Message Locator}    ${DELAY.MEDIUM}
    ${result}    Get Text           ${Error Message Locator}
    Should Be Equal    ${result}    ${pInvalidUserNamePWDMsg}

Login Without Username Should Fail
    [Arguments]                          ${username}      ${password}
    Login With Username and Password     ${username}      ${password}
    Login Should Have Failed             ${oInvalidLoginMessage}

Login With Invalid Credentials Should Fail
    [Arguments]         ${username}      ${password}
    Login With Username and Password     ${username}      ${password}
    Login Should Have Failed             ${oInvalidLoginMessage}

Login Without Password Should Fail
    [Arguments]         ${username}      ${password}
    Login With Username and Password     ${username}      ${password}
    Wait until login loader disappear
    Location Should Be                   ${${ENV}_APP_LOGIN_URL}
    Title Should Be                      Title Text here

Clear local storage and login with custom target landing page
    [Arguments]     ${Username}     ${Password}     ${Target Landing Page URL}
    Clear browser local storage
    Go To Login Page
    Login with valid credentials    ${Username}  ${Password}  ${Target Landing Page URL}

Login if not logged in yet with custom target landing page
    [Arguments]         ${Username}     ${Password}     ${Target Landing Page URL}=${ACCESS_MANAGEMENT_URL}
    ${Is Logged In}=    Run Keyword And Return Status   Should Be True          '${Username}' == '${Logged Username}'
    Run Keyword If      ${Is Logged In} == False
    ...     Clear local storage and login with custom target landing page
    ...         ${Username}
    ...         ${Password}
    ...         ${Target Landing Page URL}

Login With ${USER} Account
    ${Lowercase User}=  Set Variable    ${USER.lower()}
    Set Suite Variable    ${User}    ${USER.upper()}
    Log    Selected case: ${Lowercase User}
    Run Keyword If      '${Lowercase User}' == 'manager'        Login with valid credentials    ${MANAGER_USER.USERNAME}               ${MANAGER_USER.PASSWORD}        ${ACCESS_MANAGEMENT_URL}
    Run Keyword If      '${Lowercase User}' == 'tm_manager'     Login with valid credentials    ${TM_MANAGER_USER.USERNAME}            ${TM_MANAGER_USER.PASSWORD}     ${ACCESS_MANAGEMENT_URL}
    Run Keyword If      '${Lowercase User}' == 'ctr_manager'    Login with valid credentials    ${CTR_MANAGER_USER.USERNAME}           ${CTR_MANAGER_USER.PASSWORD}    ${ACCESS_MANAGEMENT_URL}
    Run Keyword If      '${Lowercase User}' == 'analyst'        Login with valid credentials    ${ANALYST_USER.USERNAME}               ${ANALYST_USER.PASSWORD}        ${ACCESS_MANAGEMENT_URL}
    Run Keyword If      '${Lowercase User}' == 'tm_analyst'     Login with valid credentials    ${TM_ANALYST_USER.USERNAME}            ${TM_ANALYST_USER.PASSWORD}     ${ACCESS_MANAGEMENT_URL}
    Run Keyword If      '${Lowercase User}' == 'ctr_analyst'    Login with valid credentials    ${CTR_ANALYST_USER.USERNAME}           ${CTR_ANALYST_USER.PASSWORD}    ${ACCESS_MANAGEMENT_URL}
    Run Keyword If      '${Lowercase User}' == 'analyst2'       Login with valid credentials    ${ANALYST2_USER.USERNAME}              ${ANALYST2_USER.PASSWORD}       ${ACCESS_MANAGEMENT_URL}
    Run Keyword If      '${Lowercase User}' == 'ga_admin'       Login with valid credentials    ${ADM_USER.USERNAME}                   ${ADM_USER.PASSWORD}            ${ACCESS_MANAGEMENT_URL}
    Run Keyword If      '${Lowercase User}' == 'qa'             Login with valid credentials    ${QA_USER.USERNAME}                    ${QA_USER.PASSWORD}             ${ACCESS_MANAGEMENT_URL}
    Run Keyword If      '${Lowercase User}' == 'default'        Login with valid credentials    ${MANAGER_USER.USERNAME}               ${MANAGER_USER.PASSWORD}        ${ACCESS_MANAGEMENT_URL}

Clear local storage and login with ${Role} user
    Clear browser local storage
    Go To Login Page
    Login With ${Role} Account

Login with ${Role} user if not logged in yet
    ${Lowercase Role}=  Set Variable                    ${Role.lower()}
    ${Username}=        Get From Dictionary             ${${Role.upper()}_USER}    USERNAME
    ${Is Logged In}=    Run Keyword And Return Status   Should Be True          '${Username}' == '${Logged Username}'
    ${LoggedIn}=        Run Keyword And Return Status   Wait Until Element Is Enabled    ${oProfileButton}
    Run Keyword If       ${Is Logged In} == False or ${LoggedIn} == False
    ...    Clear local storage and login with ${Lowercase Role} user

Request "Forgot your Password" email for username "${USERNAME}"
    Click on "Forgot your password?"
    Insert "${USERNAME}" Username
    Click on "Send Email"

Verify forget password link is available on the login screen
    Input Username                   ${Empty}
    Wait Until Element Is Visible    ${oForgotPwdLink}

Verify trademark name on login page
    Verify the Trademark Name    App Name
    Page Should Not Contain      Old Name

Open Sauce Demo Website
    Open Browser  ${APP_URL}  browser=chrome
    Maximize Browser Window

Login With Credentials
    [Arguments]  ${username}  ${password}
    Input Text   ${oUserName}  ${username}
    Input Text   ${oPassword}   ${password}
    Click Button    ${oLoginButton}

Login With Valid Credentials in SauceDemo
    Login With Credentials  ${validUsername}  ${validPassword}

Login With Invalid Credentials in SauceDemo
    Login With Credentials  ${invalidUsername}  ${invalidPwd}

Add Item To Cart
    Click Button  ${addToCart}

Navigate To Cart Page
    Click Element  ${shoopingCartLink}

Enter Checkout Information
    [Arguments]  ${first_name}  ${last_name}  ${postal_code}
    Input Text   ${oFirstname}  ${first_name}
    Input Text   ${oLastName}   ${last_name}
    Input Text   ${oPostalCode}  ${postal_code}
    Click Button     ${oContinueButton}
