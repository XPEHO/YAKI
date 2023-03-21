Feature: get the latest declaration

  Background:
    * url 'http://localhost:3000'
    * def login = call read('classpath:login.feature')
    * header x-access-token = login.token

  Scenario: Get the latest declaration successful
    Given path '/declarations'
    And param teamMateId = 4
    When method get
    Then status 200
    And match response contains { declarationId: '#number', declarationTeamMateId: 4, declarationDate: '#string', declarationStatus: 'Remote' }

  Scenario: Get the latest declaration fail
    Given path '/declarations'
    And param teamMateId = 5
    When method get
    Then status 404