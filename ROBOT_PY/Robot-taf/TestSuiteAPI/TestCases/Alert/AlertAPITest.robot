#Author: Owais Jilani
*** Settings ***
Resource   ../../../Library/APIUtil.robot
Resource   ../../../Resources/TestDataAPI/Enpoints/AlertsEndpoint.robot

Library         REST    ${${ENV}_APP_URL}
Suite Setup     APIUtil.Set Global Header

*** Test Cases ***
Get Team Members
    [Setup]                     Expect response body     ${CURDIR}/schema/teamMembers.json
    Set To Dictionary           ${headers}      Content-Type=application/json
    Set Headers                 ${headers}
    GET                         ${alert_users_endpoint}
    Integer                     response status     200
    String                      $.status            SUCCESS
    [Teardown]  Clear expectations

Get Assigned Actions on Alert
    [Setup]                     Expect response body     ${CURDIR}/schema/alertAssignedActions.json
    Set To Dictionary           ${headers}      Content-Type=application/json
    Set Headers                 ${headers}
    GET                         ${assign_actions_endpoint}
    Integer                     response status     200
    String                      $.status            SUCCESS
    [Teardown]  Clear expectations
