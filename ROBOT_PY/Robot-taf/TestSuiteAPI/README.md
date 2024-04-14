# Robot Framework for APIs

This is a demo on using Robot Framework
[RequestsLibrary](https://github.com/bulkan/robotframework-requests) and
[RESTinstance](https://github.com/asyrjasalo/RESTinstance)
for API (test) automation.

We are using [JSONPlaceholder](https://jsonplaceholder.typicode.com/users)
as the system under test in these examples.

## Rationale

### robotframework-requests is truly great HTTP test library

But it takes a lot of keywords to test JSON APIs even for simple things:

```robot
*** Settings ***
Library         RequestsLibrary
Library         Collections
Library         json
Suite setup     Create Session  typicode  https://jsonplaceholder.typicode.com
Suite teardown  Delete all sessions


*** Test Cases ***
requests: Should have a name and belong to a company with a slogan
  ${resp}=        Get request               typicode              /users/1
  Should Be Equal As Integers               ${resp.status_code}   200
  ${name}=        Get From Dictionary       ${resp.json()}        name
  Should Be Equal As Strings                ${name}               Leanne Graham
  ${co}=          Get From Dictionary       ${resp.json()}        company
  ${co_slogan}=   Get From Dictionary       ${co}                 catchPhrase
  Should Be Equal As Strings  ${co_slogan}  Multi-layered client-server neural-net
  ${json}=        Dumps                     ${resp.json()}        indent=${4}
  Log to Console  ${json}
```

### For JSON APIs, `pip install --upgrade RESTinstance`

Then the same as above:

```robot
*** Settings ***
Library         REST              https://jsonplaceholder.typicode.com


*** Test Cases ***
RESTinstance: Should have a name and belong to a company with a slogan
    GET         /users/1
    Integer     response status   200
    String      $.name            Leanne Graham
    String      $..catchPhrase    Multi-layered client-server neural-net
    Output      $
```

# Robot Framework RESTinstance Library for REST API Testing

- RESTinstance relies on Robot Framework's language-agnostic, clean and minimal syntax, for API tests. It is neither tied to any particular programming language nor development framework. Using RESTinstance requires little, if any, programming knowledge. It builts on long-term technologies with well established communities, such as HTTP, JSON (Schema), Swagger/OpenAPI and Robot Framework.
- It validates JSON using JSON Schema, guiding you to write API tests to base on properties rather than on specific values (e.g. "email must be valid" vs "email is foo@bar.com"). This approach reduces test maintenance when the values responded by the API are prone to change. Although values are not required, you can still test them whenever they make sense (e.g. GET response body from one endpoint, then POST some of its values to another endpoint and verify the results).
- It generates JSON Schema for requests and responses automatically, and the schema gets more accurate by your tests. Output the schema to a file and reuse it as expectations to test the other methods, as most of them respond similarly with only minor differences. Or extend the schema further to a full Swagger spec (version 2.0, OpenAPI 3.0 also planned), which RESTinstance can test requests and responses against. All this leads to reusability, getting great test coverage with minimum number of keystrokes and very clean tests.

## Overview

- **Library**: REST library is used for making HTTP requests to the [JSONPlaceholder](https://jsonplaceholder.typicode.com) API.
- **Documentation**: This test suite demonstrates how to perform API testing with Robot Framework. It supports both JSON and Python type systems for input data. Each request creates an instance, referred to as 'Output,' and most keywords apply to the last instance.
- **Schemas**: Initial schemas for requests and responses are auto-generated. You can customize them using assertion keywords corresponding to JSON types. You can also perform JSON Schema validation without writing custom validation logic.
- **JSONPath Queries**: JSONPath queries are used for concise and powerful assertions.
- **Data Types**: Enum values in tests are optional, with only the data type required.
- **Output Instances**: All instances created persist throughout the test suite, and you can access them using the 'Rest instances' keyword.

## Tests

### GET an Existing User and Observe Schema Improvement

```robotframework
GET         /users/1                  # Creates a new instance
Output schema   response body
Object      response body             # All values are optional
Integer     response body id          1
String      response body name        Leanne Graham
[Teardown]  Output schema             # Notice the updated response schema
```

### GET Existing Users and Use JSONPath for Concise Assertions
```robotframework
GET         /users?_limit=5           # Subsequent assertions apply to this instance
Array       response body
Integer     $[0].id                   1           # First ID is 1
String      $[0]..lat                 -37.3159    # Any matching child
Integer     $..id                     maximum=5   # Multiple matches
[Teardown]  Output  $[*].email        # Outputs all emails as an array
```

### POST with Valid Parameters to Create a New User
```robotframework
POST        /users                    ${json}
Integer     response status           201
[Teardown]  Output  response body     ${OUTPUTDIR}/new_user.demo.json
```

### PUT with Valid Parameters to Update an Existing User
```robotframework
PUT         /users/2                  { "isCoding": true }
Boolean     response body isCoding    true
PUT         /users/2                  { "sleep": null }
Null        response body sleep
PUT         /users/2                  { "pockets": "", "money": 0.02 }
String      response body pockets     ${EMPTY}
Number      response body money       0.02
Missing     response body moving      # Fails if the 'moving' property exists
```

### PATCH with Valid Parameters, Reusing Response Properties
```robotframework
&{res}=     GET   /users/3
String      $.name                    Clementine Bauch
PATCH       /users/4                  { "name": "${res.body['name']}" }
String      $.name                    Clementine Bauch
PATCH       /users/5                  ${dict}
String      $.name                    ${dict.name}
```

### DELETE an Existing User Successfully and Save Request History
```robotframework
DELETE      /users/6                  # Status can be any of the following: 200, 202, 204
Integer     response status           200    202     204
Rest instances  ${OUTPUTDIR}/all.demo.json  # All instances created so far
```

## Towards model-based testing: Properties matter, values do not

Let's move the logic from tests to JSON Schemas.

The goal is to enable tests that are three lines at maximum:

```robot
*** Settings ***
Library         REST   https://jsonplaceholder.typicode.com
Suite setup     Expect response body      ${CURDIR}/model.json

*** Test Cases ***
Valid user
    GET         /users/1
    String      $.email       format=email

New user
    POST        /users        ${CURDIR}/user.json

Edit user
    PUT         /users/1      ${CURDIR}/user.json

Edit email
    PATCH       /users/2      { "email": "ismo.aro@robotframework.dev" }

Delete
    [Setup]     Expect response body      { "required": [] }
    DELETE      /users/10
    [Teardown]  Clear expectations

Valid users
    GET         /users
    Array       $             minItems=1    maxItems=10
    Integer     $[*].id       maximum=10
```



###### [RESTinstance Library Documentation Reference]: https://pypi.org/project/RESTinstance/



