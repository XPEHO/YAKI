Feature: Captain

  Scenario: 01 Create user
    Given url 'http://localhost:8080/users'
    And request {id : 1, lastname: 'owner', firstname: 'owner', email: 'owner@gmail.com', login: 'owner', password: 'owner'}
    When method post
    Then status 200

    Given url 'http://localhost:8080/users'
    And request {id : 2, lastname: 'customer', firstname: 'customer', email: 'customer@gmail.com', login: 'customer', password: 'customer'}
    When method post
    Then status 200

    Given url 'http://localhost:8080/users'
    And request {id : 3, lastname: 'captain', firstname: 'captain', email: 'captain@gmail.com', login: 'captain', password: 'captain'}
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
    And request { id : 2, customerName: "customer", ownerId : 1, locationId : 1}
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
    And request { "login": "captain", "password": "captain" }
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
