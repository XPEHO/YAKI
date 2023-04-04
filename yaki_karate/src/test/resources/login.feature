Feature: Login

  Background:
    * url 'http://localhost:3000'

  Scenario: Login successful

    Given path '/login'
    And request { "login": "lavigne", "password": "$5$rounds=10000$abcdefghijklmnop$aVV68ybbmry88mMGXU1snZOfwd0pKbYFTQbzrv.7n44"}
    When method POST
    Then status 200
    * def token = response.token
    * def userId = response.userId