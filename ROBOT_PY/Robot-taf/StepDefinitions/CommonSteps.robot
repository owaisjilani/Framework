[Metadata]  Author  Owais Jilani
*** Settings ***
Library     SeleniumLibrary
Library     ..${/}Library${/}FileUtil.py

Resource    ..${/}Keywords${/}AlertPageKeywords.robot
Resource    ..${/}Library${/}Util.robot
Resource    ..${/}Keywords${/}CommonKeywords.robot

*** Keywords ***
Reload Page and Wait till page is loaded
    [Documentation]   Uses selenium library keyword reload page and then waits for page loader to be not visible
    Reload Page
    Util.Wait Until Loader Is Not Visible

Get download directory path
    [Documentation]   Used to get download directory path for Download folder created in the setup
    ${DownloadDir} =   FileUtil.Get Resource Directory   Download
    Set Test Variable    ${DownloadDir}

Select Search $Priority
    [Documentation]     This Keyword is used to verify status of the Button is Selected or Not.
    [Arguments]     ${input}
    CommonKeywords.Set Search Fields    Priority    ${input}     False   False
    CommonKeywords.Verify Button Type Search Field Selected   Priority  ${input}

Click Confirm Button
    [Documentation]   Used to click on confirm button containing text as confirm
    CommonKeywords.Click Confirm Button

Get data under provided column header from given row
    [Documentation]   Gets the value present in a row for provided column header
    [Arguments]   ${ColumnName}   ${RowNumber}
    ${ColumnValue}   CommonKeywords.Get data under provided column header from given row   ${ColumnName}   ${RowNumber}
    RETURN   ${ColumnValue}

Get data under provided column header
    [Documentation]   Gets the value present provided column header for first page
    [Arguments]     ${columnname}
    ${ColumnValue}   CommonKeywords.Get table column data in list format    ${columnname}
    RETURN  ${ColumnValue}

Get data under provided column header for all
    [Documentation]   Get the data for specific column. locator passed should be a common locator for all column elements under a column
    [Arguments]     ${ColumnValuesLocator}
    ${ColumnValue}   CommonKeywords.Get table column data in list format for all    ${ColumnValuesLocator}
    RETURN  ${ColumnValue}

Clear Search $Source
    CommonKeywords.Set Search Fields    Source    Fraud|AML   False   False


Select Search $Source
    [Documentation]     This Keyword is used to Select and verify the Button Source is Selected or Not .
    [Arguments]     ${input}
    Clear Search $Source
    CommonKeywords.Set Search Fields    Source    ${input}     False   False
    CommonKeywords.Verify Button Type Search Field Selected   Source  ${input}

DeSelect Search $Source
    [Documentation]     This Keyword is used to Deselect the Button Source .
    [Arguments]     ${input}
    CommonKeywords.Set Search Fields    Source    ${input}     False   False

Get Date Created from Alert/Case Table
    [Documentation]     Get the Date Created value from visible Alert/Case table
    AlertPageKeywords.Wait for Alert Page Search Table to be Visible
    CommonKeywords.Get Date Created from Alert/Case Table
    RETURN      ${dateCreated}

Verify Search Fields are cleared after clicking on Clear All button
    [Documentation]      Verify All the search fields should get cleared when clicking on clear all button else the keyword will fail.
    CommonKeywords.Verify Search Fields are cleared after clicking on Clear All button

Validate if Opened Dropdown isMultiSelect
    [Documentation]     This keyword is employed to verify the dropdown is multiselect
    CommonKeywords.Validate if Opened Dropdown isMultiSelect

Click on Date Created button
    [Documentation]     This Keyword is used to open the Date Created calendar.
    Util.Click_Element_Custom           ${oAlertsSearchDateButton}

Click On Maximize/Minimize Button in Search Section
    CommonKeywords.Click On Maximize/Minimize Button in Search Section

Click on Add Account Notes Button
    [Documentation]     This Keyword is used to Click on Add Account Notes Button
    CommonKeywords.Click on Add Account Notes Button

Add Account Notes to Alert/Case
    [Documentation]     This Keyword is used to Add Account Notes with Custome Notes Text in ALerts/Cases
    [Arguments]     ${AccountNotesText}
    CommonKeywords.Add Account Notes to Alert/Case  ${AccountNotesText}

Cancel Account Notes to Alert/Case
    [Documentation]     This Keyword is used to Close the Pop up of an opened account notes
    [Arguments]     ${AccountNotesText}
    CommonKeywords.Cancel Account Notes to Alert/Case  ${AccountNotesText}

Validate the latest Added Account Notes
    [Documentation]     This Keyword is used to validate the added notes with details such as User who add's it, Notes added Time in UTC and the notes text
    [Arguments]        ${USER}    ${ExpectedText}
    CommonKeywords.Validate the latest Added Account Notes     ${USER}    ${ExpectedText}

Validate the Cancel Account Notes
    [Documentation]     This Keyword is used to validate whether the notes pop up is closed after cancelling it
    [Arguments]         ${ExpectedText}
    CommonKeywords.Validate the Cancel Account Notes    ${ExpectedText}

