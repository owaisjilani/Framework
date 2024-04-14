#Author: Owais Jilani
*** Settings ***
Resource   ../../../Library/APIUtil.robot
Resource   ../../../Resources/TestDataAPI/Enpoints/CasesEndpoint.robot

Library         REST    ${${ENV}_APP_URL}
Suite Setup     APIUtil.Set Global Header

*** Test Cases ***
Get Case List
    [Setup]                     Expect response body     ${CURDIR}/schema/caseList.json
    Set To Dictionary           ${headers}       Content-Type=application/x-www-form-urlencoded
    Set Headers                 ${headers}
    POST                        ${case_get_list_endpoint}    { "totalCount": 1}
    Integer                     response status     200     201
    String                      $.status            SUCCESS
    Integer                     $.result.result[*].amountAtRisk     minimum=0
    [Teardown]  Clear expectations

Get Transitions
    Set To Dictionary           ${headers}      Content-Type=application/json
    Set Headers                 ${headers}
    POST                        ${case_get_transitions_endpoint}    ["816d973a-647c-4f4a-bffb-72bea9c65062"]
    Integer                     response status     200
    String                      $.status            SUCCESS

Create Case
    Set To Dictionary           ${headers}      Content-Type=application/json
    Set Headers                 ${headers}
    POST                        ${case_endpoint}         {"resolutionDetails":{"resolutions":["OTHER"],"comment":"Test case created by automation script. Ignore!"},"channel":"CHECK"}
    Integer                     response status     200
    String                      $.status            SUCCESS
    ${case_id}                  String             $.result.id
    ${case_id} =                APIUtil.Format Response    ${case_id}
    Set Suite Variable          ${case_id}

Update Case
    Set To Dictionary           ${headers}      Content-Type=application/json
    Set Headers                 ${headers}
    PUT                         ${case_endpoint}/${case_id}             {"category":"NEW_ACTIVITY","priority":"HIGH","amountAtRisk":0,"amountLost":0,"summary":"667"}
    Integer                     response status     200
    String                      $.status            SUCCESS
    String                      $.result            1 cases updated

