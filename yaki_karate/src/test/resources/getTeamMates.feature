Feature: GetTeamMates

  Background:
    * url 'http://localhost:3000'
    * def login = call read('classpath:login.feature')
    * header x-access-token = login.token
    * header user_id = login.userId
    * def schema = [{user_id : '#number', user_last_name: '#string', user_first_name: '#string',user_email: '#string',user_login: '#string', team_mate_id: '#number',team_mate_team_id: '#number',team_mate_user_id: '#number'}]

  @GetAllTeamMateSuccessful
  Scenario: Get all teamMate
    Given path '/teamMates'
    When method get
    Then status 200
    And match response contains deep schema

  Scenario: Get the latest declaration fail
    Given path '/teamMate'
    When method get
    Then status 404
