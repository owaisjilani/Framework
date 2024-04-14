[Metadata]    Author    Owais Jilani
*** Settings ***  
Library     OperatingSystem
Library     SeleniumLibrary
Library     String
Library     Collections
Library     DateTime
Library     Csv.py
Library     CustomLibrary.py

Resource    ..${/}Settings${/}config.robot
Resource    ..${/}Keywords${/}CommonKeywords.robot

Variables    ..${/}PageObjects${/}Locators${/}CommonLocators.py     #The Locators of Util File Need to be Refactor
Variables    ..${/}PageObjects${/}PageText${/}Common.py


*** Keywords ***  
Click On Element
    [Arguments]    ${element}
    Wait Until Element Is Enabled    ${element}    ${DELAY.SHORT}
    Wait Until Keyword Succeeds    3x    ${DELAY.SHORT}    Execute JavaScript    arguments[0].click()    ${element}

Click Item
    [Arguments]    ${element}
    Wait Until Element Is Visible        ${element}
    Wait Until Keyword Succeeds    3x    ${DELAY.SHORT}    Click Element    ${element}
    Press Tab Key    ${oLogo}

Input Text Field
    [Arguments]  ${locator}    ${text}
    Wait Until Element Is Enabled    ${locator}
    Click Element                    ${locator}
    Input Text            ${locator}        ${text}
    Press Tab Key         ${oLogo}

Select Button If Not Selected
    [Arguments]      ${element}
    ${value}=  Get Element Attribute    ${element}    aria-selected 
    IF   '${value}'=='false'     # This is a string, not a boolean
         Click Item    ${element}
         Wait Until Element Is Enabled    ${element}
         ${attrubute_value}    Get Element Attribute    ${element}    aria-selected
         Should Be Equal As Strings    ${attrubute_value}    True     msg=Item Selection FAILED     ignore_case=True
    END 

Generate large string
    ${huge_password}=    Generate Random String    50000     [NUMBERS]
    Set test variable   ${huge_password}
    
Press Enter Key
    [Documentation]    Pressing Enter Key here
    [Arguments]   ${locator}
    Press Keys    ${locator}    RETURN

Press Tab Key
    [Documentation]    Pressing Tab Key here
    [Arguments]        ${locator}
    Press Keys    ${locator}    Tab

Press ESC Key
    [Documentation]    Pressing ESC Key here
    [Arguments]        ${locator}
    Execute JavaScript    arguments[0].blur()    ${locator}
    Press Keys    ${locator}    \\27  

Clear browser local storage
    Set Suite Variable  ${Logged Username}        None
    Execute Javascript  localStorage.clear()

Evaluate Substring between Square Brackets
    [Arguments]        ${Text}
    ${start_index}=    Evaluate    "${Text}".find("[")
    ${end_index}=      Evaluate    "${Text}".find("]")
    ${sub_string}=      Evaluate    "${Text}"[${start_index+1}:${end_index}]
    ${output} =    Set Variable    ${sub_string.strip()}  
    RETURN    ${output}

