[Metadata]    Author    Owais Jilani
*** Settings ***
Library     SeleniumLibrary
Library     ..${/}Library${/}CustomLibrary.py

Resource    ..${/}Library${/}Util.robot

Variables   ..${/}PageObjects${/}Locators${/}CommonLocators.py
Variables   ..${/}Resources${/}TestDataUI${/}CommonTD.py

*** Keywords ***
Click Confirm Button
    [Documentation]   Used to click on confirm button containing text as confirm
    Element Should be Enabled   ${oConfirmButtonXpath}
    Util.Click_Button_Text_Custom    ${oConfirmButton}
    Wait Until Keyword Succeeds    ${DELAY.VERYLONG}    ${DELAY.SHORT}   Wait Until Page Does Not Contain Element   ${oConfirmButtonXpath}

Set Search Fields
    [Arguments]     ${locator_key}  ${input}    ${isDropdown}=False     ${isCheckboxDropdown}=False
    ${isDropdown}=  Convert To Boolean    ${isDropdown}
    ${isCheckboxDropdown}=  Convert To Boolean    ${isCheckboxDropdown}
    ${locator}=     Util.Update_Locator    ${oSearchFields}    ${locator_key}
    ${dropdownCloseButton}=     Util.Update_Locator    ${oDropdownCloseButton}    ${locator_key}

    ${isMultipleInput}=    Set Variable     False
    IF    '|' in $input
        ${input}=   Split String    ${input}    |
        ${isMultipleInput}=   Set Variable   True
    END
    IF  ${isDropdown} is False and ${isCheckboxDropdown} is False
        IF    ${isMultipleInput}
             FOR    ${input_value}    IN    @{input}
                ${input_value}=     Strip String    ${input_value}
                Util.Click_Element_By_Partial_Text_Custom    ${locator}     ${input_value}
             END
        ELSE
            Util.Click_Element_By_Text_Custom    ${locator}     ${input}
        END
    ELSE
        Wait Until Page Contains Element   ${locator}
        Click Element    ${locator}
    END

    IF    ${isDropdown}
        Util.Click_Element_By_Text_Custom    ${oSearchFieldDropdown}     ${input}
    ELSE IF     ${isCheckboxDropdown}
        IF    ${isMultipleInput}
             FOR    ${input_value}    IN    @{input}
                ${input_value}=     Strip String    ${input_value}
                Util.Click_Element_By_Partial_Text_Custom    ${oSearchFieldCheckbox}     ${input_value}
             END
        ELSE
            ${isElementTextPresent}=    Is_Element_By_Text_Present_In_The_Page_Custom     ${oSearchFieldCheckbox}     ${input}
            IF    ${isElementTextPresent}
                Util.Click_Element_By_Text_Custom    ${oSearchFieldCheckbox}     ${input}
            ELSE
                Util.Click_Element_By_Partial_Text_Custom    ${oSearchFieldCheckbox}     ${input}
            END
        END
        Press Keys      None     ESC
    END

Verify Button Type Search Field Selected
    [Documentation]     This Keyword is used to verify status of the Button is Selected or Not.
    [Arguments]     ${locator_key}  ${input}
    ${locator}=     Util.Update_Locator    ${oSearchFieldTypeButtonSelStatusCheck}    ${locator_key}
    ${isSearchFieldButtonSelected}=     Util.Get_Element_Attribute_From_WebElements_Custom   ${locator}  ${input}   aria-selected
    IF    '${isSearchFieldButtonSelected}' == 'false'
         Fail   Unable to select search field button ${input}!!!
    END

Validate that element is disabled
    [Documentation]   Validates that passed element is disabled
    [Arguments]       ${ElementLocator}
    Wait Until Keyword Succeeds    3x    ${DELAY.SHORT}   Element Should Be Disabled   ${ElementLocator}

Validate that element is enabled
    [Documentation]   Validates that passed element is enabled
    [Arguments]       ${ElementLocator}
    Element Should Be Enabled   ${ElementLocator}

