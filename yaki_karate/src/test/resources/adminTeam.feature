Feature: Team

  Background:
    * url 'http://localhost:8080'
    * def createData = call read('classpath:createData.feature')
    * def schema = {id : '#number', captainId: '#number', teamName: '#string'}

  @GetOwner
  Scenario: GetById, Update and Delete owner
    Given path '/teams/' + 1
    When method get
    Then status 200
    And match response == schema

    Given path '/teams/' + 1
    And request {captainId: 3, teamName: 'Team Red'}
    When method put
    Then status 200
    And match response == schema

    Given path '/teams/' + 1
    When method delete
    Then status 200
    And print response
