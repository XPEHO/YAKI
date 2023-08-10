Feature: CreationDeclaration
  Background:
    Given url 'http://localhost:8080/login/authenticate'
    And request { login: 'owner', password: 'owner' }
    When method post
    Then status 200
    And def token = 'Bearer ' + response.token
  Scenario: 01 Create user
    Given url 'http://localhost:8080/login/register'
    And request { lastname: 'owner', firstname: 'owner', email: 'owner@gmail.com', login: 'owner', password: 'owner'}
    When method post
    Then status 200

    Given url 'http://localhost:8080/login/register'
    And request { lastname: 'customer', firstname: 'customer', email: 'customer@gmail.com', login: 'customer', password: 'customer'}
    When method post
    Then status 200

    Given url 'http://localhost:8080/login/register'
    And request { lastname: 'captain', firstname: 'captain', email: 'captain@gmail.com', login: 'captain', password: 'captain'}
    When method post
    Then status 200

    Given url 'http://localhost:8080/login/register'
    And request { lastname: 'user', firstname: 'user', email: 'owner@gmail.com', login: 'user', password: 'user'}
    When method post
    Then status 200

    * def DbUtils = Java.type('org.example.utils.DbUtils')
    * def db = new DbUtils()
    * def token2 = db.readValue('SELECT token FROM public.verification_token WHERE verification_token_user_id = 14')
    Given url 'http://localhost:8080/login/registerConfirm'
    And param token = token2
    When method GET
    Then status 200

    * def token3 = db.readValue('SELECT token FROM public.verification_token WHERE verification_token_user_id = 15')
    Given url 'http://localhost:8080/login/registerConfirm'
    And param token = token3
    When method GET
    Then status 200

    * def token4 = db.readValue('SELECT token FROM public.verification_token WHERE verification_token_user_id = 16')
    Given url 'http://localhost:8080/login/registerConfirm'
    And param token = token4
    When method GET
    Then status 200

    * def token5 = db.readValue('SELECT token FROM public.verification_token WHERE verification_token_user_id = 17')
    Given url 'http://localhost:8080/login/registerConfirm'
    And param token = token5
    When method GET
    Then status 200
  Scenario: 02 Attribute role & create team
    Given url 'http://localhost:8080/owners'
    And header Authorization = token
    And request { userId : 1 }
    When method post
    Then status 200

    Given url 'http://localhost:8080/customers'
    And header Authorization = token
    And request { id : 2, customerName: "adTeamcustomer", ownerId : 1, locationId : 1}
    When method post
    Then status 200

    Given url 'http://localhost:8080/captains'
    And header Authorization = token
    And request { userId : 3, customerId: 1 }
    When method post
    Then status 200

    Given url 'http://localhost:8080/teams'
    And header Authorization = token
    And request { captainsId : [2], teamName: "adTeam_team_name", customerId : 2 }
    When method post
    Then status 200

    Given url 'http://localhost:8080/teammates'
    And header Authorization = token
    And request { teamId : 2, userId: 4 }
    When method post
    Then status 200

  Scenario: Creation declaration successful
    Given url 'http://localhost:3000/login'
    And request { "login": "user", "password": "user" }
    When method POST
    Then status 200
    And def token = response.token
    And def userId = response.userId
    And def teammateId = response.teammateId

    * def timeStart = function(){ return java.time.LocalDate.now().toString() + "T08:00:00.950Z" }
    * def timeEnd = function(){ return java.time.LocalDate.now().toString() + "T18:00:00.950Z" }
    Given url 'http://localhost:3000/declarations'
    And header x-access-token = token
    And header user_id = userId
    And param mode = 'fullDay'
    And def now = java.time.OffsetDateTime.now().toString()
    And def requestPayload = [{ declarationDate: now, declarationDateStart: '#(timeStart())', declarationDateEnd: '#(timeEnd())', declarationTeammateId: 2, declarationStatus: "remote", declarationTeamId: 2 }]
    And request requestPayload
    When method POST
    Then status 201
    And match response == [{ declarationId: '#number', declarationDate: '#string', declarationDateStart: '#string', declarationDateEnd: '#string', declarationTeammateId: '#number', declarationStatus: 'remote', declarationTeamId: '#number' }]

  Scenario: Creation declaration fail
    Given url 'http://localhost:3000/login'
    And request { "login": "user", "password": "user" }
    When method POST
    Then status 200
    And def token = response.token
    And def userId = response.userId
    And def teammateId = response.teammateId

    Given url 'http://localhost:3000/declarations'
    And header x-access-token = token
    And header user_id = userId
    And param mode = 'fullDay'
    And request [{"declarationDate": "" ,"declarationDateStart": "" ,"declarationDateEnd": "","declarationTeammateId": '',  "declarationStatus": "", declarationTeamId: '' }]
    When method POST
    Then status 400

  Scenario: Get the latest declaration successful
    Given url 'http://localhost:3000/login'
    And request { "login": "user", "password": "user" }
    When method POST
    Then status 200
    And def token = response.token
    And def userId = response.userId
    And def teammateId = response.teammateId

    Given url 'http://localhost:3000/declarations'
    And header x-access-token = token
    And header user_id = userId
    And param teammateId = 2
    When method get
    Then status 200
    And match response contains [{ declarationId: '#number', declarationDate: '#string', declarationDateStart: '#string', declarationDateEnd: '#string', declarationTeammateId: '#number', declarationStatus: 'remote', declarationTeamId: '#number' }]

  Scenario: Get the latest declaration fail
    Given url 'http://localhost:3000/login'
    And request { "login": "user", "password": "user" }
    When method POST
    Then status 200
    And def token = response.token
    And def userId = response.userId
    And def teammateId = response.teammateId

    Given url 'http://localhost:3000/declarations'
    And header x-access-token = token
    And header user_id = userId
    And param teammateId = 900
    When method get
    Then status 404
