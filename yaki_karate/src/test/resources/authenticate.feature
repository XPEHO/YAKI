Feature: Authenticate

  Background:
    * url 'http://localhost:3000'

  Scenario: Authenticate successful

    Given path '/login'
    And request { "login": "dupond", "password": "$5$rounds=10000$abcdefghijklmnop$5nP0MR35CzShPTl9K3Vl5gEF2kBc6cDKoQ2LEtG18FB"  }
    When method POST
    Then status 200

  Scenario: Authenticate fail

    Given path '/login'
    And request { "login": "aaa", "password": "aaa" }
    When method POST
    Then status 204
