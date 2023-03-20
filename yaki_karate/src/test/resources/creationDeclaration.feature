Feature: CreationDeclaration

  Background:
    * url 'http://localhost:3000'
    * def login = call read('classpath:login.feature')
    * header x-access-token = login.token
  Scenario: Creation declaration successful

    Given path '/declarations'
    And request {"declarationTeamMateId": 4, "declarationDate": "2023-03-15T22:14:55.000Z", "declarationStatus": "Remote" }
    When method POST
    Then status 201


  Scenario: Creation declaration fail
    Given path '/declarations'
    And request { "declarationTeamMateId": ,"declarationDate": "",  "declarationStatus": ""}
    When method POST
    Then status 400