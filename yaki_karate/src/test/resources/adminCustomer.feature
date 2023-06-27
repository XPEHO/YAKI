Feature: GetACustomer

  Background:
    * url 'http://localhost:8080'
    * def schema = {id : '#number', customerName: '#string',ownerId: '#number',locationId: '#number'}

  @GetOneCustomerSuccessfull
  Scenario: Get one customer
    Given path '/customers/1'
    When method get
    Then status 200
    And match  response contains schema
