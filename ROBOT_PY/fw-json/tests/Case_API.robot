*** Settings ***
Library         ..${/}utils${/}jsonreader.py
Library         ..${/}utils${/}send_request.py
Library         ..${/}utils${/}convert_json.py
Library         DataDriver       ..${/}data${/}alert_data.csv

Resource        ..${/}..${/}Robot-taf${/}Keywords${/}JsonRequestKeywords.robot
Resource        ..${/}..${/}Robot-taf${/}Library${/}APIUtil.robot
Resource        ..${/}..${/}Robot-taf${/}Settings${/}config.robot

Suite Setup     Run Keywords    APIUtil.Set Global Header
...             AND             JsonRequestKeywords.Convert JSON To CSV    ${CASEFILE}    ${CASEAPI}
...             AND             Set Global Variable   ${DEPENDENT_DICT}    &{EMPTY}

Test Template   Json Validator



*** Test Cases ***
Validate API Response of ${REQUEST_TYPE} for ${RELATIVE_URI}       ${TEST_NAME}    ${BASEURL_ACTION}    ${DEPENDENT_FLAG}    ${IS_DEPENDENT_FLAG_REQUIRED}    ${RELATIVE_URI}    ${REQUEST_TYPE}    ${EXCEPTED_RESPONSE_STATUS}    ${RESPONSE_BODY}    ${RESPONSE_BODY_EXACT_MATCH}    ${RESPONSE_BODY_CASE_SENSITIVE}    ${RESPONSE_BODY_START_WITH}    ${RESPONSE_BODY_END_WITH}    ${RESPONSE_BODY_CONTAINS}    ${REQUEST_BODY}    ${DEPENDENT_VALUES}    ${ATTACHMENT}    ${DEPENDENT_DICT}


*** Keywords ***
Json Validator
    [Arguments]    ${TEST_NAME}    ${BASEURL_ACTION}    ${DEPENDENT_FLAG}    ${IS_DEPENDENT_FLAG_REQUIRED}    ${RELATIVE_URI}    ${REQUEST_TYPE}    ${EXCEPTED_RESPONSE_STATUS}    ${RESPONSE_BODY}    ${RESPONSE_BODY_EXACT_MATCH}    ${RESPONSE_BODY_CASE_SENSITIVE}    ${RESPONSE_BODY_START_WITH}    ${RESPONSE_BODY_END_WITH}    ${RESPONSE_BODY_CONTAINS}    ${REQUEST_BODY}    ${DEPENDENT_VALUES}    ${ATTACHMENT}    ${DEPENDENT_DICT}
    Set To Dictionary           ${headers}      Content-Type=application/x-www-form-urlencoded
    IF  "${REQUEST_TYPE}" == "GET"      JsonRequestKeywords.Build Get Request    ${BASEURL_ACTION}    ${RELATIVE_URI}    ${EXCEPTED_RESPONSE_STATUS}    ${RESPONSE_BODY_EXACT_MATCH}    ${RESPONSE_BODY}    ${RESPONSE_BODY_START_WITH}    ${RESPONSE_BODY_END_WITH}    ${RESPONSE_BODY_CONTAINS}    ${headers}    ${DEPENDENT_FLAG}    ${DEPENDENT_VALUES}    ${DEPENDENT_DICT}    ${IS_DEPENDENT_FLAG_REQUIRED}
    ...         ELSE IF  "${REQUEST_TYPE}" == "POST"     JsonRequestKeywords.Build Post Request    ${BASEURL_ACTION}    ${RELATIVE_URI}    ${EXCEPTED_RESPONSE_STATUS}    ${RESPONSE_BODY_EXACT_MATCH}    ${RESPONSE_BODY}    ${RESPONSE_BODY_START_WITH}    ${RESPONSE_BODY_END_WITH}    ${RESPONSE_BODY_CONTAINS}    ${REQUEST_BODY}    ${headers}    ${DEPENDENT_FLAG}    ${DEPENDENT_VALUES}    ${DEPENDENT_DICT}    ${IS_DEPENDENT_FLAG_REQUIRED}
    ...         ELSE IF  "${REQUEST_TYPE}" == "PUT"      JsonRequestKeywords.Build Put Request    ${BASEURL_ACTION}    ${RELATIVE_URI}    ${EXCEPTED_RESPONSE_STATUS}    ${RESPONSE_BODY_EXACT_MATCH}    ${RESPONSE_BODY}    ${RESPONSE_BODY_START_WITH}    ${RESPONSE_BODY_END_WITH}    ${RESPONSE_BODY_CONTAINS}    ${REQUEST_BODY}    ${headers}    ${DEPENDENT_FLAG}    ${DEPENDENT_VALUES}    ${DEPENDENT_DICT}    ${IS_DEPENDENT_FLAG_REQUIRED}
    ...         ELSE IF  "${REQUEST_TYPE}" == "DELETE"   JsonRequestKeywords.Build Delete Request    ${BASEURL_ACTION}    ${RELATIVE_URI}    ${EXCEPTED_RESPONSE_STATUS}    ${RESPONSE_BODY_EXACT_MATCH}    ${RESPONSE_BODY}    ${RESPONSE_BODY_START_WITH}    ${RESPONSE_BODY_END_WITH}    ${RESPONSE_BODY_CONTAINS}    ${REQUEST_BODY}    ${headers}    ${DEPENDENT_FLAG}    ${DEPENDENT_VALUES}    ${DEPENDENT_DICT}    ${IS_DEPENDENT_FLAG_REQUIRED}



