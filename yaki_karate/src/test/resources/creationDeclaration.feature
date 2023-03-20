Feature: CreationDeclaration

  Background:
    * url 'http://localhost:3000'
    * def login = call read('classpath:login.feature')
    * header x-access-token = login.token

  Scenario: Creation declaration successful
    Given path '/declarations'
    And set $currentDate = new Date().toISOString()
    And set $request = {"declarationTeamMateId": 4, "declarationDate": "$currentDate", "declarationStatus": "Remote" }
    When method POST
    Then status 201
    And match response == { declarationId: '#number', declarationTeamMateId: 4, declarationDate: '$currentDate', declarationStatus: 'Remote' }

  Scenario: Creation declaration fail
    Given path '/declarations'
    And request { "declarationTeamMateId": ,"declarationDate": "",  "declarationStatus": ""}
    When method POST
    Then status 400