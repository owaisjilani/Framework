[Metadata]  Author  Owais Jilani

*** Settings ***
Library     SeleniumLibrary
Resource    ..${/}Library${/}Util.robot

Variables   ..${/}PageObjects${/}Locators${/}DashboardPageElements.py
Variables   ..${/}PageObjects${/}PageText${/}DashboardPage.py


*** Keywords ***
Verify Page Load Condition
    Wait Until Keyword Succeeds    8x    ${DELAY.SHORT}	    Wait Until Element Is Visible    ${oDashboardDateRangeSelector}
    Run Keyword And Ignore Error    Wait Until Element Is Visible    ${oProgressBar}
    Run Keyword And Ignore Error    Wait Until Element Is Not Visible    ${oProgressBar}

Set Channel
    [Arguments]     ${input}
    Click Element    ${oDashboardDataTypeDropdown}
    Util.Click_Element_By_Text_Custom    ${oDropdownOptions}     ${input}

Set Date Range
    [Arguments]     ${input}
    Click Element    ${oDashboardDateRangeSelector}
    Util.Click_Element_By_Text_Custom    ${oDropdownOptions}     ${input}

Check Metrics
    [Arguments]     ${input}
    Util.Assert_Element_Text_Custom  ${oDashboardSectionsText}   ${input}

Select Tabs
    [Arguments]     ${input}
    Util.Click_Element_By_Text_Custom   ${oDashboardTabs}     ${input}

Verify the Default My Dashboard Alert and Case List
    Wait Until Element Is Visible                     ${oActiveCloseList}
    ${actualAlertStatusList}=    Util.Get List Values    ${oActiveCloseList}
    FOR    ${activeCloseAlert}    IN    @{pActiveCloseAlertList}
        Run Keyword If    '${activeCloseAlert}' not in @{actualAlertStatusList}    Fail    Actual Alert header is not as expected header present in List ${pActiveCloseAlertList}
    END

Verify the Default My Dashboard Alert/Case Headers
    Wait Until Element Is Visible                        ${oHeaders}
    ${actualHeaders}=    Util.Get List Values            ${oHeaders}
    FOR    ${dashboardAlertCaseOverview}    IN    @{pMyDashboardAlertCaseOverview}
        Run Keyword If    '${dashboardAlertCaseOverview}' not in @{actualHeaders}    Fail    Actual Alert header is not as expected header present in List ${pMyDashboardAlertCaseOverview}
    END

Get Total Count
    [Documentation]   Works on both Cases and ALerts tab, used to get count shown in front of Total in dashboard
    ${TotalCount} =   Get Text   ${oTotalCount}
    RETURN   ${TotalCount}
