Feature: Owner

    Background:
      * url 'http://localhost:8080'
      * def createData = call read('classpath:createData.feature')
      * def schema = [{id : '#number', userId: '#number'}]

    @GetOwner
      Scenario: Get all owners
      Given path '/owners/'
      When method get
      Then status 200
      And match response contains schema
      * print response
      * print schema

    Scenario: GetById, Update and Delete owner
      Given path '/owners/' + 1
      When method get
      Then status 200
      And match response == {id: '#number', userId: '#number'}

      Given path '/owners/' + 1
      And request {userId: 3}
      When method put
      Then status 200
      And match response == {id: '#number', userId: '#number'}

      Given path '/owners/' + 1
      When method delete
      Then status 200
      And print response


