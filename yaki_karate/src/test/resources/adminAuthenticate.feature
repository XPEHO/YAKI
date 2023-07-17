Feature: Register

  Background:
    * url 'http://localhost:8080'
    * def schema = {id : '#number', userId : '#number', customerId : '#number' }
    * def DbUtils = Java.type('org.example.utils.DbUtils')
    * def db = new DbUtils(databaseUrl,dbUser,dbPassword)

  Scenario: Register
    Given path '/login/register'
    And request { lastname: 'owner', firstname: 'owner', email: 'owner@gmail.com', login: 'owner', password: 'owner' }
    When method post
    Then status 200

  Scenario: Confirm Register by simulating the click on the email
    * def token = db.readValue('SELECT token FROM public.verification_token WHERE verification_token_user_id = 1')
    * print token
    Given path '/login/registerConfirm'
    And param token = token
    When method GET
    Then status 200
