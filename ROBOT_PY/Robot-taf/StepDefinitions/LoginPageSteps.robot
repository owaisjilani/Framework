[Metadata]    Author    Owais Jilani
*** Settings ***  
Resource    ..${/}Keywords${/}LoginPageKeywords.robot

#*** Variable ***
#${LIST} = Set Variable ${EMPTY}

*** Keywords ***
Launch Google
    LoginPageKeywords.Launch Google

Search for BookmyShow Text and press Enter
    LoginPageKeywords.Input Google Search with text BookMyShow

Click on 3rd Link
    Run Keyword and Ignore Error    LoginPageKeywords.Scroll and click BMS Link
#    @{LIST} = Set Variable
    Log Many    Get Webelements     ${oButton}
#    Log Many    ${LIST}





























Open Browser To Login Page
    LoginPageKeywords.Open Browser To Login Page

Go To Login Page
    LoginPageKeywords.Go To Login Page

Login With Username and Password
     [Arguments]  ${username}  ${password}
     LoginPageKeywords.Login With Username and Password     ${username}  ${password}

Login with valid credentials
     [Arguments]    ${username}    ${password}    ${target_url}
     LoginPageKeywords.Login with valid credentials     ${username}    ${password}    ${target_url}

Login Should Have Failed
    [Arguments]                                   ${Error Message Locator}
    LoginPageKeywords.Login Should Have Failed    ${Error Message Locator}

Login Without Username Should Fail
     [Arguments]    ${username}      ${password}
     LoginPageKeywords.Login Without Username Should Fail   ${username}      ${password}

Login With Invalid Credentials Should Fail
    [Arguments]    ${username}      ${password}
    LoginPageKeywords.Login With Invalid Credentials Should Fail    ${username}      ${password}

Login Without Password Should Fail
    [Arguments]    ${username}      ${password}
    LoginPageKeywords.Login Without Password Should Fail    ${username}     ${password}

Clear local storage and login with custom target landing page
    [Arguments]     ${Username}     ${Password}     ${Target Landing Page URL}
    LoginPageKeywords.Clear local storage and login with custom target landing page   ${Username}     ${Password}     ${Target Landing Page URL}


Login With ${USER} Account
     LoginPageKeywords.Login With ${USER} Account

Login With Account $USER
    [Arguments]    ${USER}
    LoginPageKeywords.Login With ${USER} Account

Clear local storage and login with ${Role} user
     LoginPageKeywords.Clear local storage and login with ${Role} user

Login with ${Role} user if not logged in yet
     LoginPageKeywords.Login with ${Role} user if not logged in yet

Request "Forgot your Password" email for username "${USERNAME}"
    LoginPageKeywords.Request "Forgot your Password" email for username "${USERNAME}"

Verify forget password link is available on the login screen
    LoginPageKeywords.Verify forget password link is available on the login screen

Verify trademark name on login page
    LoginPageKeywords.Verify trademark name on login page
