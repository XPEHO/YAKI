Feature : Captain

  Background:
    * url 'http://localhost:8080'
    * def schema = [{id : '#number', userId : '#number', customerId : '#number' }]

  @GetAllCaptains
  Scenario : Get all captains
    Given path '/captains/'
    When method get
    Then status 200
    And match response contains schema
      * print response
      * print schema


