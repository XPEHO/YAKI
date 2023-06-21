Feature: Users

  Background:
    * url 'http://localhost:8080'
    * def schema = {id : '#number', lastName: '#string', firstName: '#string', email: '#string', login: '#string', password: '#string'}

  Scenario: Create users Roger
    Given path '/users'
    And request {id : 1, lastName: 'Mort', firstName: 'Roger', email: 'roger-mort@gmail.com', login: 'roger', password: 'roger'}
    When method post
    Then status 200

  Scenario: Create user Sean
    Given path '/users'
    And request {id : 2, lastName: 'Connerie', firstName: 'Sean', email: 'sean-connerie@gmail.com', login: 'sean', password: 'sean'}
    When method post
    Then status 200

