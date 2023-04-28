Feature: Owner

    Background:
      * url 'http://localhost:8080'
      * def schema = [{id : '#number', userId: '#number'}]

    @GetOwner
      Scenario: Get all owners
      Given path '/owners/'
      When method get
      Then status 200
      And match response contains schema
      * print response
      * print schema

    Scenario: Create, GetById, Update and Delete owner
      Given path '/owners'
      And request {userId: 2}
      When method post
      Then status 200
      And match response.id != null
      And def ownerId = response.id
      And match response == {id: '#number', userId: '#number'}

      Given path '/owners/' + ownerId
      When method get
      Then status 200
      And match response == {id: '#number', userId: '#number'}

      Given path '/owners/' + ownerId
      And request {userId: 3}
      When method put
      Then status 200
      And match response == {id: '#number', userId: '#number'}

      Given path '/owners/' + ownerId
      When method delete
      Then status 200
      And print response


