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

  Scenario: Confirm That the connection to database is correct
    * def token = db.readValue('SELECT user_id FROM public.user WHERE user_id = 1')
    Then match token == 1
