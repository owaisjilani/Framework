[Metadata]  Author  Owais Jilani

*** Settings ***
Resource            ..${/}..${/}Library${/}TestSetup.robot
Resource            ..${/}..${/}StepDefinitions${/}LoginPageSteps.robot

Library             DataDriver   file=${CURDIR}/RolesAndPrivlegesListData.csv   delimiter=|   encoding=utf_8    dialect=UserDefined
                    ...    delimiter=|

Test Template       Verify Default Privileges

Suite Setup         Run Keywords    TestSetup.Begin Web Test
...                 AND   LoginPageSteps.Go To Login Page
...                 AND   LoginPageSteps.Login with Manager Account

Suite Teardown      TestSetup.End Web Test

Test Tags           ROLESANDPRIVILEGES   REGRESSION


*** Keywords ***
Verify Default Privileges
     [Arguments]    ${roles}    ${channel}  ${PrivlegesYes}   ${PrivlegesNo}
     Log Many      ${roles}    ${channel}
     Log Many    ${PrivlegesYes}   ${PrivlegesNo}

*** Test Cases ***
Verify the Privleges for Manager and Analyst    ${roles}    ${channel}  ${PrivlegesYes}   ${PrivlegesNo}



