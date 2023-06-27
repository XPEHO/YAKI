Feature: Captain

  Background:
    * def schema = [{id : '#number', userId : '#number', customerId : '#number' }]
    * def create = call read('createUsers.feature')
    * def create2 = call read('createData.feature')

  Scenario: 03 Get all captains
    Given url 'http://localhost:8080/captains'
    When method get
    Then status 200
    And match response contains schema
    * print response
    * print schema

  Scenario: 04 GetById Update and Delete captain
    Given url 'http://localhost:8080/captains/' + 1
    When method get
    Then status 200
    And match response == {id: '#number', userId: '#number', customerId : '#number'}

    Given url 'http://localhost:8080/captains/' + 1
    And request {userId: 3, customerId: 1}
    When method put
    Then status 200
    And match response == {id: '#number', userId: '#number', customerId : '#number'}

    Given url 'http://localhost:8080/captains/' + 1
    When method delete
    Then status 200
    And print response



