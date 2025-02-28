*** Settings ***
Library    SeleniumLibrary     
Library    

*** Variables ***
${login_btn}           //*[@id="block-mainheaderquickpay"]/div/div/a


*** Keywords ***

*** test case ***



testcase1
    log    hello world

    
testcase2
    Open Browser     https://dialog.lk/         chrome
    Maximize Browser Window
    Click Element  ${login_btn}
    Element Text Should Be        //*[@id="block-mainnavigation"]/li[1]/a     Mobile
