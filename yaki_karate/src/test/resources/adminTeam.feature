Feature: Team

  Background:
    * url 'http://localhost:8080'
    * def schema = {id : '#number', captainsId: '#array', teamName: '#string',customerId: '#number', teamDescription: '#string'}
    Given path '/login/authenticate'
    And request { login: 'owner', password: 'owner' }
    When method post
    Then status 200
    And def token = 'Bearer ' + response.token

  Scenario: 01 Create users
    Given path '/users'
    And header Authorization = token
    And request {id : 30, lastname: 'owner5', firstname: 'owner5', email: 'owner5@gmail.com', login: 'owner5', password: 'owner5'}
    When method post
    Then status 200

    Given path '/users'
    And header Authorization = token
    And request {id : 31, lastname: 'customer', firstname: 'customer', email: 'customer@gmail.com', login: 'customer', password: 'customer'}
    When method post
    Then status 200

    Given path '/users'
    And header Authorization = token
    And request {id : 32, lastname: 'captain', firstname: 'captain', email: 'captain@gmail.com', login: 'captain', password: 'captain'}
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
    And request { userId : 2 }
    When method post
    Then status 200

    Given path '/customers'
    And header Authorization = token
    And request { id : 2, customerName: "customer", ownerId : 1, locationId : 1}
    When method post
    Then status 200

    Given path '/captains'
    And header Authorization = token
    And request { userId : 4, customerId: 1 }
    When method post
    Then status 200

  Scenario: 03 create Team
    Given path '/login/authenticate'
    And request { login: 'owner', password: 'owner' }
    When method post
    Then status 200
    And def token = 'Bearer ' + response.token

    Given path '/teams'
    And header Authorization = token
    And request { captainsId : [2], teamName: "team_rocket", customerId: 2, teamDescription: "description team_rocket" }
    When method post
    Then status 200

  @GetOwner
  Scenario: 04 GetById Update and Delete owner
    Given path '/login/authenticate'
    And request { login: 'owner', password: 'owner' }
    When method post
    Then status 200
    And def token = 'Bearer ' + response.token

    Given path '/teams/' + 1
    And header Authorization = token
    When method get
    Then status 200
    And match response == schema

    Given path '/teams/' + 1
    And header Authorization = token
    And request {captainsId: [2], teamName: 'Team Red',customerId: 2, teamDescription: 'team is red'}
    When method put
    Then status 200
    And match response == schema

    Given path '/teams/' + 1
    And header Authorization = token
    When method delete
    Then status 200
    And print response