Verify the Maximum Account Notes Limit with Msg
    [Documentation]    This Keyword is used to validate the message when account addition limit reached which is 10 currently
    [Arguments]        ${errorMsg}
    CommonKeywords.Verify the Maximum Account Notes Limit with Msg      ${errorMsg}

Get Account notes count
    [Documentation]     This Keyword is used to get the current count of notes present.
    CommonKeywords.Get Account notes count

Add custom number of account notes $limit
    [Documentation]     This Keyword is used to add the total number of notes following argument and notes text provided default limit set to 10 which is the maximum capacity.It will break the execution after adding Maximum Notes if the capacity exceeds the current availability of an account notes.
    [Arguments]              ${customNotesSummary}      ${accountNotesAddLimit}=10
    ${accountNotesPresent}=  CommonKeywords.Get Account notes count
    IF    ${accountNotesPresent} == 10
          CommonKeywords.Click on Add Account Notes Button
          CommonKeywords.Verify the Maximum Account Notes Limit with Msg      ${pAccountNotesLimitMsg}
    ELSE
        ${isEligibleToAdd}=    Evaluate    ${accountNotesAddLimit} + ${accountNotesPresent}
            IF     ${isEligibleToAdd} <= 10
                   ${remainingCount}=     Evaluate    ${isEligibleToAdd} - ${accountNotesPresent}
                   FOR    ${i}    IN RANGE    ${remainingCount}
                       CommonKeywords.Click on Add Account Notes Button
                       CommonKeywords.Add Account Notes to Alert/Case     ${customNotesSummary}:${tdAppendBeyondLimit}:${i}
                       Wait Until Element Is Enabled     ${oAlertsAccountNotesUsernameText}
                   END
            ELSE
                    ${remainingCount}=     Evaluate    ${accountNotesAddLimit} - ${accountNotesPresent}
                     FOR    ${i}    IN RANGE    ${remainingCount}
                         CommonKeywords.Click on Add Account Notes Button
                         CommonKeywords.Add Account Notes to Alert/Case     ${customNotesSummary}:${tdAppendBeyondLimit}:${i}
                         Wait Until Element Is Enabled     ${oAlertsAccountNotesUsernameText}
                     END
                     CommonKeywords.Click on Add Account Notes Button
                     CommonKeywords.Verify the Maximum Account Notes Limit with Msg      ${pAccountNotesLimitMsg}
                     Log   User can't Add Account Notes more that 10
            END
    END

Verify the account notes summary should not exceed 1000 character
    [Documentation]     This Keyword is used to verify the characters limit of account notes when added.
    [Arguments]     ${notesExpected}
    CommonKeywords.Verify the account notes summary should not exceed 1000 character     ${notesExpected}

Validate Free Form Search Box Field
    [Arguments]   ${searchInputFieldName}   ${input}
    CommonKeywords.Validate Free Form Search Box Field     ${searchInputFieldName}   ${input}

Close Search Section
    CommonKeywords.Close Search Section

Skip Test If Search Results Are Empty
    [Documentation]   This keyword should only be used post search results***
    CommonKeywords.Skip Test If Search Results Are Empty

Wait until page is loaded
    [Documentation]   waits for page loader to be not visible
    Util.Wait Until Loader Is Not Visible

Validate that given textfields are empty
    [Documentation]   Gets text from the given locator elements and compares it with empty string
    [Arguments]   @{TextfieldLocatorsList}
    CommonKeywords.Validate that given textfields are empty   @{TextfieldLocatorsList}

Generate and get a random name with prefix and input into the textfield
    [Documentation]   Used to create a random name with provided prefix and inputs the text into the textfield identified by the locator
    [Arguments]   ${Prefix}   ${TextfieldLocator}
    ${Name} =   Util.Generate a random Name with Prefix   ${Prefix}
    Input Text    ${TextfieldLocator}    ${Name}
    RETURN   ${Name}

Get Table data in dictionary format as Column Name Row Value pair for following Table Row in a table
    [Documentation]   This keyword works on all tables. Pass the row number of which value is required
    [Arguments]   ${RowNumber}   ${RowCommonLocator}
    ${TableRowDict} =   CommonKeywords.Get Table data in dictionary format as Column Name Row Value pair for following Table Row in a table   ${RowNumber}   ${RowCommonLocator}
    RETURN   ${TableRowDict}

Press back button on the browser and wait until page is loaded
    [Documentation]   Uses selenium library to simulate the back action and then waits for page to load
    CommonKeywords.Press back button on the browser and wait until page is loaded

Compare Two Lists By Ignoring Order
    [Documentation]   Compares two lists by using python code by ignoring the order of elements
    [Arguments]    ${ACT_LIST}     ${EXP_LIST}
    CommonKeywords.Compare Two Lists By Ignoring Order    ${ACT_LIST}     ${EXP_LIST}

Get Sorted list from given list
    [Documentation]   Keeps original list intact. Creates a copy of the list, sorts it and returns the same
    [Arguments]   ${ListToBeSorted}
    ${SortedList} =   CommonKeywords.Get Sorted list from given list   ${ListToBeSorted}
    RETURN   ${SortedList}
