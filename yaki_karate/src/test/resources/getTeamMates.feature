Feature: GetTeamMates

  Background:
    * url 'http://localhost:3000'
    * def login = call read('classpath:login.feature')
    * header x-access-token = login.token
    * header user_id = login.userId
    * def schema = [{userId : '#number', teamMateId: '#number', userLastName: '#string', userFirstName: '#string', declarationDate: "#string", declarationStatus: "#string"}]

  @GetAllTeamMateSuccessful
  Scenario: Get all teamMate
    Given path '/teamMates'
    And param captainId = 1
    When method get
    Then status 200
    And match response contains  schema
    * print response
    * print schema

  Scenario: Get the latest declaration fail
    Given path '/teamMate'
    When method get
    Then status 404
