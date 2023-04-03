Feature: GetAllCaptain

  Background:
    * url 'http://localhost:3000'
    * def login = call read('classpath:login.feature')
    * header x-access-token = login.token
    * header user_id = login.userId
    * def schema = [{captain_id : '#number', captain_user_id: '#number',captain_customer_id: '#number'}]

  @GetAllCaptainSuccessful
  Scenario: Get all captain
    Given path '/captains'
    When method get
    Then status 200
    And match  response contains schema


  Scenario: Get the latest declaration fail
    Given path '/captain'
    When method get
    Then status 404
