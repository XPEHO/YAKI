Feature: Team Management
  Customer wants to be able to manage teams of its company

  Scenario: Customer access the teams page
    Given I launch the application and login as a "customer"
    Then I should see the button "Teams" in the sidebar
    When I click on the button "Teams" in the sidebar
    Then I should be on "team-list" path
    Then I close the application

  Scenario: Customer can't access the teams page
    Given I launch the application and login as a "captain"
    Then I should not see the button "Teams" in the sidebar
    Then I close the application
