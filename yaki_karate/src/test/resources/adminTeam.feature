Feature: Team

  Background:
    * url 'http://localhost:8080'
    * def schema = {id : '#number', captainId: '#number', teamName: '#string'}

  Scenario: 01 Create users
    Given path '/users'
    And request {id : 1, lastname: 'adTeamOwner', firstname: 'adTeamOwner', email: 'owner@gmail.com', login: 'adTeamowner', password: 'adTeamowner'}
    When method post
    Then status 200

    Given path '/users'
    And request {id : 2, lastname: 'adTeamCustomer', firstname: 'adTeamCustomer', email: 'customer@gmail.com', login: 'adTeamcustomer', password: 'adTeamcustomer'}
    When method post
    Then status 200

    Given path '/users'
    And request {id : 3, lastname: 'adTeamcaptain', firstname: 'adTeamcaptain', email: 'captain@gmail.com', login: 'adTeamcaptain', password: 'adTeamcaptain'}
    When method post
    Then status 200

  Scenario: 02 Attribute roles (owner / customer / captain)
    Given path '/owners'
    And request { userId : 1 }
    When method post
    Then status 200

    Given path '/customers'
    And request { id : 2, customerName: "adTeamcustomer", ownerId : 1, locationId : 1}
    When method post
    Then status 200

    Given path '/captains'
    And request { userId : 3, customerId: 1 }
    When method post
    Then status 200

  Scenario: 03 create Team
    Given path '/teams'
    And request { captainId : 2, teamName: "adTeam_team_name" }
    When method post
    Then status 200

  @GetOwner
  Scenario: GetById, Update and Delete owner
    Given path '/teams/' + 1
    When method get
    Then status 200
    And match response == schema

    Given path '/teams/' + 1
    And request {captainId: 2, teamName: 'Team Red'}
    When method put
    Then status 200
    And match response == schema

    Given path '/teams/' + 1
    When method delete
    Then status 200
    And print response
