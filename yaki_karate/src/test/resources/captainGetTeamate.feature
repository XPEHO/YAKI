Feature: Captain

#  Background:
#    * def result = call read('authenticate.feature@AuthenticateCaptainSuccess')
#    * def token = result.response.token

  Scenario: 01 Create user
    Given url 'http://localhost:8080/users'
    And request {id : 1, lastname: 'adfetchTOwner', firstname: 'adfetchTOwner', email: 'owner@gmail.com', login: 'adfetchTowner', password: 'adfetchTowner'}
    When method post
    Then status 200

    Given url 'http://localhost:8080/users'
    And request {id : 2, lastname: 'adfetchTCustomer', firstname: 'adfetchTCustomer', email: 'customer@gmail.com', login: 'adfetchTcustomer', password: 'adfetchTcustomer'}
    When method post
    Then status 200

    Given url 'http://localhost:8080/users'
    And request {id : 3, lastname: 'adfetchTcaptain', firstname: 'adfetchTcaptain', email: 'captain@gmail.com', login: 'adfetchTcaptain', password: 'adfetchTcaptain'}
    When method post
    Then status 200

    Given url 'http://localhost:8080/users'
    And request {id : 4, lastname: 'adfetchTuser', firstname: 'adfetchTuser', email: 'owner@gmail.com', login: 'adfetchTuser', password: 'adfetchTuser'}
    When method post
    Then status 200

  Scenario: 02 Attribute role & create team
    Given url 'http://localhost:8080/owners'
    And request { userId : 1 }
    When method post
    Then status 200

    Given url 'http://localhost:8080/customers'
    And request { id : 2, customerName: "adTeamcustomer", ownerId : 1, locationId : 1}
    When method post
    Then status 200

    Given url 'http://localhost:8080/captains'
    And request { userId : 3, customerId: 1 }
    When method post
    Then status 200

    Given url 'http://localhost:8080/teams'
    And request { captainId : 2, teamName: "adTeam_team_name" }
    When method post
    Then status 200

    Given url 'http://localhost:8080/teammates'
    And request { teamId : 2, userId: 4 }
    When method post
    Then status 200

  Scenario: Request all team mates from a team takes less than 300 ms
    Given url 'http://localhost:3000/login'
    And request { "login": "adfetchTcaptain", "password": "adfetchTcaptain" }
    When method POST
    Then status 200
    And def token = response.token
    And def userId = response.userId

    Given url 'http://localhost:3000/teamMates'
    And param captainId = 2
    And header x-access-token = token
    And header user_id = userId
    When method GET
    Then status 200
    And assert responseTime < 300
