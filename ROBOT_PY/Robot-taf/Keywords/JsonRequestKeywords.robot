*** Settings ***
Library         OperatingSystem
Library         Collections
Library         CSVLibrary
Library         ..${/}..${/}fw-json${/}utils${/}jsonreader.py
Library         ..${/}..${/}fw-json${/}utils${/}send_request.py
Library         ..${/}..${/}fw-json${/}utils${/}convert_json.py


*** Keywords ***
Build Get Request
    [Documentation]   This keyword will build the get request and verify response status and response body
    [Arguments]    ${BASEURL_ACTION}    ${RELATIVE_URI}    ${EXCEPTED_RESPONSE_STATUS}    ${RESPONSE_BODY_EXACT_MATCH}    ${RESPONSE_BODY}    ${RESPONSE_BODY_START_WITH}    ${RESPONSE_BODY_END_WITH}    ${RESPONSE_BODY_CONTAINS}    ${Cookies}    ${DEPENDENT_FLAG}    ${DEPENDENT_VALUES}    ${DEPENDENT_DICT}    ${IS_DEPENDENT_FLAG_REQUIRED}
    ${GET_RESPONSE_CODE}  ${GET_RESPONSE}    send_request.Send Get Request    ${BASEURL_ACTION}    ${RELATIVE_URI}    ${Cookies}    ${DEPENDENT_DICT}    ${IS_DEPENDENT_FLAG_REQUIRED}
    IF    "${DEPENDENT_FLAG}" == "true"    jsonreader.Update Dependant value    ${GET_RESPONSE_CODE}    ${GET_RESPONSE}    ${DEPENDENT_VALUES}    ${DEPENDENT_DICT}
    IF    "${IS_DEPENDENT_FLAG_REQUIRED}" == "true"    jsonreader.Update Dependant value    ${GET_RESPONSE_CODE}    ${GET_RESPONSE}    ${DEPENDENT_VALUES}    ${DEPENDENT_DICT}
    Verify Response Status    ${GET_RESPONSE_CODE}    ${EXCEPTED_RESPONSE_STATUS}
    Verify Response Body    ${RESPONSE_BODY_EXACT_MATCH}  ${GET_RESPONSE}  ${RESPONSE_BODY}  ${RESPONSE_BODY_START_WITH}  ${RESPONSE_BODY_END_WITH}  ${RESPONSE_BODY_CONTAINS}


Build Post Request
    [Documentation]   This keyword will build the post request and verify response status and response body
    [Arguments]    ${BASEURL_ACTION}    ${RELATIVE_URI}    ${EXCEPTED_RESPONSE_STATUS}    ${RESPONSE_BODY_EXACT_MATCH}    ${RESPONSE_BODY}    ${RESPONSE_BODY_START_WITH}    ${RESPONSE_BODY_END_WITH}    ${RESPONSE_BODY_CONTAINS}    ${REQUEST_BODY}    ${Cookies}    ${DEPENDENT_FLAG}    ${DEPENDENT_VALUES}    ${DEPENDENT_DICT}    ${IS_DEPENDENT_FLAG_REQUIRED}
    ${GET_RESPONSE_CODE}  ${GET_RESPONSE}    send_request.Send Post Request    ${BASEURL_ACTION}    ${RELATIVE_URI}    ${REQUEST_BODY}    ${Cookies}    ${DEPENDENT_DICT}    ${IS_DEPENDENT_FLAG_REQUIRED}
    Verify Response Status    ${GET_RESPONSE_CODE}    ${EXCEPTED_RESPONSE_STATUS}
    Verify Response Body    ${RESPONSE_BODY_EXACT_MATCH}  ${GET_RESPONSE}  ${RESPONSE_BODY}  ${RESPONSE_BODY_START_WITH}  ${RESPONSE_BODY_END_WITH}  ${RESPONSE_BODY_CONTAINS}


Build Put Request
    [Documentation]   This keyword will build the put request and verify response status and response body
    [Arguments]    ${BASEURL_ACTION}    ${RELATIVE_URI}    ${EXCEPTED_RESPONSE_STATUS}    ${RESPONSE_BODY_EXACT_MATCH}    ${RESPONSE_BODY}    ${RESPONSE_BODY_START_WITH}    ${RESPONSE_BODY_END_WITH}    ${RESPONSE_BODY_CONTAINS}    ${REQUEST_BODY}    ${Cookies}    ${DEPENDENT_FLAG}    ${DEPENDENT_VALUES}    ${DEPENDENT_DICT}    ${IS_DEPENDENT_FLAG_REQUIRED}
    ${GET_RESPONSE_CODE}  ${GET_RESPONSE}    send_request.Send Put Request    ${BASEURL_ACTION}    ${RELATIVE_URI}    ${REQUEST_BODY}    ${Cookies}    ${DEPENDENT_DICT}    ${IS_DEPENDENT_FLAG_REQUIRED}
    Verify Response Status    ${GET_RESPONSE_CODE}    ${EXCEPTED_RESPONSE_STATUS}
    Verify Response Body    ${RESPONSE_BODY_EXACT_MATCH}  ${GET_RESPONSE}  ${RESPONSE_BODY}  ${RESPONSE_BODY_START_WITH}  ${RESPONSE_BODY_END_WITH}  ${RESPONSE_BODY_CONTAINS}


