Feature: Authenticate

  Background:
    * url 'http://localhost:3000'

  @AuthenticateTeamMateSuccess
  Scenario: Authenticate TeamMate successful

    Given path '/login'
    And request { "login": "dupond", "password": "$5$rounds=10000$abcdefghijklmnop$5nP0MR35CzShPTl9K3Vl5gEF2kBc6cDKoQ2LEtG18FB"  }
    When method POST
    Then status 200

  @AuthenticateCaptainSuccess
  Scenario: Authenticate TeamMate successful

    Given path '/login'
    And request { "login": "lavigne", "password": "$5$rounds=10000$abcdefghijklmnop$aVV68ybbmry88mMGXU1snZOfwd0pKbYFTQbzrv.7n44" }
    When method POST
    Then status 200

  Scenario: Authenticate fail

    Given path '/login'
    And request { "login": "aaa", "password": "aaa" }
    When method POST
    Then status 204
