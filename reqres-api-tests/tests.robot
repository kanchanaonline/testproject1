*** Settings ***
Library           RequestsLibrary
Library           Collections
Library           OperatingSystem
Suite Setup       Create Session    reqres    https://reqres.in

*** Variables ***
${BASE_URL}       https://reqres.in
${USER_ID}        2
${INVALID_ID}     999
${LOGIN_EMAIL}    eve.holt@reqres.in
${LOGIN_PASSWORD} cityslicka
${INVALID_EMAIL}  invalid@reqres.in
${INVALID_PASS}   invalidpassword

*** Test Cases ***

Get User - Valid ID
    [Tags]    GET    Positive
    ${response}=    GET On Session    reqres    /api/users/${USER_ID}
    Status Should Be    200    ${response}
    Dictionary Should Contain Key    ${response.json()}    data
    Should Be Equal As Strings    ${response.json()['data']['id']}    ${USER_ID}

Get User - Invalid ID
    [Tags]    GET    Negative
    ${response}=    GET On Session    reqres    /api/users/${INVALID_ID}
    Status Should Be    404    ${response}

Create User - Valid Data
    [Tags]    POST    Positive
    ${data}=    Create Dictionary    name=John    job=Tester
    ${response}=    POST On Session    reqres    /api/users    json=${data}
    Status Should Be    201    ${response}
    Dictionary Should Contain Key    ${response.json()}    id
    Dictionary Should Contain Key    ${response.json()}    createdAt

Login - Successful
    [Tags]    POST    Positive
    ${data}=    Create Dictionary    email=${LOGIN_EMAIL}    password=${LOGIN_PASSWORD}
    ${response}=    POST On Session    reqres    /api/login    json=${data}
    Status Should Be    200    ${response}
    Dictionary Should Contain Key    ${response.json()}    token

Login - Invalid Credentials
    [Tags]    POST    Negative
    ${data}=    Create Dictionary    email=${INVALID_EMAIL}    password=${INVALID_PASS}
    ${response}=    POST On Session    reqres    /api/login    json=${data}
    Status Should Be    400    ${response}
    Dictionary Should Contain Key    ${response.json()}    error
    Should Be Equal As Strings    ${response.json()['error']}    user not found

Delete User - Valid ID
    [Tags]    DELETE    Positive
    ${response}=    DELETE On Session    reqres    /api/users/${USER_ID}
    Status Should Be    204    ${response}

*** Keywords ***
Status Should Be
    [Arguments]    ${expected}    ${response}
    Should Be Equal As Integers    ${response.status_code}    ${expected}