Build Delete Request
    [Documentation]   This keyword will build the delete request and verify response status and response body
    [Arguments]    ${BASEURL_ACTION}    ${RELATIVE_URI}    ${EXCEPTED_RESPONSE_STATUS}    ${RESPONSE_BODY_EXACT_MATCH}    ${RESPONSE_BODY}    ${RESPONSE_BODY_START_WITH}    ${RESPONSE_BODY_END_WITH}    ${RESPONSE_BODY_CONTAINS}    ${REQUEST_BODY}    ${Cookies}    ${DEPENDENT_FLAG}    ${DEPENDENT_VALUES}    ${DEPENDENT_DICT}    ${IS_DEPENDENT_FLAG_REQUIRED}
    ${GET_RESPONSE_CODE}  ${GET_RESPONSE}    send_request.Send Delete Request    ${BASEURL_ACTION}    ${RELATIVE_URI}    ${REQUEST_BODY}    ${Cookies}    ${DEPENDENT_DICT}    ${IS_DEPENDENT_FLAG_REQUIRED}
    Verify Response Status    ${GET_RESPONSE_CODE}    ${EXCEPTED_RESPONSE_STATUS}
    Verify Response Body    ${RESPONSE_BODY_EXACT_MATCH}  ${GET_RESPONSE}  ${RESPONSE_BODY}  ${RESPONSE_BODY_START_WITH}  ${RESPONSE_BODY_END_WITH}  ${RESPONSE_BODY_CONTAINS}


Check Start With Response
    [Documentation]   This keyword will verify response if it start with condition
    [Arguments]    ${GET_RESPONSE}    ${RESPONSE_BODY_START_WITH}
    ${result}    jsonreader.Verify Start With  ${GET_RESPONSE}  ${RESPONSE_BODY_START_WITH}


Check End With Response
    [Documentation]   This keyword will verify response if it end with condition
    [Arguments]    ${GET_RESPONSE}    ${RESPONSE_BODY_END_WITH}
    Log    ${GET_RESPONSE}
    Log    ${RESPONSE_BODY_END_WITH}
    ${result}    jsonreader.Verify End With  ${GET_RESPONSE}  ${RESPONSE_BODY_END_WITH}


Check Contain Response
    [Documentation]   This keyword will verify response based on condition of contain if anything specific required to verify in response.
    [Arguments]    ${GET_RESPONSE}    ${RESPONSE_BODY_CONTAINS}
    ${result}    jsonreader.Verify Contain  ${GET_RESPONSE}  ${RESPONSE_BODY_CONTAINS}


Check Exact Response
    [Documentation]   This keyword will verify response with exact response condition
    [Arguments]    ${GET_RESPONSE}    ${RESPONSE_BODY}
    ${CHECK_RESPONSE}  jsonreader.Compare Json Files    ${GET_RESPONSE}    ${RESPONSE_BODY}
    Should Be True    ${CHECK_RESPONSE}


Verify Response Body
    [Documentation]   This keyword will verify response body with verious response conditions
    [Arguments]    ${RESPONSE_BODY_EXACT_MATCH}  ${GET_RESPONSE}  ${RESPONSE_BODY}  ${RESPONSE_BODY_START_WITH}  ${RESPONSE_BODY_END_WITH}  ${RESPONSE_BODY_CONTAINS}
    IF   "${RESPONSE_BODY_EXACT_MATCH}" == "true"    Check Exact Response  ${GET_RESPONSE}  ${RESPONSE_BODY}
    IF   "${RESPONSE_BODY_START_WITH}" != ""    Check Start With Response    ${GET_RESPONSE}  ${RESPONSE_BODY_START_WITH}
    IF   "${RESPONSE_BODY_END_WITH}" != ""    Check End With Response    ${GET_RESPONSE}  ${RESPONSE_BODY_END_WITH}
    IF   "${RESPONSE_BODY_CONTAINS}" != ""    Check Contain Response    ${GET_RESPONSE}  ${RESPONSE_BODY_CONTAINS}


Verify Response Status
    [Documentation]   This keyword will verify response status
    [Arguments]    ${RESPONSE_CODE}    ${EXCEPTED_RESPONSE_STATUS}
    Run Keyword And Continue On Failure    Should Be Equal As Integers   ${RESPONSE_CODE}    ${EXCEPTED_RESPONSE_STATUS}


Convert JSON To CSV
    [Arguments]    ${CSV_FILE}    ${JSON_FILE}
    convert_json.Add Json Data To CSV File    ${CSV_FILE}    ${JSON_FILE}
