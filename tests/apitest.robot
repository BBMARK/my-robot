*** Settings ***
Library    RequestsLibrary

*** Variables ***
${URL}    https://reqres.in/api/users/2
${headers}    Content-Type=application/json

*** Test Cases ***
Create POST 
    ${body}    Create Dictionary    name=March    job=Testing
    ${response}    POST    url=https://reqres.in/api/users    json=${body}
    Should Be Equal As Numbers    ${response.status_code}    201
    Log    ${response.json()}
    # แปลง response เป็น JSON
    ${response_str}=    Evaluate    json.dumps(${response.json()})    modules=json
    # แสดงผลลัพธ์ใน response
    Log    ${response_str}
    Should Contain    ${response_str}    March
    Should Contain    ${response_str}    Testing


Get Single User
    ${response}=    GET    ${URL}
    Should Be Equal As Numbers    ${response.status_code}    200
    ${response_json}=    To JSON    ${response.text}
    Should Contain    ${response_json['data']}    id
    Should Contain    ${response_json['data']}    first_name
    Should Contain    ${response_json['data']}    last_name
    log    ${response_json['data']} 
    log    ${response_json['data']} 
    log    ${response_json['data']} 
Update User
    ${data}=    Create Dictionary    name=morpheus   job=zion resident
    ${response}=    PUT    ${URL}    json=${data}
    Should Be Equal As Numbers    ${response.status_code}    200
    Log    ${response.json()}
    # แปลง response เป็น JSON
    ${response_str}=    Evaluate    json.dumps(${response.json()})    modules=json
    # แสดงผลลัพธ์ใน response
    Log    ${response_str}
    Should Contain    ${response_str}    morpheus
    Should Contain    ${response_str}    zion resident
    Log    ${response_str} , ${response_str}


Delete User
    ${response}=    DELETE    ${URL}
    Should Be Equal As Numbers    ${response.status_code}    204
    Should Be Empty    ${response.text}
