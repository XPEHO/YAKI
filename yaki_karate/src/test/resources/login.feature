Feature: Login

  Background:
    * url 'http://localhost:3000'

  Scenario: Login successful

    Given path '/login'
    And request { "login": "lavigne", "password": "lavigne"}
    When method POST
    Then status 200
    * def token = response.token
    * def userId = response.userId