Feature: Authenticate

  Scenario: 01 Create users teamate
    Given url 'http://localhost:8080/users'
    And request {id : 1, lastname: 'Moar', firstname: 'Roger', email: 'roger-mort@gmail.com', login: 'roger', password: 'roger'}
    When method post
    Then status 200

  Scenario: 02 Create user captain
    Given url 'http://localhost:8080/users'
    And request {id : 2, lastname: 'Cownerie', firstname: 'Sean', email: 'sean-connerie@gmail.com', login: 'sean', password: 'sean'}
    When method post
    Then status 200

  Scenario: 03 Create user Owner
    Given url 'http://localhost:8080/users'
    And request {id : 3, lastname: 'Owner', firstname: 'Owner', email: 'owner@gmail.com', login: 'owner', password: 'owner'}
    When method post
    Then status 200

  Scenario: 04 Create user Customer
    Given url 'http://localhost:8080/users'
    And request {id : 4, lastname: 'Customer', firstname: 'Customer', email: 'customer@gmail.com', login: 'customer', password: 'customer'}
    When method post
    Then status 200

  Scenario: 05 Create owner job
    Given url 'http://localhost:8080/owners'
    And request { userId : 3 }
    When method post
    Then status 200

  Scenario: 06 Create customer
    Given url 'http://localhost:8080/customers'
    And request { id : 4, customerName: "customerName", ownerId : 1, locationId : 1}
    When method post
    Then status 200

  Scenario: 07 Create captain job
    Given url 'http://localhost:8080/captains'
    And request { userId : 2, customerId: 1 }
    When method post
    Then status 200

  @AuthenticateTeamMateSuccess
  Scenario: 08 Authenticate TeamMate successful
    Given url 'http://localhost:3000/login'
    And request { "login": "roger", "password": "roger"  }
    When method POST
    Then status 200

  @AuthenticateCaptainSuccess
  Scenario: 09 Authenticate Captain successful
    Given url 'http://localhost:3000/login'
    And request { "login": "sean", "password": "sean" }
    When method POST
    Then status 200

  Scenario: 10 Authenticate fail
    Given url 'http://localhost:3000/login'
    And request { "login": "aaa", "password": "aaa" }
    When method POST
    Then status 204
