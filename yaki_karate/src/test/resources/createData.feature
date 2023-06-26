Feature: Data

  Background:
    * url 'http://localhost:8080'
    * def createUser = call read('classpath:createUsers.feature')

  Scenario: 01 Create owner
    Given path '/owners'
    And request { userId : 3 }
    When method post
    Then status 200

  Scenario: 02 Create customer
    Given path '/customers'
    And request { id : 4, customerName: "customerName", ownerId : 1, locationId : 1}
    When method post
    Then status 200

  Scenario: 03 Create captain
    Given path '/captains'
    And request { userId : 2, customerId: 1 }
    When method post
    Then status 200

  Scenario: 04 Create team
    Given path '/teams'
    And request { captainId : 1, teamName: "team_name" }
    When method post
    Then status 200

  Scenario: 05 Create teammate
    Given path '/teammates'
    And request { teamId : 1, userId: 1 }
    When method post
    Then status 200


