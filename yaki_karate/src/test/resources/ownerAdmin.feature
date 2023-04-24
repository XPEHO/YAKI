Feature: Owner

    Background:
      * url 'http://localhost:8080'
      * def schema = [{id : '#number', userId: '#number'}]

    @GetOwnerById
    Scenario: Get owner by id
      Given path '/owner/' + id
      And def id = 1
      When method get
      Then status 200
      And match response == {id: '#number', userId: '#number'}

    @CreateOwner
    Scenario: Create new owner
      Given path '/owner'
      And request {userId: 1}
      When method post
      Then status 200
      And match response == {id: '#number', userId: '#number'}

    @DeleteOwner
    Scenario: Delete existing owner
      Given path '/owner/' + id
      And def id = 1
      When method delete
      Then status 200