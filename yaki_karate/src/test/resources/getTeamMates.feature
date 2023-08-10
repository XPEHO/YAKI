Feature: GetTeammates

  Background:
    * def schema = [{userId : '#number', teammateId: '#number', userLastName: '#string', userFirstName: '#string', declarationDate: "#string", declarationStatus: "#string"}]
    Given url 'http://localhost:8080/login/authenticate'
    And request { login: 'owner', password: 'owner' }
    When method post
    Then status 200
    And def token = 'Bearer ' + response.token
  Scenario: 01 Create user
    Given url 'http://localhost:8080/login/register'
    And request {id : 4, lastname: 'user', firstname: 'user', email: 'owner@gmail.com', login: 'user', password: 'user'}
    When method post
    Then status 200

    * def DbUtils = Java.type('org.example.utils.DbUtils')
    * def db = new DbUtils()
    * def token2 = db.readValue('SELECT token FROM public.verification_token WHERE verification_token_user_id = 19')
    Given url 'http://localhost:8080/login/registerConfirm'
    And param token = token2
    When method GET
    Then status 200
  Scenario: 02 Attribute role & create team
    Given url 'http://localhost:8080/teammates'
    And header Authorization = token
    And request { teamId : 2, userId: 4 }
    When method post
    Then status 200

  @GetAllTeammateSuccessful
  Scenario: Get all teammate
    Given url 'http://localhost:3000/login'
    And request { "login": "user", "password": "user" }
    When method POST
    Then status 200
    And def token = response.token
    And def userId = response.userId

    Given url 'http://localhost:3000/teammates'
    And header x-access-token = token
    And header user_id = userId
    And param captainId = 2
    When method get
    Then status 200
    And match response contains  schema
    * print response
    * print schema

  Scenario: Get the latest declaration fail
    Given url 'http://localhost:3000/teammate'
    When method get
    Then status 404