Get Table data in dictionary format as Column Name Row Value pair for following Table Row
    [Documentation]   This keyword works on Cases and Alerts table. Not checked on others. The Resolution column is ignored currently because if the column data is empty, it does not return a blank value. Pass the row number of which value is required
    [Arguments]   ${RowNumber}
    ${RowIndex} =   Evaluate    ${RowNumber}+1
    ${Row}   Convert To String   ${RowIndex}
    ${Headers} =   Util.Get Row Values by ignoring a column   ${oTableHeaderRow}   ${pIgnoreColumnResolution}   ignoreCol=False
    ${CommonRowLocator} =   Util.Update_Locator    ${oAlertsTableRowCommon}    ${Row}
    ${Values} =   Util.Get Column Values   ${CommonRowLocator}   ignoreCol=False
    ${DICT}   Util.Create Dictionary from Lists   ${Headers}  ${Values}
    RETURN   ${DICT}

Get Table data in dictionary format as Column Name Row Value pair for following Table Row in a table
    [Documentation]   This keyword works on all tables. Pass the row number of which value is required
    [Arguments]   ${RowNumber}   ${RowCommonLocator}
    ${RowIndex} =   Evaluate    ${RowNumber}+1
    ${Row}   Convert To String   ${RowIndex}
    ${Headers} =   Util.Get Row Values by ignoring a column   ${oTableHeaderRow}   ${pIgnoreColumnResolution}   ignoreCol=False
    ${GivenRowLocator} =   Util.Update_Locator    ${RowCommonLocator}    ${Row}
    ${Values} =   Util.Get Column Values   ${GivenRowLocator}   ignoreCol=False
    ${DICT}   Util.Create Dictionary from Lists   ${Headers}  ${Values}
    RETURN   ${DICT}

Get Date Created from Alert/Case Table
    [Documentation]     Get the Date Created value from visible Alert/Case table
    ${dateCreated}=  Get Text    ${oTableDateCreatedText}
    Set Suite Variable    ${dateCreated}

Verify Search Fields are cleared after clicking on Clear All button
    [Documentation]      Verify All the search fields should get cleared when clicking on clear all button else the keyword will fail.
    ${ACT_FIELDS_VALUE_LIST}=    Util.Get_WebElements_Values_List_Custom     ${oInputValueLocator}     value
    Should Be Empty       ${ACT_FIELDS_VALUE_LIST}

Select List Option By $Value
    [Documentation]     Selects the Opened Dropdown List By Visible Text
    [Arguments]         ${Value}
    Util.Select List Option By Text   ${Value}

Select User From List With $Role
    [Documentation]     This keyword is utilized to select the value in the Open Dropdown that matches the user role passed as an argument.
    [Arguments]     ${Role}
    ${User} =  Catenate    ${${Role}_USER.FNAME} ${${Role}_USER.LNAME}
    CommonKeywords.Select List Option By $Value     ${User}

Validate if Opened Dropdown isMultiSelect
    [Documentation]     This keyword is employed to verify the dropdown is multiselect
    ${status} =    Run Keyword and Return Status     Wait Until Element is Visible   ${oMultiSelectListCheckbox}
    Run Keyword and Continue on Failure  Should Be True     ${status}    msg=Not a Multi Select DropDown
    Util.Press Tab Key    ${oLogo}
    Run Keyword And Ignore Error     Wait Until Element is not Visible   ${oMultiSelectListCheckbox}

Get Count of Checked checkboxes
    [Documentation]   Gets the count of checked checkboxes
    ${count} =   Get Element Count   ${oCheckedCheckbox}
    RETURN   ${count}

Select given number of checkboxes from table $Number
    [Documentation]   Selects the given number of checkboxes if all the checkboxes have common locator declared in common locators file
    [Arguments]   ${NoOfCheckboxes}
    Wait Until Page Contains Element   ${oTableCommonCheckbox}
    ${Count} =   Get Element Count   ${oTableCommonCheckbox}
    ${CheckboxesCount} =   Convert To Integer   ${NoOfCheckboxes}
    IF    $Count < $CheckboxesCount
        Fail   Test Data is not enough. Please create more test data and try again.
    END
    Util.Set Page Zoom Level   65
    FOR    ${index}    IN RANGE    1   ${NoOfCheckboxes}+1
        Wait Until Element Is Visible   (${oTableCommonCheckbox})[${index}]
        Click Element by Javascript   (${oTableCommonCheckbox})[${index}]
    END
    Util.Set Page Zoom Level   100

