[Metadata]    Author    Owais Jilani
*** Settings ***
Library     ..${/}Library${/}S3Util.py
Library     ..${/}Library${/}CryptoService.py
Library     ..${/}Library${/}FileUtil.py
Library     Collections
Library     String

Resource    ..${/}Settings${/}config.robot

*** Keywords ***

Get files from S3 Bucket
    [Documentation]  This Keyword is used to fetch the files from the mention bucket key location
    [Arguments]      ${Key}      ${BUCKET}=${BUCKET_NAME}
    Set Log Level    NONE    # This will suppress log messages for security reasons
    ${AWSAccessKeyID}=  CryptoService.Decrypt Msg    ${AWS_ACCESS_KEY_ID}
    ${AWSSecretAccessKey}=  CryptoService.Decrypt Msg    ${AWS_SECRET_ACCESS_KEY}
    Set Log Level    INFO
    ${Files}=   S3Util.Get Files From S3        ${AWSAccessKeyID}    ${AWSSecretAccessKey}   ${BUCKET}      ${Key}
    RETURN      ${Files}

File Should Not Be Present $File $LocationKey
    [Documentation]  This Keyword is used to verify the absence of file in location specified
    [Arguments]         ${File}     ${Key}      ${BUCKET}=${BUCKET_NAME}
    ${Files}=   Get files from S3 Bucket      ${Key}  ${BUCKET}
    Should Not Contain        ${Files}       ${Key}${File}

File Should Be Present $File $LocationKey
    [Documentation]  This Keyword is used to verify the presence of file in location specified
    [Arguments]         ${File}     ${Key}      ${BUCKET}=${BUCKET_NAME}
    ${Files}=   Get files from S3 Bucket      ${Key}  ${BUCKET}
    Should Contain        ${Files}       ${Key}${File}

