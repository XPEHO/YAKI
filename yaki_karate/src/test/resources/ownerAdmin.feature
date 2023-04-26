Feature: Owner

    Background:
      * url 'http://localhost:8080'
      * def schema = [{id : '#number', userId: '#number'}]

    @GetOwner
      Scenario: Get all owners
      Given path '/Owner/'
      When method get
      Then status 200
      And match response contains  schema
      * print response
      * print schema

  @GetOwnerById
    Scenario: Get owner by id
      Given path '/Owner/'
      And param id =  1
      When method get
      Then status 200
      And match response contains  schema
      * print response
      * print schema

    @CreateOwner
    Scenario: Create new owner
      Given path '/Owner'
      And request {userId: 2}
      When method post
      Then status 200
      And match response == {id: '#number', userId: '#number'}

    @DeleteOwner
    Scenario: Delete existing owner
      Given path '/Owner/'
      And param id =  1
      When method delete
      Then status 200

    @UpdateOwner
    Scenario: Update existing owner
      Given path '/Owner/'
      And param id = 7
      When method put
      Then status 200
      And match response contains  schema
      * print response
      * print schema

