Feature: Authenticate

  Background:
    * url 'http://localhost:3000'

  Scenario: Authenticate successful

    Given path '/login'
    And request { "login": "dupond", "password": "dupont"  }
    When method POST
    Then status 200

  Scenario: Authenticate fail

    Given path '/login'
    And request { "login": "aaa", "password": "aaa" }
    When method POST
    Then status 204
