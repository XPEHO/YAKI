Feature: Captain

  Background:
    * url 'http://localhost:8080'
    * def createData = call read('classpath:createData.feature')
    * def schema = [{id : '#number', userId : '#number', customerId : '#number' }]

  Scenario: Get all captains
    Given path '/captains/'
    When method get
    Then status 200
    And match response contains schema
      * print response
      * print schema

  Scenario: GetById, Update and Delete captain
    Given path '/captains/' + 1
    When method get
    Then status 200
    And match response == {id: '#number', userId: '#number', customerId : '#number'}

    Given path '/captains/' + 1
    And request {userId: 3, customerId: 1}
    When method put
    Then status 200
    And match response == {id: '#number', userId: '#number', customerId : '#number'}

    Given path '/captains/' + 1
    When method delete
    Then status 200
    And print response



