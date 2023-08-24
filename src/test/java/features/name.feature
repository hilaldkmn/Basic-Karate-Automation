Feature: Testing USERS_ENDPOINT with DefaultHeader

  Background:
    * url "https://reqres.in/api/"
    * def userService = { "name": "", "job": "" }
    * def DefaultHeader = { "Accept": "application/json" }

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
      | ahmet | dentist | 201 |
      | pelin | doctor | 201 |
      | akif | actor | 201 |
      | fatma | author | 201 |
      | leyla | actress | 201 |
      | furkan | painter | 201 |
      | erdem | musician | 201 |
      |  | musician | 201 |
      | erdem |  | 201 |