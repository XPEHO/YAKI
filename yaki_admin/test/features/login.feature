Feature: Login
  Customer wants to be able to login to the application

  Scenario: Login as Customer
    Given I launch the application
    When I enter the login as "customer"
    When I enter the password as "customer"
    When I click on login button
    Then I should be on "dashboard" path
    Then I close the application

  Scenario: Login as Captain
    Given I launch the application
    When I enter the login as "captain"
    When I enter the password as "captain"
    When I click on login button
    Then I should be on "dashboard" path
    Then I close the application
