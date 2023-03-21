Feature: Login

  Background:
    * url 'http://localhost:3000'

  Scenario: Login successful

    Given path '/login'
    And request { "login": "dupond", "password": "$5$rounds=10000$abcdefghijklmnop$5nP0MR35CzShPTl9K3Vl5gEF2kBc6cDKoQ2LEtG18FB"}
    When method POST
    Then status 200
    * def token = response.token