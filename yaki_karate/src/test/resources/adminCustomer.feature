Feature: GetACustomer

  Background:
    * url 'http://localhost:8080'
    * def registrationPayload = {"firstname": "dupond", "lastname": "beaucamp", "login": "bernardes", "email": "dupond.beaucamp@mail.com", "password": "bernardes"}
    * def registrationResponse = karate.callSingle('authenticate.feature', registrationPayload)
    * def token = registrationResponse.response.token
    * header Authorization = token
    * def schema = {id : '#number', customerName: '#string',ownerId: '#number',locationId: '#number'}

  @GetOneCustomerSuccessfull
  Scenario: 01 Get one customer
    Given path '/customers/1'
    When method get
    Then status 200
    And match  response contains schema

  @Cleanup
  Scenario: 02 Delete registered user
    Given path '/users'
    When method delete
    And param id = result.response.userId
    Then status 200
