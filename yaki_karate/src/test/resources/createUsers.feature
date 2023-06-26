Feature: Users

  Background:
    * url 'http://localhost:8080'
    * def schema = {id : '#number', lastname: '#string', firstname: '#string', email: '#string', login: '#string', password: '#string'}

  Scenario: Create users Roger
    Given path '/users'
    And request {id : 1, lastname: 'Moar', firstname: 'Roger', email: 'roger-mort@gmail.com', login: 'roger', password: 'roger'}
    When method post
    Then status 200

  Scenario: Create user Sean
    Given path '/users'
    And request {id : 2, lastname: 'Cownerie', firstname: 'Sean', email: 'sean-connerie@gmail.com', login: 'sean', password: 'sean'}
    When method post
    Then status 200

  Scenario: Create user Owner
    Given path '/users'
    And request {id : 3, lastname: 'Owner', firstname: 'Owner', email: 'owner@gmail.com', login: 'owner', password: 'owner'}
    When method post
    Then status 200

  Scenario: Create user Customer
    Given path '/users'
    And request {id : 4, lastname: 'Customer', firstname: 'Customer', email: 'customer@gmail.com', login: 'customer', password: 'customer'}
    When method post
    Then status 200

