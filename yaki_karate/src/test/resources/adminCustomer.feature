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
    Given path '/login/register'
    And request { lastname: 'owner', firstname: 'owner', email: 'owner@gmail.com', login: 'owner', password: 'owner' }
    When method post
    Then status 200
    And def token = 'Bearer ' + response.token

    Given path '/customers/1'
    And header Authorization = token
    When method get
    Then status 200
    And match  response contains schema

  @Cleanup
  Scenario: 05 Delete registered user
    Given path '/login/authenticate'
    And request { login: 'owner', password: 'owner' }
    When method post
    Then status 200
    And def token = 'Bearer ' + response.token
    And def userId = response.id
    And print userId

    Given path '/users/' + userId
    And header Authorization = token
    When method delete
    Then status 200
