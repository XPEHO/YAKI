Feature: CreationDeclaration

  Background:
    * url 'http://localhost:3000'
    * def login = call read('classpath:login.feature')
    * header x-access-token =  login.token
    * header user_id = login.userId

  Scenario: Creation declaration successful
    * def timeStart = function(){ return java.time.LocalDate.now().toString() + "T08:00:00.950Z" }
    * def timeEnd = function(){ return java.time.LocalDate.now().toString() + "T18:00:00.950Z" }
    Given path '/declarations'
    And param mode = 'fullDay'
    And def now = java.time.OffsetDateTime.now().toString()
    And def requestPayload = [{ declarationDate: now, declarationDateStart: '#(timeStart())', declarationDateEnd: '#(timeEnd())', declarationTeamMateId: 4, declarationStatus: "remote" }]
    And request requestPayload
    When method POST
    Then status 201
    And match response == [{ declarationId: '#number', declarationDate: '#string', declarationDateStart: '#string', declarationDateEnd: '#string', declarationTeamMateId: '#number', declarationStatus: 'remote' }]

  Scenario: Creation declaration fail
    Given path '/declarations'
    And param mode = 'fullDay'
    And request [{"declarationDate": "" ,"declarationDateStart": "" ,"declarationDateEnd": "","declarationTeamMateId": '',  "declarationStatus": ""}]
    When method POST
    Then status 400