Click on Audit Tab
    [Documentation]   Clicks on Audit tab
    Wait Until Page Contains Element   ${oAuditTab}
    Click Element   ${oAuditTab}

Validate audit log contains status update from $Status1 To $Status2
    [Documentation]   Appends the passed statuses to the expected assign status list and validates that audit table has these values
    [Arguments]   ${AuditAssignStatusList}   ${Status1}   ${Status2}
    Wait Until Page Contains Element    ${oAuditTableElements}
    ${AuditTable_AllValuesList} =   Util.Get List Values   ${oAuditTableElements}
    Append To List   ${AuditAssignStatusList}   ${Status1}   ${Status2}
    List Should Contain Sublist   ${AuditTable_AllValuesList}   ${AuditAssignStatusList}

Click on Cancel Button
    [Documentation]   Generic keyword for clicking on cancel button from various pages like alert comments, Assign for popup and Close Case popup
    Click Button   ${oCancelButtonG}
    Wait Until Page Does Not Contain Element   ${oCancelButtonG}

Update given text into locator and click on Element
    [Documentation]   Updates the given text into the common element locator passed as argument and clicks on the updated locator
    [Arguments]   ${CommonLocator}   ${Text}
    ${Updated_locator} =   Util.Update_Locator   ${CommonLocator}   ${Text}
    Click Element   ${Updated_locator}

Validate Checkbox Functionality
    [Documentation]   Validates that the checkbox with locator is present on page and checks if user can select and unselect it. In current scenario, many checkboxes
    ...               with input tags are not getting the click directly instead the click is going to label. Hence Gave Element Receiving click option
    [Arguments]   ${CheckboxLocator}   ${ElementReceivingClick}=default
    Page Should Contain Checkbox        ${CheckboxLocator}
    ${Status} =   Run keyword And Return Status   Select Checkbox   ${CheckboxLocator}
    IF    ${Status}
        Select Checkbox   ${CheckboxLocator}
    ELSE
        Click Element   ${ElementReceivingClick}
    END
    Checkbox Should Be Selected         ${CheckboxLocator}
    IF    ${Status}
        Unselect Checkbox   ${CheckboxLocator}
    ELSE
        Click Element   ${ElementReceivingClick}
    END
    Checkbox Should Not Be Selected     ${CheckboxLocator}

Select/Unselect All checkboxes
    [Documentation]   Selects/deselects all checkboxes identifies by common locator. If checkbox is not checked, it will check it and if it is checked, this keyword will uncheck it
    [Arguments]   ${CheckboxesCommonLocator}
    ${Count} =   Get Element Count   ${CheckboxesCommonLocator}
    IF    $Count == 0
         Fail   No checkboxes displayed on the screen
    END
    FOR    ${index}    IN RANGE    1   ${Count}+1
        Wait Until Element Is Visible   (${CheckboxesCommonLocator})[${index}]
        Click Element by Javascript   (${CheckboxesCommonLocator})[${index}]
    END

Check Search and Advance Search Field Names
    [Documentation]     Logic to Validate all the Search and Advance Search Field Names and Buttons in Cases/Alert Search Section
    [Arguments]      ${oSearchAdvSearchLocator}   @{search_fields}
    ${isSearchFieldPresent}=    Set Variable    False
    ${available_search_fields}=    Get WebElements    ${oSearchAdvSearchLocator}
    FOR  ${field}  IN  @{search_fields}
        FOR  ${available_field}  IN  @{available_search_fields}
            ${text}=    Get Text    ${available_field}
            IF  $text == $field
                ${isSearchFieldPresent}=    Set Variable    True
                BREAK
            END
        END
        IF    ${isSearchFieldPresent} is False
            Fail    Search field is not present: ${field}!!!
        END
    END

Validate Search Field Names
    [Documentation]     Validates Search Field Names in Cases or Alert Search Section
    [Arguments]     @{search_fields}
    CommonKeywords.Check Search and Advance Search Field Names  ${oSearchAdvSearchFieldsName}      @{search_fields}

