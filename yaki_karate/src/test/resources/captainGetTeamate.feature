Feature: Captain
  Background:
    Given url 'http://localhost:8080/login/authenticate'
    And request { login: 'owner', password: 'owner' }
    When method post
    Then status 200
    And def token = 'Bearer ' + response.token

  Scenario: 01 Create user
    Given url 'http://localhost:8080/login/register'
    And request {lastname: 'owner4', firstname: 'owner4', email: 'owner4@gmail.com', login: 'owner4', password: 'owner4'}
    When method post
    Then status 200

    Given url 'http://localhost:8080/login/register'
    And request {lastname: 'customer2', firstname: 'customer2', email: 'customer2@gmail.com', login: 'customer2', password: 'customer2'}
    When method post
    Then status 200

    Given url 'http://localhost:8080/login/register'
    And request {lastname: 'captain2', firstname: 'captain2', email: 'captain2@gmail.com', login: 'captain2', password: 'captain2'}
    When method post
    Then status 200

    Given url 'http://localhost:8080/login/register'
    And request {lastname: 'adfetchTuser', firstname: 'adfetchTuser', email: 'fetchuser@gmail.com', login: 'adfetchTuser', password: 'adfetchTuser'}
    When method post
    Then status 200

    * def DbUtils = Java.type('org.example.utils.DbUtils')
    * def db = new DbUtils()
    * def token = db.readValue('SELECT token FROM public.verification_token WHERE verification_token_user_id = 10')
    * print token
    Given url 'http://localhost:8080/login/registerConfirm'
    And param token = token
    When method GET
    Then status 200

    * def token2 = db.readValue('SELECT token FROM public.verification_token WHERE verification_token_user_id = 11')
    Given url 'http://localhost:8080/login/registerConfirm'
    And param token = token2
    When method GET
    Then status 200

    * def token3 = db.readValue('SELECT token FROM public.verification_token WHERE verification_token_user_id = 12')
    Given url 'http://localhost:8080/login/registerConfirm'
    And param token = token3
    When method GET
    Then status 200

    * def token4 = db.readValue('SELECT token FROM public.verification_token WHERE verification_token_user_id = 13')
    Given url 'http://localhost:8080/login/registerConfirm'
    And param token = token4
    When method GET
    Then status 200

  Scenario: 02 Attribute role & create team
    And header Authorization = token
    Given url 'http://localhost:8080/owners'
    And request { userId : 1 }
    When method post
    Then status 200

    Given url 'http://localhost:8080/customers'
    And header Authorization = token
    And request { id : 2, customerName: "customer", ownerId : 1, locationId : 1}
    When method post
    Then status 200

    Given url 'http://localhost:8080/captains'
    And header Authorization = token
    And request {userId : 3, customerId: 1 }
    When method post
    Then status 200

    Given url 'http://localhost:8080/teams'
    And header Authorization = token
    And request { captainsId : [2], teamName: "adTeam_team_name", customerId: 2 }
    When method post
    Then status 200

    Given url 'http://localhost:8080/teammates'
    And header Authorization = token
    And request { teamId : 2, userId: 4 }
    When method post
    Then status 200

  Scenario: Request all team mates from a team takes less than 300 ms
    Given url 'http://localhost:3000/login'
    And request { "login": "captain2", "password": "captain2" }
    When method POST
    Then status 200
    And def token = response.token
    And def userId = response.userId

    Given url 'http://localhost:3000/teammates'
    And param teamId = 2
    And header x-access-token = token
    And header user_id = userId
    When method GET
    Then status 200
    And assert responseTime < 300