Get List Values
    [Arguments]    ${element}
    ${values} =    Create List
    ${LIST} =    Get WebElements    ${element}
    FOR    ${el}    IN    @{LIST}
        Run Keyword And Ignore Error    Scroll Element Into View    ${el}
        ${text} =    Get Text    ${el}
        #Check for [] and Find Substring out of it
        ${status}=    Run Keyword And Return Status    Should Contain    ${text}    [
        ${result}=  Run Keyword If    ${status}==True    Evaluate Substring between Square Brackets  ${text}
        ...    ELSE
        ...    Removing Whitespaces from String   ${text}
        # Append the cleaned text to the list
        Append To List    ${values}    ${result}
    END
    RETURN    ${values}

Get Column Values
    [Arguments]    ${element}    ${ignoreCol}
    ${values} =    Create List
    #${status}=     Set Variable    False 
    ${LIST} =    Get WebElements    ${element}
    FOR    ${el}    IN    @{LIST}
        ${text} =    Get Element Attribute    ${el}    innerText
        ${result}     Removing Whitespaces from String   ${text}
        ${status}=    IF    ${ignoreCol}   Run Keyword And Return Status    List Should Contain Value     ${pIgnoreColumn}     ${text}
        IF      ${status}    Continue For Loop     
        ...     ELSE         Run Keyword     Append To List    ${values}    ${text} 
        
    END
    RETURN    ${values}

Get Row Values by ignoring a column
    [Documentation]   Gets the values from a row. It could be either column header row or data row. Just pass common locator for all row elements. Also if we want to ignore some data2, we need to pass that data/column with ignore column value as True
    [Arguments]    ${element}    ${ColumnToBeIgnored}   ${ignoreCol}=False
    ${values} =    Create List
    ${LIST} =    Get WebElements    ${element}
    FOR    ${el}    IN    @{LIST}
        ${text} =    Get Element Attribute    ${el}    innerText
        ${result}     Removing Whitespaces from String   ${text}
        ${status}=    IF    ${ignoreCol}   Run Keyword And Return Status    List Should Contain Value     ${ColumnToBeIgnored}     ${text}
        IF      ${status}    Continue For Loop
        ...     ELSE         Run Keyword     Append To List    ${values}    ${text}
    END
    RETURN    ${values}

Removing Whitespaces from String
    [Arguments]     ${Raw_string}
    ${output} =    Set Variable    ${Raw_string.strip()}  
    RETURN    ${output}  

Wait Until Loader Is Not Visible
    [Arguments]        ${timeOut}=${DELAY.VERYLONG}
    Wait Until Keyword Succeeds   ${timeOut}   ${DELAY.VERYSHORT}   Wait Until Element Is Not Visible    ${oCommonLoader}

Set Page Zoom Level
    [Arguments]    ${PERCENTAGE}    
    Execute JavaScript    document.body.style.zoom = '${PERCENTAGE}%'

Get Current Date in MMDD,YYYY Format
    ${current_date} =    Get Current Date
    ${formatted_date} =    Convert Date    ${current_date}    result_format=%b %d, %Y
    Return From Keyword    ${formatted_date}

Get Current Date in MM/DD/YYYY,HH:MM UTC Format
    ${current_date} =    Get Current Date    time_zone=UTC
    Log To Console    ${current_date}
    ${formatted_date} =    Convert Date    ${current_date}    result_format=%m/%d/%Y, %I:%M %p UTC
    Return From Keyword    ${formatted_date}

Get Earlier Date
    [Arguments]    ${days_earlier}
    ${current_date} =        Get Current Date
    ${date_obj} =            Convert Date                ${current_date}            result_format=%Y-%m-%d
    ${earlier_date_obj} =    Subtract Time From Date     ${date_obj}                ${days_earlier}
    ${earlier_date} =        Convert Date                ${earlier_date_obj}        result_format=%b %d, %Y
    RETURN    ${earlier_date}

Select Dropdown List By Element
    [Arguments]    ${element}
    Wait Until Element Is Visible   ${element}
    Wait Until Keyword Succeeds    3x    ${DELAY.SHORT}    Click Element    ${element}
    Click Element                  ${oBody}

Open Dropdown List By Text
    [Documentation]    Use this Keyword when you want to Interact with Dropdown Element by providing Dropdown Name ex : Channel/Owner etc
    [Arguments]    ${text}
    ${oCommonButtonL}=     Util.Update_Locator    ${oCommonButtonLocator}    ${text}
    Scroll and Wait For Element     ${oCommonButtonL}
    Wait Until Keyword Succeeds    3x    ${DELAY.SHORT}    Click Element      ${oCommonButtonL}

Select List Multiple Option By Text
    [Arguments]    ${values}
    Wait Until Element Is Visible    ${oListLoc}    ${DELAY.SHORT}
    ${my_list}=    Split String    ${values}    ,
    FOR    ${text}    IN    @{my_list}
    ${oCommonListL}=          Util.Update_Locator               ${oCommonListLocator}    ${text}
    Wait Until Keyword Succeeds    2x    ${DELAY.SHORT}    Click Element   ${oCommonListL}
    END
    Wait Until Keyword Succeeds    2x    ${DELAY.SHORT}    Press Tab Key    ${oLogo}

Select Single List Option By Text
    [Arguments]    ${text}    ${containsText}=False    
    Run Keyword If    '${containsText}' == 'True'   
    ...    Select List with Contains Text    ${text}     
    ...    ELSE     Run Keyword    Select List with Exact Text     ${text}           

Select List with Contains Text
    [Arguments]    ${text}
    Wait Until Element Is Visible    ${oListLoc}    ${DELAY.SHORT}
    ${oCommonListContainL}=          Util.Update_Locator               ${oCommonListLocContains}    ${text}
    Wait Until Keyword Succeeds    2x    ${DELAY.SHORT}    Click Element   ${oCommonListContainL}
    Wait Until Keyword Succeeds    2x    ${DELAY.SHORT}    Press Tab Key    ${oLogo}

Select List with Exact Text
    [Arguments]    ${text}
    Wait Until Element Is Visible    ${oListLoc}    ${DELAY.SHORT}
    ${oCommonListL}=          Util.Update_Locator   ${oCommonListLocator}    ${text}
    Wait Until Keyword Succeeds    2x    ${DELAY.SHORT}    Click Element   ${oCommonListL}
    Wait Until Keyword Succeeds    2x    ${DELAY.SHORT}    Press Tab Key    ${oLogo}

Select List Option By Text
    [Arguments]    ${text}
    ${status}=  Run Keyword And Return Status    Should Contain    ${text}    ,
    Run Keyword If    ${status} == True
    ...  Select List Multiple Option By Text     ${text}
    ...  ELSE
    ...  Select Single List Option By Text       ${text}

Compare Actual and Expected Dropdown List 
    [Arguments]                         @{EXP_LIST}
    Util.Compare Dropdown List with Expected List   @{EXP_LIST}
    Click Element    ${oBody}

Compare Dropdown List with Expected List
    [Documentation]   Compares values from dropdown with passed list
    [Arguments]                         @{EXP_LIST}
    Wait Until Element Is Visible       ${oListLoc}     ${DELAY.SHORT}
    @{ACT_LIST} =   Get List Values     ${oListLoc}
#    Lists Should Be Equal               ${ACT_LIST}     ${EXP_LIST}   ignore_order=True
    CommonKeywords.Compare Two Lists By Ignoring Order   ${ACT_LIST}     ${EXP_LIST}

Get Selected Input Textbox Value By Text
    [Arguments]    ${Text}
    ${oSelectedInputL}=          Util.Update_Locator        ${oSelectedInputLocator}    ${text}
    Wait Until Element Is Visible    ${oSelectedInputL}     ${DELAY.SHORT}
    ${ACT_LIST}    Get List Values   ${oSelectedInputL}
    Click Element    ${oBody}
    Return From Keyword    ${ACT_LIST}

Get Selected List Value By Text
    [Arguments]    ${Text}
    ${oSelectedListL}=          Util.Update_Locator               ${oSelectedListLocator}    ${Text}
    Wait Until Element Is Visible    ${oSelectedListL}        ${DELAY.SHORT}
    @{ACT_LIST}    Get List Values   ${oSelectedListL}
    Click Element    ${oBody}
    Return From Keyword              @{ACT_LIST}

Set input textbox by text
    [Documentation]    Use this Keyword when you want to Input Value to FIeld ex : Set input textbox by text   FieldName  Value
    [Arguments]    ${text}    ${value}
    ${oCommonInputLocatorL}=          Util.Update_Locator     ${oCommonInputLocator}    ${text}
    Wait Until Element Is Visible   ${oCommonInputLocatorL}   ${DELAY.MEDIUM}
    Wait Until Keyword Succeeds    3x    ${DELAY.SHORT}    Click Element   ${oCommonInputLocatorL}
    Wait Until Keyword Succeeds    3x    ${DELAY.SHORT}    Input Text      ${oCommonInputLocatorL}    ${value}

Create Dictionary from Lists
    [Arguments]     ${keys}     ${values}
    ${my_dict} =    Create Dictionary
    FOR    ${key}    ${value}    IN ZIP   ${keys}   ${values}
    Set To Dictionary    ${my_dict}    ${key}    ${value}
    END
    Return From Keyword     ${my_dict}   

Assert Equal
    [Documentation]    Compare actual and expected value and return result. Also execution will not be stopped if validation failed.
    [Arguments]    ${actual}    ${expected}    ${msgifany}='Value are not Equal'
    ${actual}    Convert To String    ${actual}
    ${actual}    String.Strip String    ${actual} 
    Run Keyword And Continue On Failure    Should Be Equal    ${actual}    ${expected}         ${msgifany}    ignore_case=True

Find Keys with Empty Values In Dictionary
    [Arguments]    ${dictionary}
    @{keysWithEmptyValues} =    Evaluate    [key for key, value in $dictionary.items() if value == '-' or value =='']
    RETURN    ${keysWithEmptyValues}

Scroll and Wait For Element
    [Arguments]    ${Element}
    Run Keyword And Ignore Error    Scroll Element Into View    ${Element}
    Wait Until Element Is Visible    ${Element}

Select Table Row
    [Documentation]    For Selecting any row you have to give the Index for example if you want to select 1st row then Index will bw 1
    [Arguments]    ${Row}=1
    ${oAlertsTableRowSourceL}=          Util.Update_Locator               ${oAlertsTableRowSourceCommon}    ${Row}
    Run Keyword And Ignore Error    Scroll Element Into View    ${oAlertsTableRowSourceL}
    Wait Until Element Is Visible    ${oAlertsTableRowSourceL}
    Click Element    ${oAlertsTableRowSourceL}

Is_Element_By_Text_Present_In_The_Page_Custom
    [Arguments]     ${elements}     ${desired_text}
    ${isElementPresent}=    Set Variable    False
    ${available_elements}=    Get WebElements    ${elements}
    FOR    ${element}    IN    @{available_elements}
        ${text}=    Get Text    ${element}
        IF  $text == $desired_text
           ${isElementPresent}=    Set Variable    True
           BREAK
        END
    END
    RETURN    ${isElementPresent}

Click_Element_By_Text_Custom
    [Arguments]     ${elements}     ${desired_text}
    ${isElementClicked}=    Set Variable    False
    ${available_elements}=    Get WebElements    ${elements}
    FOR    ${element}    IN    @{available_elements}
        ${text}=    Get Text    ${element}
        IF  $text == $desired_text
           Wait Until Element Is Enabled    ${element}
           Click Element    ${element}
           ${isElementClicked}=    Set Variable    True
           BREAK
        END
    END
    IF    ${isElementClicked} is False
        Fail    unable to locate elements with locator ${elements}!!!
    END

Click_Element_By_Partial_Text_Custom
    [Arguments]     ${elements}     ${desired_text}
    ${available_elements}=    Get WebElements    ${elements}
    FOR    ${element}    IN    @{available_elements}
        ${text}=    Get Text    ${element}
        ${contains}=    Run Keyword And Return Status    Should Contain    ${text}    ${desired_text}
        IF  ${contains}
           Wait Until Element Is Enabled    ${element}
           Click Element    ${element}
           BREAK
        END
    END

Click_Element_By_Innertext_Custom
    [Arguments]     ${elements}     ${desired_text}
    ${available_elements}=    Get WebElements    ${elements}
    FOR    ${element}    IN    @{available_elements}
        ${text}=    Util.Get_element_attribute_innerText_custom    ${element}
        Log To Console    ${text}
        Log To Console    ${desired_text}
        IF  '${text}' == '${desired_text}'
           Click Element    ${element}
           BREAK
        END
    END

Click_Element_By_Element_Attribute_Custom
    [Arguments]     ${elements}     ${element_attribute}    ${desired_text}
    ${available_elements}=    Get WebElements    ${elements}
    FOR    ${element}    IN    @{available_elements}
        ${text}=    Util.Get_Element_Attribute_Custom    ${element}     ${element_attribute}
        IF  '${text}' == '${desired_text}'
           Click Element    ${element}
           BREAK
        END
    END

Get_Element_Attribute_InnerText_Custom
   [Arguments]  ${element}
   ${innerText_fetched} =   Util.Get_Element_Attribute_Custom   ${element}  innerText
   Log To Console    ${innerText_fetched}
   RETURN  ${innerText_fetched}

Get_Element_Attribute_Custom
   [Arguments]  ${element}  ${element_attribute}
   ${element_attribute_fetched} =   Get Element Attribute   ${element}  ${element_attribute}
   Log To Console    ${element_attribute_fetched}
   RETURN  ${element_attribute_fetched}

Get_Element_Attribute_From_WebElements_Custom
   [Documentation]      This Keyword is used to Get the Attribute Value for Specific Element By Text
   [Arguments]  ${elements}  ${element_text}  ${element_attribute}
   ${available_elements}=    Get WebElements    ${elements}
    FOR    ${element}    IN    @{available_elements}
        ${text}=    Get Text    ${element}
        IF  '${text}' == '${element_text}'
           ${result}=   Util.Get_Element_Attribute_Custom    ${element}  ${element_attribute}
           Set Suite Variable    ${result}
           BREAK
        END
    END
    RETURN      ${result}

Get_Text_Locator_Custom
    [Arguments]  ${element}
    ${locator_text}=    Get Substring    ${element}    4
    RETURN    ${locator_text}

Wait_Until_Page_Contains_Text_Custom
   [Arguments]  ${custom_element}   ${timeout}=2s
   wait until page contains    ${custom_element}          ${timeout}

Wait_Until_Page_Contains_Element_Custom
   [Arguments]  ${custom_element}   ${timeout}=2s
   Wait Until Page Contains Element    ${custom_element}          ${timeout}

Wait_Until_Element_Is_Visible_Custom
   [Arguments]  ${custom_element}   ${timeout}=2s
   Wait Until Element Is Visible    ${custom_element}          ${timeout}

Wait_Until_Element_Is_Enabled_Custom
   [Arguments]  ${custom_element}   ${timeout}=2s
   Wait Until Element Is Enabled    ${custom_element}          ${timeout}

Wait_Until_Keyword_Succeeds_Custom
   [Arguments]  ${custom_keyword}  ${custom_element}    ${retry}=5x  ${retry_interval}=5s
   Wait Until Keyword Succeeds   ${retry}  ${retry_interval}   ${custom_keyword}   ${custom_element}

Get_Random_Numbers
   ${RandomNumbers}=   Evaluate  random.randint(0, sys.maxsize)  random, sys
   RETURN  ${RandomNumbers}
   
Click_Link_Custom
   [Arguments]  ${custom_element}
   Util.Wait_Until_Keyword_Succeeds_Custom    Util.Wait_Until_Element_Is_Visible_Custom    ${custom_element}
   Click Link  ${custom_element}

Click_Button_Custom
   [Arguments]  ${custom_element}
   Util.Wait_Until_Keyword_Succeeds_Custom    Util.Wait_Until_Element_Is_Visible_Custom    ${custom_element}
   Click Button  ${custom_element}
   
Click_Button_Text_Custom
   [Arguments]  ${custom_text}
   ${custom_text}=  Util.Get_Text_Locator_Custom    ${custom_text}
   Util.Wait_Until_Page_Contains_Text_Custom    ${custom_text}
   Click Button  ${custom_text}

Click_Element_Custom
   [Arguments]  ${custom_element}
   Util.Wait_Until_Keyword_Succeeds_Custom    Util.Wait_Until_Element_Is_Visible_Custom    ${custom_element}
   Wait Until Element Is Enabled   ${custom_element}
   Run Keyword And Ignore Error  Scroll Element Into View Using JavaScript    ${custom_element}
   Wait Until Keyword Succeeds   3x	  ${DELAY.SHORT}   Click Element  ${custom_element}

Select_Radio_Button_Custom
   [Arguments]  ${custom_element_name}     ${custom_value}
   Util.Wait_Until_Keyword_Succeeds_Custom    Util.Wait_Until_Element_Is_Visible_Custom    ${custom_element_name}
   Select Radio Button  ${custom_element_name}     '${custom_value}'

Update_Locator
    [Arguments]    ${locator}   ${UpdateParam}
    ${locator} =    Replace String    ${locator}    $LOCATOR_DYNAMIC_PARAM$    ${UpdateParam}
    RETURN    ${locator}

Assert_Element_Text_Custom
    [Documentation]     Fetches element/elements text and compare with the expected text
    [Arguments]    ${locator}   ${desiredText}
    ${isAsserted}=    Set Variable    False
    ${available_elements}=    Get WebElements    ${locator}
    FOR    ${element}    IN    @{available_elements}
        ${text}=    Get Text    ${element}
        IF  $text == $desiredText
           ${isAsserted}=    Set Variable    True
           Log    Element with text |${text}| verified
           BREAK
        END
    END
    IF    ${isAsserted} is False
        Fail    Element with text |${text}| verification failed!!!
    END

Button Should Be Enabled $Button
    [Arguments]    ${button_locator}
    ${disabled}    Run Keyword And Return Status   Get Element Attribute    ${button_locator}    disabled
    Run Keyword If    '${disabled}' == '${False}'    Pass Execution    Button is enabled
    ...    ELSE    Fail    Button is disabled

Click Button $Locators
    [Arguments]   ${element} 
    Wait Until Keyword Succeeds    5x    ${DELAY.SHORT}	    Button Should Be Enabled $Button   ${element}
    Click Element    ${element}

Get_Element_Text_And_Attribute_Custom
    [Arguments]  ${element}  ${element_attribute}
    ${values} =    Create List
    ${LIST} =    Get WebElements    ${element}
    FOR    ${el}    IN    @{LIST}
        Run Keyword And Ignore Error    Scroll Element Into View    ${el}
        ${text} =    Get Text    ${el}
        #Check for Empty Text and Try Getting Attribute Value
        ${result}=  IF    '${text}'==''       Get Element Attribute   ${el}     ${element_attribute}
        ...    ELSE
        ...    Removing Whitespaces from String   ${text}
        # Append the cleaned text to the list
        Append To List    ${values}    ${result}
    END
    RETURN    ${values}

Click Until Element Is Not Visible
    [Arguments]  ${element}
    Wait Until Element Is Visible    ${element}   timeout=${DELAY.MEDIUM}
    ${LIST} =    Get WebElements     ${element}
    FOR    ${el}    IN    @{LIST}
        Run Keyword And Ignore Error    Click Element   ${el}
        Util.Click Until Element Is Not Visible          ${element}
    END

Create Custom Lists From Dictionary
    [Arguments]    ${input_dict}
    @{yes_list}    Create List
    @{no_list}     Create List
    ${keys}    Get Dictionary Keys    ${input_dict}
    FOR    ${key}    IN    @{keys}
        ${value}    Get From Dictionary    ${input_dict}    ${key}
        Run Keyword If    '${value}' == 'YES'   Append To List    ${yes_list}    ${key}
        ...  ELSE  Append To List    ${no_list}     ${key}
    END
    RETURN    ${yes_list}     ${no_list}

Click Element by Javascript
    [Arguments]   ${Element}
    ${ele}    Get WebElement    ${Element}
    Execute Javascript    arguments[0].click();     ARGUMENTS    ${ele}

Select number of items to be displayed per page
    [Documentation]   Valid values for argument are: 10, 20, 50 & 100. Used to select the number of records displayed in the table
    [Arguments]   ${NoOfItems}
    Util.Click_Element_Custom   ${oItemsPerPageDropdown}
    ${UpdatedLocator_ItemsPerPage} =   Util.Update_Locator   ${oItemsPerPageDropdownListValue}   ${NoOfItems}
    Wait Until Element Is Visible    ${UpdatedLocator_ItemsPerPage}
    Util.Click Element by Javascript    ${UpdatedLocator_ItemsPerPage}

Get CSV Data
    [Arguments]  ${filepath}
    ${Data} =   Read Csv File    ${filepath}
    RETURN    ${Data}

Generate a random Name with Prefix
    [Documentation]   Used to create a random string with a prefix.
    [Arguments]   ${Prefix}
    ${random_Suffix} =   Generate Random String   5   [NUMBERS]   #Instead of [NUMBERS], we can also use [LOWER], [UPPER], [LETTERS]
    ${RandomNameWithPrefix} =   Set Variable   ${Prefix}${random_Suffix}
    RETURN   ${RandomNameWithPrefix}

Select Value from Dropdown
    [Documentation]   To be used for dropdowns where a list appears after clicking on the dropdown. Write the arguments as they appear in the UI(case-sensitive).
    [Arguments]   ${DropdownName}   ${DropdownValue}
    ${UpdatedLocator_Dropdown} =   Util.Update_Locator   ${oDropdownWithList}   ${DropdownName}
    Click Element    ${UpdatedLocator_Dropdown}
    Util.Click_Element_By_Innertext_Custom    ${oDropdownExpandedListItems}    ${DropdownValue}

Remove the directory
    [Documentation]   Removes the directory along with its files
    [Arguments]   ${Directory}
    Directory Should Exist    ${Directory}   msg=Provided directory does not exist, please provide a valid directory
    Remove Directory    ${Directory}    recursive=True

Ensure that Download directory is empty
    [Documentation]   Checks if the given directory is empty and if its not empty deletes all the files inside the directory and makes it empty
    [Arguments]   ${DownloadDir}
    ${Status}    Run Keyword And Return Status    Directory Should Be Empty    ${DownloadDir}
    IF    ${Status} == False
        Log    Directory is not empty. Deleting the files inside the directory to make it empty
        Empty Directory    ${DownloadDir}
    END

Validate that download folder contains the file
    [Documentation]   Argument filepath contains both path of file and name of the file. So the keyword validates that provided file is present in the system
    [Arguments]   ${FilePath}
    Wait Until Keyword Succeeds    ${DELAY.VERYLONG}    ${DELAY.SHORT}    File Should Exist    ${FilePath}

Validate that download folder contains only ${NoOfFiles} file/s
    [Documentation]   Validates that given folder contains only provided number of files
    [Arguments]   ${DownloadDir}
    ${files}   List Files In Directory    ${DownloadDir}
    Length Should Be    ${files}    ${NoOfFiles}   Should be only ${NoOfFiles} file/s in the download folder

Get Total count of elements from UI table
    [Documentation]   Gets the total number of records displayed in a webtable based on given common webelement
    [Arguments]   ${TableRows_CommonLocator}   ${ItemsPerPage}=10
    Util.Select number of items to be displayed per page   ${ItemsPerPage}
    Wait Until Page Contains Element    ${oPaginationLastPage}
    ${NoOfPages} =   Get Text   ${oPaginationLastPage}
    @{CountList} =   Create List
    FOR   ${pageindex}   IN RANGE   ${NoOfPages}
        ${Count} =   Get Element Count    ${TableRows_CommonLocator}
        Append To List    ${CountList}   ${Count}
        ${condition} =   Run Keyword And Return Status    Element Should Be Disabled    ${oPaginationNextButton}
        Exit For Loop If    ${condition}
        Click Element    ${oPaginationNextButton}
        Wait Until Loader Is Not Visible
    END
    ${Length_CountList} =   Get Length    ${CountList}
    ${total_count} =   Set Variable   ${0}
    FOR    ${index}    IN RANGE    ${Length_CountList}
       ${total_count} =   Evaluate    (${total_count} + ${CountList}[${index}])
    END
    RETURN   ${total_count}

Get Total Number of rows from CSV file
    [Documentation]   Reads the csv file and returns the number of rows inside the csv file excluding header row
    [Arguments]   ${CsvFileLocation}
    ${Csv_RowCount} =   Csv.get_total_rows   ${CsvFileLocation}
    RETURN   ${Csv_RowCount}

Get_WebElements_Values_List_Custom
    [Documentation]     This Keyword is used to get the Values from value Attribute from all the Webelements and store it in a list
    [Arguments]     ${element}         ${attribute}
    ${values} =     Create List
    ${LIST} =       Get WebElements    ${element}
    FOR    ${el}    IN    @{LIST}
           ${text} =    Get Element Attribute    ${el}     ${attribute}
           ${result}    Removing Whitespaces from String   ${text}
        IF    '${result}' != '${EMPTY}'
           Append To List     ${values}     ${result}
        END
    END
    RETURN    ${values}

Select Field By $Value
    [Documentation]    Use this Keyword when you want to Interact with Dropdown Element by providing Dropdown Name ex : Channel/Owner etc
    [Arguments]    ${text}
    ${fieldLocator}=          Util.Update_Locator               ${oInputValue}    ${text}
    Util.Scroll and Wait For Element    ${fieldLocator}
    Wait Until Keyword Succeeds    3x    ${DELAY.SHORT}    Click Element    ${fieldLocator}

Create Dictionary Without $Arg
    [Documentation]         This keyword is used to filter the dictionary By removing Items having Value passed by Argumnent ex: "-" or ${EMPTY}
    [Arguments]             ${original_dict}     ${Arg}
    ${filtered_dict}        Create Dictionary
    FOR     ${key}    IN    @{original_dict.keys()}
            ${value}        Get From Dictionary            ${original_dict}     ${key}
        IF  '${value}' != '${Arg}'    Set To Dictionary    ${filtered_dict}     ${key}=${value}
    END
    RETURN  ${filtered_dict}

Scroll Element Into View Using JavaScript
    [Documentation]   Used to scroll to the element location
    [Arguments]    ${element}
    ${element_str}=    Convert To String    ${element}
    ${element_str} =    Remove Locator Type(XPATH or CSS) from Locator  ${element_str}
    Execute JavaScript    ${element_str}.scrollIntoView(true);

Scroll To the Top of Page
    [Documentation]   Used to scroll to the top
    Execute JavaScript    window.scrollTo(0, 0);

Get nth element
    [Documentation]     This Keyword is used to get the nth position element from list of webelements.By default it will return first element if no parameter is passed.
    [Arguments]  ${elements}    ${nth}=0
    ${locator}=   Get Webelements     ${elements}
    RETURN    ${locator}[${nth}]

Remove Locator Type(XPATH or CSS) from Locator
    [Documentation]     Remove locator type like xpath: and css: from locator. This is only used before any javascript execution
    [Arguments]     ${locator}
    ${locator} =    Replace String    ${locator}    xpath:    ${Empty}
    ${locator} =    Replace String    ${locator}    css:      ${Empty}
    RETURN  ${locator}
