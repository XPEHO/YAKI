Feature: Owner

  Background:
    * url 'http://localhost:8080'
    * def schema = {id : '#number', userId: '#number'}

  Scenario: 01 Create owner
    Given url 'http://localhost:8080/users'
    And request {id : 1, lastname: 'adOwnOwner', firstname: 'adOwnOwner', email: 'owner@gmail.com', login: 'adOwnowner', password: 'adOwnowner'}
    When method post
    Then status 200

    Given url 'http://localhost:8080/owners'
    And request { userId : 1 }
    When method post
    Then status 200

  @GetOwner
  Scenario: 03 Get all owners
    Given path '/owners/'
    When method get
    Then status 200
    And match response contains schema
    * print response
    * print schema

  Scenario: 04 GetById Update and Delete owner
    Given path '/owners/' + 2
    When method get
    Then status 200
    And match response == {id: '#number', userId: '#number'}

    Given path '/owners/' + 2
    And request {userId: 1}
    When method put
    Then status 200
    And match response == {id: '#number', userId: '#number'}

    Given path '/owners/' + 2
    When method delete
    Then status 200
    And print response


