Feature: Testing USERS_ENDPOINT with DefaultHeader

  Background:
    * url "https://reqres.in/api/"
    * def userService = { "name": "", "job": "" }
    * def DefaultHeader = { "Accept": "application/json" }
    * def req = read('body/bodyPost.json')

  Scenario: RegisterUnSuccessful
    Given path 'register'
    And request req.registerBodyUnSuccessful
    When method post
    Then status 400
    And match response.error == 'Missing password'

  Scenario: Get Single User
    Given path 'users/2'
    When method get
    Then status 200
    And match response.data.first_name == 'Janet'

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

