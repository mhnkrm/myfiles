*** Settings ***
Library           Selenium2Library
Library           ExcelLibrary

*** Variables ***
${Username}       mmarimuthu
${Password}       Msk2325Moh
${Browser}        firefox
${SiteUrl}        http://rtx-swtl-testlink.fnc.net.local/login.php
${DashboardTitle}    System Dashboard - JIRA
${Delay}          10s
${EXCEL_FILE_NAME}  test.xls
${EXCEL_SHEET_NAME}  Sheet1
${locator}    testproject
${tc_title}   100GE QPSK Provisioning

*** Test Cases ***
LoginTest

    Open Browser to the Login Page
    Enter User Name
    Enter Password
    Click Login
    Select Frame   titlebar
    sleep   5s
    Select From List   testproject    T600_R1.1:1FINITY_T600_1.1
    sleep   5s
    Unselect Frame
    Select Frame  mainframe
    Click Link   Test Plan Management
    Open Excel    ${CURDIR}/${EXCEL_FILE_NAME}
    ${strColCount} =  Get Column Count  ${EXCEL_SHEET_NAME}
    Log To Console  Cols are => ${strColCount}
    ${strRowCount} =  Get Row Count  ${EXCEL_SHEET_NAME}
    Log To Console  Rows are=> ${strRowCount}
    Set Test Variable   ${ROW_ID}   0
    :FOR    ${colIndex}    IN RANGE    0    ${strRowCount}
    \   rowid   ${strColCount}  ${ROW_ID}
    \   ${ROW_ID}=   Evaluate  ${ROW_ID}+ 1
    [Teardown]    Close Browser


*** Keywords ***
rowid
   [Arguments]        ${strColCount}   ${ROW_ID}
   :FOR    ${colIndex}    IN RANGE    0    ${strColCount}
   \   ${value}=  Read Cell Data By Coordinates   ${EXCEL_SHEET_NAME}  ${colIndex}  ${ROW_ID}
   \   Log To Console  Test case to be created : ${value}
   \   click button  create_testplan
   \   sleep   3s
   \   Input Text   testplan_name   ${value}
   \   Select Checkbox   active
   \   Select Checkbox   is_public
   \   click button    name=do_create

Open Browser to the Login Page
    open browser    ${SiteUrl}    ${Browser}
    Maximize Browser Window

Enter User Name
    Input Text    login    ${Username}

Enter Password
    Input Text    tl_password    ${Password}

Click Login
    click button    login_submit

Assert Dashboard Title
    Title Should be    ${DashboardTitle}