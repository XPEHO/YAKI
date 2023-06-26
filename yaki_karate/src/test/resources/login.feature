Feature: Login

  Background:
    * url 'http://localhost:3000'
    * def createData = call read('classpath:createData.feature')

  Scenario: Login successful

    Given path '/login'
    And request { "login": "roger", "password": "roger"}
    When method POST
    Then status 200
    * def token = response.token
    * def userId = response.userId