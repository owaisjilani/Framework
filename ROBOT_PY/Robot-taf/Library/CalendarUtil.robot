[Metadata]    Author    Owais Jilani
*** Settings ***  
Library     SeleniumLibrary
Library     String
Library     Collections
Library     DateTime

Resource    Util.robot

Variables   ..${/}PageObjects${/}Locators${/}CalendarElements.py
Variables   ..${/}PageObjects${/}Locators${/}LoginPageElements.py

*** Variables ***

@{MONTHS}            InvalidMonth    January        February      March      April      May         June       July        August         September      October        November      December
&{month_numbers}     January=01      February=02    March=03      April=04   May=05     June=06     July=07    August=08   September=09   October=10     November=11    December=12

*** Keywords ***

Format Date without Time and Comma
    [Arguments]     ${date_string}
    ${status}=    Run Keyword And Return Status    Should Contain    ${date_string}    ,
    IF   ${status}
         @{split_result}=    Split String    ${date_string}    ,
         ${date}=            Set Variable    ${split_result[0]}
    ELSE
        # Log     No Need to Format the Date
         ${date}=            Set Variable    ${date_string}
    END
    RETURN    ${date}

Get Date Components $DD-Month-YYYY
    [Arguments]    ${date_string}
    ${date_parts} =       Split String    ${date_string}    -
    ${day}    ${month}    ${year} =    Set Variable    ${date_parts[0]}    ${date_parts[1]}    ${date_parts[2]}
    ${dayWithoutZero}=    Evaluate    "${day}".lstrip("0")
    RETURN    ${dayWithoutZero}    ${month}    ${year}

Get Date Components $MM/DD/YYYY
    [Arguments]    ${date_string}
    ${date}=   Format Date without Time and Comma    ${date_string}
    ${month}    ${day}    ${year} =      Split String    ${date}    /
    ${dayWithoutZero} =    Evaluate    "${day}".lstrip("0")
    ${updatedMonth} =      Set Variable     ${MONTHS}[${month}]
    RETURN    ${dayWithoutZero}     ${updatedMonth}  ${year}

Get Date Components
    [Arguments]      ${date_string}
    ${status}=       Run Keyword and Return Status    Should Contain    ${date_string}    /
    IF    ${status}
          ${day}     ${updatedMonth}  ${year}=        Get Date Components $MM/DD/YYYY          ${date_string}
    ELSE
          ${day}     ${updatedMonth}  ${year}=        Get Date Components $DD-Month-YYYY       ${date_string}
    END
    RETURN           ${day}     ${updatedMonth}  ${year}

Get Year from Date
    [Arguments]    ${date_string}
    ${split_successful} =    Run Keyword And Return Status    Should Contain    ${date_string}    -
    IF    ${split_successful}
          ${date_parts} =    Split String    ${date_string}    -
    ELSE
          ${date_parts} =    Split String    ${date_string}    /
    END
    RETURN    ${date_parts[2]}

Select Date Range $FromDate $ToDate
    [Documentation]    Selects a Date Range from Open Calender provided by user in format MM/DD/YYYY  MM/DD/YYYY or DD-Month-YYYY  DD-Month-YYYY
    [Arguments]    ${Fromdate}    ${ToDate}
    Navigate to Year Page
    Select_Date        ${Fromdate}
    Navigate to Year Page
    Select_Date        ${ToDate}
    Util.Press Tab Key    ${oLogo}

Get Current Year From Calendar
    Wait Until Element Is Visible    ${oCalendarFirstYear}
    ${yearUI}=    Get Text    ${oCalendarFirstYear}
    RETURN    ${yearUI}

Check Year Present in Current Page   
    [Arguments]     ${Date}
    ${year} =       Get Year from Date     ${Date}
    ${locator}=     Util.Update_Locator    ${oCalendarYearText}    ${year}
    ${status}=      Run Keyword and Return Status    Wait Until Element Is Visible    ${locator}
    RETURN    ${status}

Select_Date
    [Documentation]     Select the custom argumented Date from Calendar
    [Arguments]   ${DateArgument}
    ${formattedDate}=      Format Date without Time and Comma    ${DateArgument}
    ${yearUI}=    Get Current Year From Calendar
    ${yearFromdate} =    Get Year from Date    ${formattedDate}
    Navigate to Desired Year   ${yearFromdate}    ${yearUI}
    ${day}    ${month}    ${year} =    Get Date Components    ${formattedDate}
    ${yearLocator}=     Util.Update_Locator    ${oCalendarYearText}   ${year}
    Util.Click_Element_Custom              ${yearLocator}
    ${monthLocator}=     Util.Update_Locator    ${oCalendarMonthText}   ${month}
    Util.Click_Element_Custom              ${monthLocator}
    Wait Until Element is Visible          ${oCalendarDateText}
    Util.Click_Element_By_Text_Custom      ${oCalendarDateText}    ${day}

Navigate to Desired Year
    [Documentation]     This Keyword is used to Navigate to the Year which is not in Range (2021-2030)
    [Arguments]     ${year}    ${yearUI}   
    ${difference} =  Evaluate    abs(${year} - ${yearUI})
    ${itr} =         Evaluate    (${difference} / 10)
    IF    ${year} < ${yearUI}
          ${iteration} =   Evaluate    int(math.ceil(${itr}))
          FOR    ${index}    IN RANGE    ${iteration}
            Util.Click_Element_Custom   ${oCalendarPrevNav}
          END
    ELSE
         ${iteration} =   Evaluate    int(math.floor(${itr}))
         FOR    ${index}    IN RANGE    ${iteration}
           Util.Click_Element_Custom   ${oCalendarNextNav}
         END
    END

Navigate to Year Page
    [Documentation]     This Keyword is used to Navigate to the Year Range (2021-2030) in Calendar
    Wait Until Element Is Visible    ${oCalendarNav}
    Util.Click_Element_Custom   ${oCalendarNav}
    Util.Click_Element_Custom   ${oCalendarNav}
    Util.Click_Element_Custom   ${oCalendarNav}

Get Current Date in Format
    [Documentation]     This Keyword Returns the Current Date in the Format Specified by the User in Argument
    [Arguments]   ${DateFormat}
    ${current_date}     Get Current Date
    ${Formatted_date}   Convert Date    ${current_date}   result_format=${DateFormat}
    RETURN    ${Formatted_date}
