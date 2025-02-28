*** Settings ***
Library    SeleniumLibrary     
Library    

*** Variables ***
${username}            admin           
${password}            admin  





*** Keywords ***

loging to the demoblaze successfully
    Open Browser     https://www.demoblaze.com/         chrome
    Maximize Browser Window
    Click Element  //*[@id="login2"]
    Switch Window
    Wait Until Element Is Visible        //*[@id="loginusername"]
    Input Text    //*[@id="loginusername"]   ${username}
    Input Text    //*[@id="loginpassword"]   ${password}
    Click Button    //button[contains(text(),'Log in')]   
 
    Wait Until Element Is Visible     //*[@id="logout2"]
    Element Text Should Be    //*[@id="logout2"]    Log out


select the catergory
    [Arguments]             ${catergory}
    Click Element         //a[contains(text(),${catergory})]


select the product    
    [Arguments]             ${product}
    Wait Until Page Contains Element    //a[contains(text(),'${product}')]
    Click Element         //a[contains(text(),'${product}')]


add selected product to the cart
    Click Link   //*[@id="tbodyid"]/div[2]/div/a

confirm the adding message
    Handle Alert    action=DISMISS

navigate to the cart
    Click Element    //*[@id="cartur"]
    Wait Until Page Contains Element    //*[@id="page-wrapper"]/div/div[2]/button


navigate to the home page
    Click Element    //*[@id="navbarExample"]/ul/li[1]/a
    Wait Until Page Contains Element    //*[@id="navbarExample"]/ul/li[1]/a

click place order button
    Click Button    //*[@id="page-wrapper"]/div/div[2]/button

enter the place order windoe details and purchase
    [Arguments]             ${total}
    ...                     ${name}
    ...                     ${country}
    ...                     ${city}
    ...                     ${cc}     
    ...                     ${month} 
    ...                     ${year} 
    Switch Window     
    Wait Until Element Is Visible   //*[@id="orderModalLabel"]
    Element Text Should Be    //*[@id="totalm"]    Total: ${total}
    Input Text    //*[@id="name"]    ${name}
    Input Text    //*[@id="country"]    ${country}
    Input Text    //*[@id="city"]    ${city}
    Input Text    //*[@id="card"]    ${cc}
    Input Text    //*[@id="month"]    ${month}
    Input Text    //*[@id="year"]        ${year}
    Click Button    //*[@id="orderModal"]/div/div/div[3]/button[2]

verify the product details page
    [Arguments]             ${product_title}
    ...                     ${product_price}
    ...                     ${product_des}
    
    Wait Until Element Is Visible   //*[@id="tbodyid"]/h2
    Element Text Should Be    //*[@id="tbodyid"]/h2    ${product_title}
    Element Should Contain    //*[@id="tbodyid"]/h3    ${product_price}
    Element Text Should Be    //*[@id="more-information"]/p    ${product_des}

verify that cart is empty
    Element Should Not Be Visible   //*[@id="totalp"]

verify the cart value
    [Arguments]             ${total}
    ${value}=  Get Text  //h3[@id='totalp']
    Should Not Be Equal As Strings  ${value}  ${total}

verify the purchase confirmation message
    Switch Window
    #Wait Until Element Is Visible   /html/body/div[10]/div[7]/div/button 
    #Element text should be         /html/body/div[10]/h2        Thank you for your purchase!
    #Click Button    /html/body/div[10]/div[7]/div/button

end test
    Close Browser


*** test case ***
End to end product purchasing success test case

    loging to the demoblaze successfully 
    navigate to the cart
    verify that cart is empty
    navigate to the home page
    select the catergory    Phones
    select the product      Samsung galaxy s6
    verify the product details page     product_title=Samsung galaxy s6
            ...      product_price=$360
            ...      product_des=The Samsung Galaxy S6 is powered by 1.5GHz octa-core Samsung Exynos 7420 processor and it comes with 3GB of RAM. The phone packs 32GB of internal storage cannot be expanded.  
   
    add selected product to the cart 
    confirm the adding message
    navigate to the cart
    verify the cart value    360
    click place order button
    enter the place order windoe details and purchase     total=360
    ...                     name=testname1
    ...                     country=testcountry
    ...                     city=testcity
    ...                     cc=testcc     
    ...                     month=March 
    ...                     year=2013

    verify the purchase confirmation message
    end test

    