Validate Advance Search Field Names
    [Documentation]     Validates Advance Search Field Names in Cases or Alert Advance Search Section
    [Arguments]     @{adv_search_fields}
    CommonKeywords.Check Search and Advance Search Field Names  ${oSearchAdvSearchFieldsName}      @{adv_search_fields}

Validate Search Section Buttons
    [Documentation]     Validates Search Field Button Names in Cases or Alert Search Section
    [Arguments]     @{search_Buttons}
    CommonKeywords.Check Search and Advance Search Field Names   ${oSearchAdvSearchFieldsName}     @{search_Buttons}

Validate Search Type Names
    [Documentation]     Validates Search Types(Normal and Advance Search) Names in Cases or Alert Search Section
    [Arguments]     @{search_types}
    CommonKeywords.Check Search and Advance Search Field Names         ${oSearchTypeNames}    @{search_types}

Click on Add Account Notes Button
    [Documentation]   This Keyword is used to click on Add Account Notes button on Account Notes Tab
    Util.Wait Until Loader Is Not Visible
    Util.Click_Button_Text_Custom       ${oAddAccountNotesButton}

Add Account Notes to Alert/Case
    [Documentation]     This Keyword is used to Add Account Notes with Custome Notes Text in ALerts/Cases
    [Arguments]     ${AccountNotesText}
    Wait Until Page Contains Element    ${oAccountNotesInput}
    Input Text    ${oAccountNotesInput}   ${AccountNotesText}
    Util.Click_Button_Text_Custom    ${oAddButton}

Cancel Account Notes to Alert/Case
    [Documentation]     This Keyword is used to Close the Pop up of an opened account notes
    [Arguments]     ${AccountNotesText}
    Wait Until Page Contains Element    ${oAccountNotesInput}
    Input Text    ${oAccountNotesInput}   ${AccountNotesText}
    Util.Click_Button_Text_Custom       ${ocancelButtonC}

Validate the latest Added Account Notes
    [Documentation]     This Keyword is used to validate the added notes with details such as User who add's it, Notes added Time in UTC and the notes text
    [Arguments]        ${USER}    ${ExpectedText}
    Wait Until Element Is Enabled   ${oAlertsAccountNotesUsernameText}
    ${AccountNotesUsernameText}=    Util.Get nth element     ${oAlertsAccountNotesUsernameText}
    ${Username} =       Get Text    ${AccountNotesUsernameText}
    ${Username} =       Util.Removing Whitespaces from String    ${Username}
    ${AccountNotesDateText}=        Util.Get nth element     ${oAlertsAccountNotesDateText}
    ${DateTime} =       Get Text    ${AccountNotesDateText}
    Run Keyword and Continue on Failure     Should Be Equal As Strings    ${Username}     ${${USER}_USER.FNAME} ${${USER}_USER.LNAME}     ignore_case=True
    ${AccountNotesText}=        Util.Get nth element     ${oAlertsNotesText}
    ${NotesText} =    Get Text      ${AccountNotesText}
    Run Keyword and Continue on Failure     Should Be Equal As Strings                           ${NotesText}     ${ExpectedText}
    ${CurTime}=         Util.Get Current Date in MM/DD/YYYY,HH:MM UTC Format
     Run Keyword and Continue on Failure    Should Be Equal As Strings                           ${DateTime}     ${CurTime}

Validate the Cancel Account Notes
    [Documentation]     This Keyword is used to validate whether the notes pop up is closed after cancelling it
    [Arguments]       ${ExpectedText}
    Wait Until Element Is Enabled       ${oAlertsAccountNotesUsernameText}
    ${NotesText} =    Get Text          ${oAlertsNotesText}
    Should Not Contain   ${NotesText}   ${ExpectedText}

Verify the Maximum Account Notes Limit with Msg
    [Documentation]    This Keyword is used to validate the message when account addition limit reached which is 10 currently
    [Arguments]        ${errorMsg}
    Wait Until Element Is Visible           ${oAccountNotesLimitMsgLocator}
    ${actualErrorMsgText} =    Get Text     ${oAccountNotesLimitMsgLocator}
    Should Be Equal As Strings   ${actualErrorMsgText}   ${errorMsg}

