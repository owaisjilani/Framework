#Author: Owais Jilani
*** Settings ***
Resource   ../../../Library/APIUtil.robot
Resource   ../../../Resources/TestDataAPI/Enpoints/PetstoreEndpoint.robot

Library         REST    ${${ENV}_APP_URL}
Suite Setup     APIUtil.Set Global Header

*** Test Cases ***
Get specific user details
    [Documentation]             https://asyrjasalo.github.io/RESTinstance/
    [Setup]                     Expect response body     ${CURDIR}/schema/petStore.json
    Set To Dictionary           ${headers}               Content-Type=application/json
    Set Headers                 ${headers}
    GET                         ${user_endpoint}
    INTEGER                     response status       200
    String                      $.password            Swagger
    INTEGER                     $.userStatus          67
    [Teardown]  Clear expectations

Get Store Inventory
    #[Setup]                     Expect response body     ${CURDIR}/schema/petStore.json
    Set To Dictionary           ${headers}               Content-Type=application/json
    Set Headers                 ${headers}
#    &{Response} =    GET        ${storeInventory_endpoint}
#    Log Many         ${Response}
#    Should Contain   ${Response.headers}    Content-Type    application/json
    GET                         ${storeInventory_endpoint}
    INTEGER                     response status       200
#    String                      $.Content-Type              application/json
    INTEGER                     $.available           236
    INTEGER                     $['{{PetStatus-Updated}}']            2   #to give when value is something  "{{PetStatus-Updated}}": 1,
    [Teardown]  Clear expectations

