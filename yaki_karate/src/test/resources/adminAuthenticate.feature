Feature: Register

  Background:
    * url 'https://localhost:8080'
    * def schema = {id : '#number', userId : '#number', customerId : '#number' }

  Scenario: Register
    Given path '/login/register'
    And request { lastname: 'owner', firstname: 'owner', email: 'owner@gmail.com', login: 'owner', password: 'owner' }
    When method post
    Then status 200
