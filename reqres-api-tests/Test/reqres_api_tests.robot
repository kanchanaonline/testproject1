*** Settings ***
Library           RequestsLibrary
Resource          ../variables/variables.robot
Resource          ../resources/keywords.robot
Suite Setup       Create Session    reqres    ${BASE_URL}

*** Test Cases ***

GET All Users
    [Tags]    Get
    Get Users Page 2
    Status Should Be    200
    Should Contain Key    ${response.json()}    data

GET Invalid User
    [Tags]    Get    Negative
    Get Invalid User
    Status Should Be    404

POST Valid Login
    [Tags]    Post
    Post Valid Login
    Status Should Be    200
    Should Contain Key    ${response.json()}    token

POST Invalid Login
    [Tags]    Post    Negative
    Post Invalid Login
    Status Should Be    400
    Dictionary Should Contain Value    ${response.json()}    Missing password

POST Register New User
    [Tags]    Post
    Post Register User
    Status Should Be    200
    Should Contain Key    ${response.json()}    token

DELETE User
    [Tags]    Delete
    Delete User
    Status Should Be    204