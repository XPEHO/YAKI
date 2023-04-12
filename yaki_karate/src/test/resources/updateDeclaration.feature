Feature: UpdateDeclaration

  Background:
    * url 'http://localhost:3000'
    * def login = call read('classpath:login.feature')
    * def declaration = call read('classpath:getLatestDeclaration.feature@GetTheLatestDeclarationSuccessful')
    * header x-access-token =  login.token
    * header user_id = login.userId

  Scenario: Update declaration successful
    * def timeStart = function(){ return java.time.LocalDate.now().toString() + "T08:00:00.950Z" }
    * def timeEnd = function(){ return java.time.LocalDate.now().toString() + "T18:00:00.950Z" }
    Given def declarationId = declaration.response[0].declarationId
    And path '/declarations/' + declarationId
    And def now = java.time.LocalDateTime.now().toString()
    And def requestPayload = [{ declarationDate: now, declarationDateStart: '#(timeStart())', declarationDateEnd: '#(timeEnd())', declarationTeamMateId: 4,  declarationStatus: "remote" }]
    And request requestPayload
    When method PUT
    Then status 200
    And match response == [{ declarationDate: '#string', declarationDateStart: '#string', declarationDateEnd: '#string', declarationTeamMateId: 4,  declarationStatus: 'remote'}]

  Scenario: Update declaration fail 404
    Given def declarationId = declaration.response[0].declarationId
    And path '/declarations/' + declarationId + 9
    And def requestPayload = [{declarationDate: now, declarationDateStart: '#(timeStart())', declarationDateEnd: '#(timeEnd())', declarationTeamMateId: 4,  declarationStatus: 2 }]
    And request requestPayload
    When method PUT
    Then status 404

  Scenario: Update declaration fail 404
    Given def declarationId = declaration.response[0].declarationId
    And path '/declarations/' + declarationId
    And def requestPayload = [{ declarationDate: now, declarationDateStart: '#(timeStart())', declarationDateEnd: '#(timeEnd())', declarationTeamMateId: "",  declarationStatus: "Rewote" }]
    And request requestPayload
    When method PUT
    Then status 404