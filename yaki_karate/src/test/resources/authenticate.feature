Feature: Authenticate
  Scenario: 01 Create users
    Given url 'http://localhost:8080/login/register'
    And request { lastname: 'roger', firstname: 'roger', email: 'roger@gmail.com', login: 'roger', password: 'roger' }
    When method post
    Then status 200

    Given url 'http://localhost:8080/login/register'
    And request { lastname: 'sean', firstname: 'sean', email: 'sean@gmail.com', login: 'sean', password: 'sean' }
    When method post
    Then status 200

    * def DbUtils = Java.type('org.example.utils.DbUtils')
    * def db = new DbUtils()
    * def token = db.readValue('SELECT token FROM public.verification_token WHERE verification_token_user_id = 8')
    * print token
    Given url 'http://localhost:8080/login/registerConfirm'
    And param token = token
    When method GET
    Then status 200

    * def token2 = db.readValue('SELECT token FROM public.verification_token WHERE verification_token_user_id = 9')
    * print token
    Given url 'http://localhost:8080/login/registerConfirm'
    And param token = token2
    When method GET
    Then status 200

  @AuthenticateTeammateSuccess
  Scenario: 08 Authenticate Teammate successful
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
