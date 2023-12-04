Feature: Owner

  Background:
    * url 'http://localhost:8080'
    * def schema = {id : '#number', userId: '#number'}
    Given path '/login/authenticate'
    And request { login: 'owner', password: 'owner' }
    When method post
    Then status 200
    And def token = 'Bearer ' + response.token
  Scenario: 01 Create owner
    Given path '/owners'
    And header Authorization = token
    And request { userId : 2 }
    When method post
    Then status 200

  @GetOwner
  Scenario: 03 Get all owners
    Given path '/login/authenticate'
    And request { login: 'owner', password: 'owner' }
    When method post
    Then status 200
    And def token = 'Bearer ' + response.token

    Given path '/owners'
    And header Authorization = token
    When method get
    Then status 200
    And match response contains schema
    * print response
    * print schema

  Scenario: 04 GetById Update and Delete owner
    Given path '/login/authenticate'
    And request { login: 'owner', password: 'owner' }
    When method post
    Then status 200
    And def token = 'Bearer ' + response.token

    Given path '/owners/' + 2
    And header Authorization = token
    When method get
    Then status 200
    And match response == {id: '#number', userId: '#number'}

    Given path '/owners/' + 2
    And header Authorization = token
    And request {userId: 2}
    When method put
    Then status 200
    And match response == {id: '#number', userId: '#number'}

    Given path '/owners/' + 2
    And header Authorization = token
    When method delete
    Then status 200
    And print response
