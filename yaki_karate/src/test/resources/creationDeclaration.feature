Feature: CreationDeclaration

  Background:
    * url 'http://localhost:3000'
    * def login = call read('classpath:login.feature')
    * header x-access-token =  login.token
    * header user_id = login.userId

  Scenario: Creation declaration successful
    Given path '/declarations'
    And def now = java.time.LocalDateTime.now().toString()
    And def requestPayload = { declarationTeamMateId: 4, declarationDate: now, declarationStatus: "remote" }
    And request requestPayload
    When method POST
    Then status 201
    And match response == { declarationId: '#number', declarationTeamMateId: 4, declarationDate: '#string', declarationStatus: 'remote' }

  Scenario: Creation declaration fail
    Given path '/declarations'
    And request { "declarationTeamMateId": ,"declarationDate": "",  "declarationStatus": ""}
    When method POST
    Then status 400
