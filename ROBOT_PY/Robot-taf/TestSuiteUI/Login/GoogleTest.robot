[Metadata]    Author    Owais Jilani
*** Settings ***  
Library         SeleniumLibrary
Resource        ..${/}..${/}Settings${/}config.robot
Resource        ..${/}..${/}StepDefinitions${/}LoginPageSteps.robot
Resource        ..${/}..${/}Library${/}TestSetup.robot

Test Setup      Run Keywords    TestSetup.Begin Web Test
...             AND   LoginPageSteps.Launch Google

Test Teardown   TestSetup.End Web Test

Test Tags       LOGIN   REGRESSION

*** Test Cases ***
TC001 - Valid Google Search Test
    [Documentation]  Verify that a user can log in with valid credentials
    LoginPageSteps.Search for BookmyShow Text and press Enter
    LoginPageSteps.Click on 3rd Link

