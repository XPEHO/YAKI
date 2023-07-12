Feature: Register

  Background:
    * url 'http://localhost:8080'
    * def schema = {id : '#number', userId : '#number', customerId : '#number' }
    * def DbUtils = Java.type('org.example.utils.DbUtils')
    * def db = new DbUtils()

  Scenario: Register
    Given path '/login/register'
    And request { lastname: 'owner', firstname: 'owner', email: 'owner@gmail.com', login: 'owner', password: 'owner' }
    When method post
    Then status 200

  Scenario: Confirm Register by simulating the click on the email
    * def token = db.readValue('SELECT token FROM public.verification_token WHERE verification_token_user_id = 1')
    Given path '/login/registerConfirm?token='+ token
    When method post
    Then status 200
