Metadata]    Author    Owais Jilani
*** Settings ***  
Library  SeleniumLibrary  
Resource   ../Settings/config.robot
Resource   ../Settings/users.robot 
Resource    ../StepDefinitions/LoginPageSteps.robot
Resource    ../Library/TestSetup.robot

*** Keywords ***  
Login and getCookie
    [Documentation]    Used for getting Token and Cookies detail for API Automation
    [Arguments]    ${AccountType}=Manager
    Begin Web Test    headless=True
    LoginPageSteps.Go To Login Page
    LoginPageSteps.Login With ${AccountType} Account
    ${COOKIE}     Get Cookies  
    ${TOKEN}      Get Cookie    token    
    ${COOKIES}    Create Dictionary    token=${TOKEN.value}    cookie=${COOKIE}
    Return From Keyword    ${COOKIES}     

Get global Headers
    ${COOKIES}    Login and getCookie
    ${AUTHORIZATION_TOKEN}=   Get From Dictionary    ${COOKIES}    token  
    ${AUTHORIZATION_TOKEN}    Replace String    ${AUTHORIZATION_TOKEN}    %20    ${SPACE}
    ${CookieAPI}=    Get From Dictionary    ${COOKIES}    cookie
    ${headers}    Create Dictionary
    ...    accept=application/json
    ...    Authorization=${AUTHORIZATION_TOKEN}
    ...    Cookie=${CookieAPI}
    Return From Keyword    ${headers}

Set Global Header
    ${headers}  Get global Headers
    Set Suite Variable  ${headers}

Format Response
    [Arguments]    ${response}
    ${response} =    Evaluate    "${response}".replace('[', '').replace(']', '').replace("'", '')
    [Return]    ${response}