Feature: UpdateDeclaration

  Background:
    * url 'http://localhost:3000'
    * def login = call read('classpath:login.feature')
    * def declaration = call read('classpath:getLatestDeclaration.feature@GetTheLatestDeclarationSuccessful')
    * header x-access-token =  login.token
    * header user_id = login.userId

  Scenario: Update declaration successful
    Given def declarationId = declaration.response.declarationId
    And path '/declarations/' + declarationId
    And def now = java.time.LocalDateTime.now().toString()
    And def requestPayload = { declarationTeamMateId: 4, declarationDate: now, declarationDateStart: now, declarationDateEnd: now, declarationStatus: "remote" }
    And request requestPayload
    When method PUT
    Then status 200
    And match response == { declarationTeamMateId: 4, declarationDate: '#string', declarationDateStart: '#string', declarationDateEnd: '#string', declarationStatus: 'remote', user: '#notnull' }

  Scenario: Update declaration fail 404
    Given def declarationId = declaration.response.declarationId
    And path '/declarations/' + declarationId + 9
    And def requestPayload = { declarationTeamMateId: 4, declarationDate: now, declarationDateStart: now, declarationDateEnd: now, declarationStatus: 2 }
    And request requestPayload
    When method PUT
    Then status 404

  Scenario: Update declaration fail 404
    Given def declarationId = declaration.response.declarationId
    And path '/declarations/' + declarationId
    And def requestPayload = { declarationTeamMateId: "", declarationDate: now, declarationDateStart: now, declarationDateEnd: now, declarationStatus: "Rewote" }
    And request requestPayload
    When method PUT
    Then status 404