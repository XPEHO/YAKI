Feature: Login

  Background:
    * url 'http://localhost:3000'

  Scenario: 01 Create user
    Given url 'http://localhost:8080/users'
    And request {id : 4, lastname: 'user', firstname: 'user', email: 'owner@gmail.com', login: 'user', password: 'user'}
    When method post
    Then status 200

  Scenario: Login successful
    Given url 'http://localhost:3000/login'
    And request { "login": "user", "password": "user"}
    When method POST
    Then status 200
    * def token = response.token
    * def userId = response.userId