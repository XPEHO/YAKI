Feature: Authenticate

  Background:
    * url 'http://localhost:3000'
    * def createData = call read('classpath:createData.feature')

  @AuthenticateTeamMateSuccess
  Scenario: Authenticate TeamMate successful

    Given path '/login'
    And request { "login": "roger", "password": "roger"  }
    When method POST
    Then status 200

  @AuthenticateCaptainSuccess
  Scenario: Authenticate TeamMate successful

    Given path '/login'
    And request { "login": "sean", "password": "sean" }
    When method POST
    Then status 200

  Scenario: Authenticate fail

    Given path '/login'
    And request { "login": "aaa", "password": "aaa" }
    When method POST
    Then status 204
