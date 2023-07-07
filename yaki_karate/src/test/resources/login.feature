Feature: Login

  Background:

    Given url 'http://localhost:8080/login/authenticate'
    And request { login: 'owner', password: 'owner' }
    When method post
    Then status 200
    And def token = 'Bearer ' + response.token
    * url 'http://localhost:3000'
  Scenario: 01 Create user
    Given url 'http://localhost:8080/users'
    And header Authorization = token
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
