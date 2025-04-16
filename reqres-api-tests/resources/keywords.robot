*** Keywords ***

Get Users Page 2
    ${response}=    GET    reqres    /api/users?page=2
    Set Test Variable    ${response}

Get Invalid User
    ${response}=    GET    reqres    /api/users/23
    Set Test Variable    ${response}

Post Valid Login
    ${data}=    Create Dictionary    email=eve.holt@reqres.in    password=cityslicka
    ${response}=    POST    reqres    /api/login    json=${data}
    Set Test Variable    ${response}

Post Invalid Login
    ${data}=    Create Dictionary    email=eve.holt@reqres.in
    ${response}=    POST    reqres    /api/login    json=${data}
    Set Test Variable    ${response}

Post Register User
    ${data}=    Create Dictionary    email=eve.holt@reqres.in    password=pistol
    ${response}=    POST    reqres    /api/register    json=${data}
    Set Test Variable    ${response}

Delete User
    ${response}=    DELETE    reqres    /api/users/2
    Set Test Variable    ${response}