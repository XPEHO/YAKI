Feature: CreationDeclaration

  Background:
    * url 'http://localhost:3000'
    * def login = call read('classpath:login.feature')
    * header x-access-token =  login.token
    * header user_id = login.userId

  Scenario: Creation declaration successful
    Given path '/declarations'
    And param mode = 'fullDay'
    And def now = java.time.LocalDateTime.now().toString()
    And def start = java.time.LocalDateTime.now().withHour(8).withMinute(0).withSecond(0).toString()
    And def end = java.time.LocalDateTime.now().withHour(18).withMinute(0).withSecond(0).toString()
    And def requestPayload = [{ declarationDate: now, declarationDateStart: start, declarationDateEnd: end, declarationTeamMateId: 4, declarationStatus: "remote" }]
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
