Feature: Login Admin

  Background:
  * url 'http://localhost:8080'
  Given path '/login/register'
  And request {"firstname" : "dupond", "lastname" : "beaucamp", "login" : "bernardes" , "email" : "dupond.beaucamp@mail.com", "password" : "bernardes" }
  When method post
  Then status 200

  @LoginAdminSuccess
  Scenario: Login to my account
    Given path '/login/authenticate'
    And request {"password" : "bernardes", "login" : "bernardes"}
    When method POST
    Then status 200
    And match response == {token: '#string', id: '#number'}

  @Cleanup
  Scenario: 03 Delete registered user
    Given path '/users'
    When method delete
    And param id = result.response.userId
    Then status 200
