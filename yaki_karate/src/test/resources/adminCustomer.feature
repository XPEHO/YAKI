Feature: GetACustomer

  Background:
    * url 'http://localhost:8080'
    * def schema = {id : '#number', customerName: '#string',ownerId: '#number',locationId: '#number'}
    Given path '/login/authenticate'
    And request { login: 'owner', password: 'owner' }
    When method post
    Then status 200
    And def token = 'Bearer ' + response.token
  @GetOneCustomerSuccessfull
  Scenario: 01 Get one customer

    Given path '/customers/1'
    And header Authorization = token
    When method get
    Then status 200
    And match  response contains schema
