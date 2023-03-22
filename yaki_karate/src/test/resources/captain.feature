Feature: Captain

  Background:
    * def result = call read('authenticate.feature@AuthenticateCaptainSuccess')
    * def token = result.response.token
    * url 'http://localhost:3000'

  Scenario: Request all team mates from a team takes less than 300 ms

    Given path '/teamMates'
    And param captainId = 1
    And header x-access-token = token
    And header user_id = result.response.userId
    When method GET
    Then status 200
    And assert responseTime < 300
