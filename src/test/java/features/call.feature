Feature: Testing USERS_ENDPOINT with DefaultHeader

  Background:
    * url "https://reqres.in/api/"
    * def userService = { "name": "", "job": "" }
    * def DefaultHeader = { "Accept": "application/json" }
    * def req = read('body/bodyPost.json')

  @SuccessPostUnRegister
  Scenario: RegisterPostUnSuccessful
    Given path 'register'
    * def callScenario = call read('name.feature@SuccessPostRegister')
    * def callResponse = callScenario.response
    * set req.registerBodyUnSuccessful.email = callResponse.id
    And request req.registerBodyUnSuccessful
    When method post
    Then status 400
    And match response.error == 'Missing password'

  @SuccesOutline
  Scenario Outline: post DefaultHeader
    Given path 'users'
    And request userService
    And request { "name": "<name>", "job": "<job>" }
    And configure headers = DefaultHeader
    When method post
    Then status <statusCode>
    And match response contains { job: '<job>' }
    Examples:
      | name  | job     | statusCode |
      | jason | teacher| 201 |
      | emre | engineer | 201 |

  @SuccessPostRegister2
  Scenario: RegisterSuccessful2
    Given path 'register'
    And header Content-Type = 'application/json'
    And request req.registerBodySuccessful
    When method post
    Then status 200