Feature: Captain

  Background:
    * url 'http://localhost:8080'
    * def schema = [{id : '#number', userId : '#number', customerId : '#number' }]

  Scenario: Get all captains
    Given path '/captains/'
    When method get
    Then status 200
    And match response contains schema
      * print response
      * print schema

  Scenario: Create, GetById, Update and Delete captain
    Given path '/captains'
    And request {userId: 10, customerId: 3}
    When method post
    Then status 200
    And match response.id != null
    And def captainId = response.id
    And match response == {id: '#number', userId: '#number', customerId : '#number'}

    Given path '/captains/' + captainId
    When method get
    Then status 200
    And match response == {id: '#number', userId: '#number', customerId : '#number'}

    Given path '/captains/' + captainId
    And request {userId: 3, customerId: 1}
    When method put
    Then status 200
    And match response == {id: '#number', userId: '#number', customerId : '#number'}

    Given path '/captains/' + captainId
    When method delete
    Then status 200
    And print response



