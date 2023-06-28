Feature: Captain

  Background:
    * url 'http://localhost:8080'
    * def schema = {id : '#number', userId : '#number', customerId : '#number' }

  Scenario: 01 Create users
    Given path '/login/register'
    And request { lastname: 'owner', firstname: 'owner', email: 'owner@gmail.com', login: 'owner', password: 'owner' }
    When method post
    Then status 200
    And def token = 'Bearer ' + response.token

    Given path '/users'
    And header Authorization = token
    And request {id : 2, lastname: 'customer', firstname: 'customer', email: 'customer@gmail.com', login: 'customer', password: 'customer'}
    When method post
    Then status 200

    Given path '/users'
    And header Authorization = token
    And request {id : 3, lastname: 'captain', firstname: 'captain', email: 'captain@gmail.com', login: 'captain', password: 'captain'}
    When method post
    Then status 200

    Given path '/users'
    And header Authorization = token
    And request {id : 4, lastname: 'owner2', firstname: 'owner2', email: 'owner2@gmail.com', login: 'owner2', password: 'owner2'}
    When method post
    Then status 200

  Scenario: 02 Attribute roles (owner / customer / captain)
    Given path '/login/authenticate'
    And request { login: 'owner', password: 'owner' }
    When method post
    Then status 200
    And def token = 'Bearer ' + response.token

    Given path '/owners'
    And header Authorization = token
    And request { userId : 4 }
    When method post
    Then status 200

    Given path '/customers'
    And header Authorization = token
    And request { id : 2, customerName: "adCapt_customer", ownerId : 1, locationId : 1}
    When method post
    Then status 200

    Given path '/captains'
    And header Authorization = token
    And request {id : 1, userId : 3, customerId: 1 }
    When method post
    Then status 200

  Scenario: 03 Get all captains
    Given path '/login/authenticate'
    And request { login: 'owner', password: 'owner' }
    When method post
    Then status 200
    And def token = 'Bearer ' + response.token

    Given path '/captains'
    And header Authorization = token
    When method get
    Then status 200
    And match response contains schema
    * print response
    * print schema

  Scenario: 04 GetById Update and Delete captain
    Given path '/login/authenticate'
    And request { login: 'owner', password: 'owner' }
    When method post
    Then status 200
    And def token = 'Bearer ' + response.token

    Given path '/captains/' + 1
    And header Authorization = token
    When method get
    Then status 200
    And match response == {id: '#number', userId: '#number', customerId : '#number'}

    Given path '/captains/' + 1
    And header Authorization = token
    And request {userId: 3, customerId: 1}
    When method put
    Then status 200
    And match response == {id: '#number', userId: '#number', customerId : '#number'}

    Given path '/captains/' + 1
    And header Authorization = token
    When method delete
    Then status 200
    And print response

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