Get Account notes count
    [Documentation]     This Keyword is used to get the current count of notes present.
    Run Keyword And Ignore Error   Wait Until Element Is Visible   ${oAlertsAccountNotesList}
    ${length}=  Get Element Count   ${oAlertsAccountNotesList}
    RETURN    ${length}

Verify the account notes summary should not exceed 1000 character
    [Documentation]     This Keyword is used to verify the characters limit of account notes when added.
    [Arguments]     ${ExpectedText}
    Wait Until Element Is Enabled     ${oAlertsAccountNotesUsernameText}
    ${NotesText} =    Get Text        ${oAlertsNotesText}
    Should Be Equal As Strings    ${NotesText}    ${ExpectedText}

Select passed values in multiselect dropdown
    [Documentation]     This works on all multiselect dropdowns. It Selects the passed values in the dropdown. The dropdown must have multiple checkboxes
    [Arguments]         @{MultiselectOptions}
    Wait Until Page Contains Element   ${oMultiselectCommonText}
    FOR    ${MultiselectOption}    IN    @{MultiselectOptions}
        Util.Click_Element_By_Innertext_Custom   ${oMultiselectCommonText}   ${MultiselectOption}
    END
    Util.Press Tab Key    ${oLogo}

Get data under provided column header from given row
    [Documentation]   Gets the value present in a row for provided column header
    [Arguments]   ${ColumnName}   ${RowNumber}
    ${Dict} =   CommonKeywords.Get Table data in dictionary format as Column Name Row Value pair for following Table Row   ${RowNumber}
    ${ColumnValue}   Get From Dictionary   ${Dict}   ${ColumnName}
    RETURN  ${ColumnValue}

Get table column data in list format
    [Documentation]   Get the data for specific column
    [Arguments]   ${columnname}
    ${oTableColumn}=     Util.Update_Locator    ${oiSearchTableColumn}    ${columnname}
    ${Values} =   Util.Get Column Values   ${oTableColumn}    ignoreCol=False
    RETURN   ${Values}

Get table column data in list format for all
    [Documentation]   Get the data for specific column. locator passed should be a common locator for all column elements under a column
    [Arguments]   ${ColumnValuesLocator}
    ${Values} =   Util.Get Column Values   ${ColumnValuesLocator}    ignoreCol=False
    RETURN   ${Values}

Click On Maximize/Minimize Button in Search Section
    Wait Until Element Is Visible    ${oSearchMaximizeButton}    ${DELAY.MEDIUM}
    Wait Until Keyword Succeeds    3x    ${DELAY.SHORT}    Click Element                    ${oSearchMaximizeButton}

Close Search Section
    Wait Until Element Is Visible    ${oSearchSectionCloseButton}    ${DELAY.MEDIUM}
    Wait Until Keyword Succeeds    3x    ${DELAY.SHORT}    Click Element                    ${oSearchSectionCloseButton}

Validate Free Form Search Box Field
    [Documentation]   Validates Free Form Search Box - Delete, Cut and Paste Input Field Text
    [Arguments]   ${searchInputFieldName}   ${input}
    ${locator}=     Util.Update_Locator    ${oSearchInputFields}    ${searchInputFieldName}
    Input Text    ${locator}   ${input}
    CommonKeywords.Assert Free Form Input Field Value  ${locator}   ${input}
    Press Keys    ${locator}   CTRL+A  BACKSPACE
    CommonKeywords.Assert Free Form Input Field Value  ${locator}   None
    Input Text    ${locator}   ${input}
    Press Keys    ${locator}   CTRL+A+X
    Press Keys    ${locator}   CTRL+A+V
    CommonKeywords.Assert Free Form Input Field Value  ${locator}   ${input}

Assert Free Form Input Field Value
    [Arguments]   ${locator}   ${expectedValue}
    ${inputFieldValue} =    Get Element Attribute    ${locator}    value
    IF    '${inputFieldValue}' == ''
         ${inputFieldValue} =    Set Variable   None
    END
    Should Be Equal     ${inputFieldValue}  ${expectedValue}

