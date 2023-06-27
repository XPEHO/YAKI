Feature: Authenticate

  Scenario: 01 Create users
    Given url 'http://localhost:8080/users'
    And request {id : 20, lastname: 'roger', firstname: 'roger', email: 'roger@gmail.com', login: 'roger', password: 'roger'}
    When method post
    Then status 200

    Given url 'http://localhost:8080/users'
    And request {id : 21, lastname: 'sean', firstname: 'sean', email: 'sean@gmail.com', login: 'sean', password: 'sean'}
    When method post
    Then status 200


  @AuthenticateTeamMateSuccess
  Scenario: 08 Authenticate TeamMate successful
    Given url 'http://localhost:3000/login'
    And request { "login": "roger", "password": "roger"  }
    When method POST
    Then status 200

  @AuthenticateCaptainSuccess
  Scenario: 09 Authenticate Captain successful
    Given url 'http://localhost:3000/login'
    And request { "login": "sean", "password": "sean" }
    When method POST
    Then status 200

  Scenario: 10 Authenticate fail
    Given url 'http://localhost:3000/login'
    And request { "login": "aaa", "password": "aaa" }
    When method POST
    Then status 204
