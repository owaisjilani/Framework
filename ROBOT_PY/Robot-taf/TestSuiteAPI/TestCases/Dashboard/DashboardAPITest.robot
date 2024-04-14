#Author: Owais Jilani
*** Settings ***
Resource   ../../../Library/APIUtil.robot
Resource   ../../../Resources/TestDataAPI/Enpoints/DashboardEndpoint.robot

Library         REST    ${${ENV}_APP_URL}
Suite Setup     APIUtil.Set Global Header

*** Test Cases ***
Get Alert Dashboard
    [Setup]                     Expect response body            ${CURDIR}/schema/alertDashboard.json
    Set To Dictionary           ${headers}                      Content-Type=application/json
    Set Headers                 ${headers}
    GET                         ${alert_dashboard_endpoint}     {"startDate":"2023-09-10","endDate":"2023-10-10"}
    Integer                     response status     200
    String                      $.status            SUCCESS
    [Teardown]  Clear expectations

