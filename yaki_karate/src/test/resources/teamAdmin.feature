Feature: Team

  Background:
    * url 'http://localhost:8080'
    * def schema = {id : '#number', captainId: '#number', teamName: '#string'}

  Scenario: 01 Create users
    Given path '/users'
    And request {id : 1, lastname: 'owner', firstname: 'owner', email: 'owner@gmail.com', login: 'owner', password: 'owner'}
    When method post
    Then status 200

  @GetOwner
  Scenario: Create, GetById, Update and Delete owner
    Given path '/teams'
    And request {captainId: 2, teamName: 'Team Rocket'}
    When method post
    Then status 200
    And match response.id != null
    And def teamId = response.id
    And match response == schema

    Given path '/teams/' + teamId
    When method get
    Then status 200
    And match response == schema

    Given path '/teams/' + teamId
    And request {captainId: 3, teamName: 'Team Red'}
    When method put
    Then status 200
    And match response == schema

    Given path '/teams/' + teamId
    When method delete
    Then status 200
    And print response