Are Search Results Available
    [Documentation]   This keyword should only be used post search results***
    ${noTableData} =    Get Element Count    ${oNoTableDataText}
    ${areResultsEmpty}=  Set Variable    False
    IF    ${noTableData} != 1
        ${areResultsEmpty}=  Set Variable    True
    END
    RETURN    ${areResultsEmpty}

Are Search Results Empty
    [Documentation]   This keyword should only be used post search results***
    ${noTableData} =    Get Element Count    ${oNoTableDataText}
    ${areResultsEmpty}=  Set Variable    False
    IF    ${noTableData} == 1
        ${areResultsEmpty}=  Set Variable    True
    END
    RETURN    ${areResultsEmpty}

Skip Test If Search Results Are Empty
    [Documentation]   This keyword should only be used post search results***
    ${areSearchResultsEmpty}=   CommonKeywords.Are Search Results Empty
    Set Suite Variable  ${areSearchResultsEmpty}
    IF  ${areSearchResultsEmpty}
        SKIP    No Search results available!
    END

Validate that given textfields are empty
    [Documentation]   Gets text from the given locator elements and compares it with empty string
    [Arguments]   @{TextfieldLocatorsList}
    FOR    ${element}    IN    @{TextfieldLocatorsList}
        ${text} =   Get Value   ${element}
        Should Be Equal As Strings    ${text}    ${EMPTY}
    END

Validate that given textfields are editable
    [Documentation]   Validates that given textfield is visible and enabled and also it accepts text
    [Arguments]   @{TextfieldLocatorsList}
    FOR    ${element}    IN    @{TextfieldLocatorsList}
        ${Status1} =   Run Keyword And Return Status   Element Should Be Visible   ${element}
        ${Status2} =   Run Keyword And Return Status   Element Should Be Enabled   ${element}
        IF    ${Status1} and ${Status2}
            Log     Given Textfield with locator: ${element} is editable
        ELSE
            Fail    Given Textfield with locator: ${element} is not editable
        END
    END

Validate the Character Limit of Input Field
    [Documentation]     Validates that the input field does not accept more characters than its limit
    [Arguments]         ${inputFieldLocator}   ${maxLimit}
    ${exceedingStringLength} =   Evaluate   ${maxLimit} + 1
    ${exceeding_input} =   Generate Random String    ${exceedingStringLength}
    Input Text    ${inputFieldLocator}    ${exceeding_input}
    ${input_value} =   Get Value       ${inputFieldLocator}
    ${input_length} =   Get Length      ${input_value}
    Should Be True    ${input_length} <= ${maxLimit}

Input Value in textfield after clearing it
    [Documentation]   Used to enter value into textfield of type input after clearing the textfield
    [Arguments]   ${ElementLocator}   ${InputValue}
    Input Text   ${ElementLocator}   ${InputValue}   clear=True

Press back button on the browser and wait until page is loaded
    [Documentation]   Uses selenium library to simulate the back action and then waits for page to load
    Go Back
    Util.Wait Until Loader Is Not Visible

User clicks on button $Button
    [Documentation]   Used to click on any button which has locator of this type: //span[text()='$LOCATOR_DYNAMIC_PARAM$']/parent::button. $LOCATOR_DYNAMIC_PARAM$ being the button text
    [Arguments]   ${ButtonName}
    ${UpdatedLocatorButton} =   Util.Update_Locator   ${oButtonCommon}   ${ButtonName}
    Wait Until Page Contains Element    ${UpdatedLocatorButton}
    Click Element by Javascript   ${UpdatedLocatorButton}

Compare Two Lists By Ignoring Order
    [Documentation]   Compares two lists by using python code by ignoring the order of elements
    [Arguments]    ${ACT_LIST}     ${EXP_LIST}
    ${Result} =   CustomLibrary.Compare Two Lists By Ignoring Order   ${ACT_LIST}     ${EXP_LIST}
    IF   ${Result} == False
        Fail   The Lists do not match
    ELSE
        Log   provided lists match
    END

Get Sorted list from given list
    [Documentation]   Keeps original list intact. Creates a copy of the list, sorts it and returns the same
    [Arguments]   ${ListToBeSorted}
    ${SortedList} =   Copy List   ${ListToBeSorted}
    Sort List   ${SortedList}
    RETURN   ${SortedList}
