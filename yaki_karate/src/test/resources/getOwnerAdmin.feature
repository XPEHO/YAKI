Feature : Owner

    Background:
      * url 'http://localhost:8080'
      * def token =
      * def schema = [{ownerId : '#number', ownerUserId: '#number'}]

    @GetOwnerById
    Scenario: Get owner by id
      Given path '/owner/' + ownerId
      And def ownerId = 1
      When method get
      Then status 200
      And match response == {ownerId: '#number', userId: '#number'}

    @CreateOwner
    Scenario: Create new owner
      Given path '/owner'
      And request {userId: 1}
      When method post
      Then status 201
      And match response == {ownerId: '#number', userId: '#number'}

    @UpdateOwner
    Scenario: Update existing owner
      Given path '/owner/' + ownerId
      And def ownerId = 1
      And request {userId: 2}
      When method put
      Then status 200
      And match response == {ownerId: '#number', userId: '#number'}

    @DeleteOwner
    Scenario: Delete existing owner
      Given path '/owner/' + ownerId
      And def ownerId = 1
      When method delete
      Then status 204



