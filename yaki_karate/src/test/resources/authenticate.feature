Feature: Authenticate

  Background:
    * url 'http://localhost:3000'

  @AuthenticateTeamMateSuccess
  Scenario: Authenticate TeamMate successful

    Given path '/login'
    And request { "login": "dupond", "password": "dupond"  }
    When method POST
    Then status 200

  @AuthenticateCaptainSuccess
  Scenario: Authenticate TeamMate successful

    Given path '/login'
    And request { "login": "lavigne", "password": "lavigne" }
    When method POST
    Then status 200

  Scenario: Authenticate fail

    Given path '/login'
    And request { "login": "aaa", "password": "aaa" }
    When method POST
    Then status 204
