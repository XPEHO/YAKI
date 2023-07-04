Feature: GetTeamMates

  Background:
    * def schema = [{userId : '#number', teamMateId: '#number', userLastName: '#string', userFirstName: '#string', declarationDate: "#string", declarationStatus: "#string"}]
    Given url 'http://localhost:8080/login/authenticate'
    And request { login: 'owner', password: 'owner' }
    When method post
    Then status 200
    And def token = 'Bearer ' + response.token
  Scenario: 01 Create user
    Given url 'http://localhost:8080/users'
    And header Authorization = token
    And request {id : 4, lastname: 'user', firstname: 'user', email: 'owner@gmail.com', login: 'user', password: 'user'}
    When method post
    Then status 200

  Scenario: 02 Attribute role & create team
    Given url 'http://localhost:8080/teammates'
    And header Authorization = token
    And request { teamId : 2, userId: 4 }
    When method post
    Then status 200

  @GetAllTeamMateSuccessful
  Scenario: Get all teamMate
    Given url 'http://localhost:3000/login'
    And request { "login": "user", "password": "user" }
    When method POST
    Then status 200
    And def token = response.token
    And def userId = response.userId

    Given url 'http://localhost:3000/teamMates'
    And header x-access-token = token
    And header user_id = userId
    And param captainId = 2
    When method get
    Then status 200
    And match response contains  schema
    * print response
    * print schema

  Scenario: Get the latest declaration fail
    Given url 'http://localhost:3000/teamMate'
    When method get
    Then status 404
