Feature: GetAllCaptain

  Background:
    * def schema = [{captain_id : '#number', captain_user_id: '#number',captain_customer_id: '#number'}]

  Scenario: 01 Create user
    Given url 'http://localhost:8080/users'
    And request {id : 4, lastname: 'user', firstname: 'user', email: 'owner@gmail.com', login: 'user', password: 'user'}
    When method post
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
