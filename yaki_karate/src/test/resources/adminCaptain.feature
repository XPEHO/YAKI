Feature: Captain

  Background:
    * def schema = {id : '#number', userId : '#number', customerId : '#number' }

  Scenario: 01 Create users
    Given url 'http://localhost:8080/users'
    And request {id : 1, lastname: 'adCaptOwner', firstname: 'adCaptOwner', email: 'owner@gmail.com', login: 'adCaptowner', password: 'adCaptowner'}
    When method post
    Then status 200

    Given url 'http://localhost:8080/users'
    And request {id : 2, lastname: 'adCaptCustomer', firstname: 'adCaptCustomer', email: 'customer@gmail.com', login: 'adCaptcustomer', password: 'adCaptcustomer'}
    When method post
    Then status 200

    Given url 'http://localhost:8080/users'
    And request {id : 3, lastname: 'adCaptcaptain', firstname: 'adCaptcaptain', email: 'captain@gmail.com', login: 'adCaptcaptain', password: 'adCaptcaptain'}
    When method post
    Then status 200

  Scenario: 02 Attribute roles (owner / customer / captain)
    Given url 'http://localhost:8080/owners'
    And request { userId : 1 }
    When method post
    Then status 200

    Given url 'http://localhost:8080/customers'
    And request { id : 2, customerName: "adCapt_customer", ownerId : 1, locationId : 1}
    When method post
    Then status 200

    Given url 'http://localhost:8080/captains'
    And request { userId : 3, customerId: 1 }
    When method post
    Then status 200

  Scenario: 03 Get all captains
    Given url 'http://localhost:8080/captains'
    When method get
    Then status 200
    And match response contains schema
    * print response
    * print schema

  Scenario: 04 GetById Update and Delete captain
    Given url 'http://localhost:8080/captains/' + 1
    When method get
    Then status 200
    And match response == {id: '#number', userId: '#number', customerId : '#number'}

    Given url 'http://localhost:8080/captains/' + 1
    And request {userId: 3, customerId: 1}
    When method put
    Then status 200
    And match response == {id: '#number', userId: '#number', customerId : '#number'}

    Given url 'http://localhost:8080/captains/' + 1
    When method delete
    Then status 200
    And print response



