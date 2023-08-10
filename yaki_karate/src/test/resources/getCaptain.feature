Feature: GetAllCaptain
  Background:
    Given url 'http://localhost:8080/login/authenticate'
    And request { login: 'owner', password: 'owner' }
    When method post
    Then status 200
    And def token = 'Bearer ' + response.token
    * def schema = [{captain_id : '#number', captain_user_id: '#number',captain_customer_id: '#number'}]

  Scenario: 01 Create user
    Given url 'http://localhost:8080/login/register'
    And request {id : 4, lastname: 'user2', firstname: 'user2', email: 'user2@gmail.com', login: 'user2', password: 'user'}
    When method post
    Then status 200

    * def DbUtils = Java.type('org.example.utils.DbUtils')
    * def db = new DbUtils()
    * def token2 = db.readValue('SELECT token FROM public.verification_token WHERE verification_token_user_id = 18')
    Given url 'http://localhost:8080/login/registerConfirm'
    And param token = token2
    When method GET
    Then status 200

  @GetAllCaptainSuccessful
  Scenario: Get all captain
    Given url 'http://localhost:3000/login'
    And request { "login": "user", "password": "user" }
    When method POST
    Then status 200
    And def token = response.token
    And def userId = response.userId

    Given url 'http://localhost:3000/captains'
    And header x-access-token = token
    And header user_id = userId
    When method get
    Then status 200
    And match  response contains schema


  Scenario: Get all captain fail
    Given url 'http://localhost:3000/login'
    And request { "login": "user", "password": "user" }
    When method POST
    Then status 200
    And def token = response.token
    And def userId = response.userId

    #set path error, otherwise no idea how to recreate the fetch fail..
    Given url 'http://localhost:3000/captain'
    And header x-access-token = token
    And header user_id = userId
    When method get
    Then status 404
