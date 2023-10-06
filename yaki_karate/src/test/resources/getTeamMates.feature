Feature: GetTeammates

  Background:
    * def schema = [{userId : '#number', teammateId: '#number', userLastName: '#string', userFirstName: '#string',  team_id: "#number", team_name: "#string", declarationDate: "#string", declarationStatus: "#string"}]
    Given url 'http://localhost:8080/login/authenticate'
    And request { login: 'owner', password: 'owner' }
    When method post
    Then status 200
    And def token = 'Bearer ' + response.token
  Scenario: 01 Create user
    Given url 'http://localhost:8080/login/register'
    And request {id : 4, lastname: 'user4', firstname: 'user4', email: 'user4@gmail.com', login: 'user4', password: 'user4'}
    When method post
    Then status 200

    * def DbUtils = Java.type('org.example.utils.DbUtils')
    * def db = new DbUtils()
    * def token2 = db.readValue('SELECT token FROM public.verification_token WHERE verification_token_user_id = 18')
    Given url 'http://localhost:8080/login/registerConfirm'
    And param token = token2
    When method GET
    Then status 200

  @GetAllTeammateSuccessful
  Scenario: Get all teammate
    Given url 'http://localhost:3000/login'
    And request { "login": "roger", "password": "roger" }
    When method POST
    Then status 200
    And def token = response.token
    And def userId = response.userId

    Given url 'http://localhost:3000/teammates'
    And header x-access-token = token
    And header user_id = userId
    And param teammateId = 1 
    When method get
    Then status 200
    And match response contains  schema
    * print response
    * print schema
    

  Scenario: Get the latest declaration fail
    Given url 'http://localhost:3000/teammate'
    When method get
    Then status 404
