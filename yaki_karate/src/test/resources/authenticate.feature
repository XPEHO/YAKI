Feature: Authenticate

  Background:
    * url 'http://localhost:3000'

  @AuthenticateTeamMateSuccess
  Scenario: Authenticate TeamMate successful

    Given path '/login'
    And request { "login": "dupond", "password": "$2b$16$/QOMfvRTxIkPWvy2I8vGdeKjn6DtPHf9DAD86BlKR.lleTntRfsrO"  }
    When method POST
    Then status 200

  @AuthenticateCaptainSuccess
  Scenario: Authenticate TeamMate successful

    Given path '/login'
    And request { "login": "lavigne", "password": "$2b$16$/QOMfvRTxIkPWvy2I8vGdeEx/ALW4lxYvJPShsj49q/EPq9Y4HESC" }
    When method POST
    Then status 200

  Scenario: Authenticate fail

    Given path '/login'
    And request { "login": "aaa", "password": "aaa" }
    When method POST
    Then status 204
