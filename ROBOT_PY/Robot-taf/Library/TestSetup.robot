*** Settings ***
Library    SeleniumLibrary
Library    ..${/}Library${/}BrowserOptions.py
Library    ..${/}Library${/}FileUtil.py
Resource   ..${/}Settings${/}config.robot

*** Keywords ***
Begin Web Test
    [Arguments]   ${browser}=chrome    ${maximize}=True    ${headless}=False    ${browserWidth}=1920    ${browserHeight}=1080
    ${maximize} =    Convert To Boolean    ${maximize}
    ${headless} =    Convert To Boolean    ${headless}
    ${browserWidth} =    Convert To Integer    ${browserWidth}
    ${browserHeight} =    Convert To Integer    ${browserHeight}

    IF  '${browser}' == 'chrome'
        ${options}=    BrowserOptions.get_chromeoptions    ${headless}
    ELSE IF    '${browser}' == 'firefox'
        ${options}=    BrowserOptions.get_firefoxoptions    ${headless}
    ELSE IF    '${browser}' == 'edge'
        ${options}=    BrowserOptions.get_edgeoptions    ${headless}
    END

    ${driver_path} =   BrowserOptions.get_driver_path    ${browser}
    Open Browser    about:blank    browser=${browser}    options=${options}    executable_path=${driver_path}
    ${importUsers} =   FileUtil.Get Project Directory    Settings    ${ENV}_users.robot
    Import Resource    ${importUsers}
    Run Keyword If    ${maximize}    Maximize Browser Window
    ...    ELSE
    ...    Set Window Size    ${browserWidth}    ${browserHeight}

End Web Test
    Close All Browsers