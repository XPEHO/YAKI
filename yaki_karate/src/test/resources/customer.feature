Feature: GetAllCaptain

  Background:
    * url 'http://localhost:8080'
    * def login = call read('classpath:login.feature')
    * header x-access-token = login.token
    * header user_id = login.userId
    * def schema = {id : '#number', customerName: '#string',ownerId: '#number',locationId: '#number'}

  @GetOneCustomerSuccessfull
  Scenario: Get one customer
    Given path '/customers/1'
    When method get
    Then status 200
    And match  response contains schema


  Scenario: Get the latest declaration fail
    Given path '/customers/205'
    When method get
    Then status 404
