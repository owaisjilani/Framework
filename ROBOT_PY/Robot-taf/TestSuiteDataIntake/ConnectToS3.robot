[Metadata]    Author    Owais Jilani
*** Settings ***
Resource      ..${/}StepDefinitions${/}DataIntakeSteps.robot

Test Tags     DATAINTAKE   REGRESSION

#Test Setup    DataIntakeSteps.Run Data Intake

*** Test Cases ***

TC-001_S3Util Validate the Intake File
    [Tags]       IntakeTest
    [Documentation]    Upload a file to S3 bucket
    Log       Started Validation Check
    DataIntakeSteps.Validate Intake Logs is Present in specified location $File $Key      ${FileID}_warning.zip   ${KeyWarning}
    Log         Success

Download File Test
    DataIntakeSteps.Download File to DataIntake