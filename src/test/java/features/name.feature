Feature: Testing USERS_ENDPOINT with DefaultHeader

  Background:
    * url "https://reqres.in/api/"
    * def req = read('body/bodyPost.json')

  @SuccessPostRegister
  Scenario: RegisterSuccessful
    Given path 'register'
    And request req.registerBodySuccessful
    When method post
    Then status 200

  @SuccessGet
  Scenario: Get Single User
    Given path 'users/2'
    When method get
    Then status 200
    And match response.data.first_name == 'Janet'

  @SuccessPut
  Scenario: Update User
    Given path 'users/2'
    And request req.updateUser
    When method put
    Then status 200

  @SuccessDelete
  Scenario: Delete User
    Given path 'users/2'
    When method delete
    Then status 204
