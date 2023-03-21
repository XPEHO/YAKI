Feature: Login

  Background:
    * url 'http://localhost:3000'

  Scenario: Login successful

    Given path '/login'
    And request { "login": "dupond", "password": "dupont" }
    When method POST
    Then status 200
    * def token = response.token