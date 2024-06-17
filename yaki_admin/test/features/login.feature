Feature: Login
  Customer wants to be able to login to the application

  Scenario: Login as Customer
    Given I launch the application
    When I enter the login as "lazard"
    When I enter the password as "lazard"
    When I click on login button
    Then I should be redirected to the dashboard
    Then I close the application

  Scenario: Login as Captain
    Given I launch the application
    When I enter the login as "lavigne"
    When I enter the password as "lavigne"
    When I click on login button
    Then I should be redirected to the dashboard
    Then I close the application
