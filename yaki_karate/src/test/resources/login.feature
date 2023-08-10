Feature: Login
  Scenario: 01 Create user
    Given url 'http://localhost:8080/login/register'
    And request {id : 4, lastname: 'user', firstname: 'user', email: 'user@gmail.com', login: 'user', password: 'user'}
    When method post
    Then status 200

    * def DbUtils = Java.type('org.example.utils.DbUtils')
    * def db = new DbUtils()
    * def token = db.readValue('SELECT token FROM public.verification_token WHERE verification_token_user_id = 14')
    * print token
    Given url 'http://localhost:8080/login/registerConfirm'
    And param token = token
    When method GET
    Then status 200

  Scenario: Login successful
    Given url 'http://localhost:3000/login'
    And request { "login": "user", "password": "user"}
    When method POST
    Then status 200
    * def token = response.token
    * def userId = response.userId
