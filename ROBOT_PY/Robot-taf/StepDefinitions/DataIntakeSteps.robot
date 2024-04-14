[Metadata]    Author    Owais Jilani
*** Settings ***  
Resource    ..${/}Keywords${/}DataIntakeKeywords.robot

*** Keywords ***

Get Current File For Data Intake
    [Documentation]  This Keyword is used to get the Test Case ID of currently executing test case
    @{TestCase}=    Split String    ${TEST NAME}    ${SPACE}
    ${FileID}=    Set Variable    ${TestCase}[0]
    Set Suite Variable      ${FileID}
    RETURN      ${FileID}.zip

Upload File to S3 Bucket $File $KeyLocation
    [Documentation]    Upload a file to S3 bucket location passed as an argument and Bucket is defined in config file.
    [Arguments]         ${UploadFile}     ${Key}
    ${uploadFilePath}=    FileUtil.get_resource_directory     DataIntake    ${UploadFile}
    Set Suite Variable     ${UploadKey}      ${Key}${UploadFile}
    Set Log Level    NONE    # This will suppress log messages for security reasons
    ${AWSAccessKeyID}=  CryptoService.Decrypt Msg    ${AWS_ACCESS_KEY_ID}
    ${AWSSecretAccessKey}=  CryptoService.Decrypt Msg    ${AWS_SECRET_ACCESS_KEY}
    Set Log Level    INFO
    S3Util.Upload To S3    ${AWSAccessKeyID}    ${AWSSecretAccessKey}    ${uploadFilePath}    ${BUCKET_NAME}   ${UploadKey}

Verifies whether the uploaded file have been consumed in the location $File $Key
    [Documentation]   Verifies whether the uploaded file have been consumed in the location
    [Arguments]     ${IntakeFile}   ${Key}
    Log To Console       DataIntake Started
    Wait Until Keyword Succeeds    25x    ${DELAY.MEDIUM}        File Should Not Be Present $File $LocationKey     ${IntakeFile}    ${Key}
    Log To Console       Intake Successful

Validate given Intake File is Present in specified location $File $Key
    [Documentation]    This Keyword is used to verify the presence of file in location specified
    [Arguments]     ${IntakeFile}   ${Key}
    Wait Until Keyword Succeeds    25x    ${DELAY.SHORT}        File Should Be Present $File $LocationKey     ${IntakeFile}    ${Key}

Validate Intake Logs is Present in specified location $File $Key
    [Documentation]    This Keyword is used to verify the presence of Warning file in location specified
    [Arguments]     ${IntakeFile}   ${Key}
    Wait Until Keyword Succeeds    25x    ${DELAY.SHORT}        File Should Be Present $File $LocationKey     ${IntakeFile}    ${KeyWarning}    ${REPORT_BUCKET}

Run Data Intake
    [Documentation]    Run the Data Intake by uploading the file based on the test case id of current test case in execution
    ${File}=    DataIntakeSteps.Get Current File For Data Intake
    DataIntakeSteps.Upload File to S3 Bucket $File $KeyLocation              ${File}     ${KeyInbound}
    DataIntakeSteps.Validate given Intake File is Present in specified location $File $Key    ${File}     ${KeyInbound}
    DataIntakeSteps.Verifies whether the uploaded file have been consumed in the location $File $Key   ${File}     ${KeyInbound}
    DataIntakeSteps.Validate given Intake File is Present in specified location $File $Key    ${File}     ${KeyValid}
    DataIntakeSteps.Verifies whether the uploaded file have been consumed in the location $File $Key   ${File}     ${KeyValid}

Download File to DataIntake
    [Tags]     DownloadTest
    ${AWSAccessKeyID}=  CryptoService.Decrypt Msg    ${AWS_ACCESS_KEY_ID}
    ${AWSSecretAccessKey}=  CryptoService.Decrypt Msg    ${AWS_SECRET_ACCESS_KEY}
    Set Log Level    INFO
    ${DownloadDirectory}=   FileUtil.get_resource_directory     Download
    S3Util.Download Files From S3   ${AWSAccessKeyID}    ${AWSSecretAccessKey}     ${DownloadBucket}   ${DownloadKey}   ${DownloadDirectory}${DownloadKey}