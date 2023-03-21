Feature: Captain

  Background:
    * url 'http://localhost:3000'

  Scenario: Request all team mates from a team takes less than 300 mates

    * def result = call read('authenticate.feature@AuthenticateSuccess')
    * def token = result.response.token

    Given path '/teamMates?teamId=1'
    When method GET
    Then status 200
    And assert responseTime < 300
