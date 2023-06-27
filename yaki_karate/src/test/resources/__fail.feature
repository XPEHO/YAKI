  Background:
  * url 'http://localhost:8080'

  Scenario: Get the latest declaration fail
  Given url 'http://localhost:3000/login'
  And request { "login": "user", "password": "user" }
  When method POST
  Then status 200
  And def token = response.token
  And def userId = response.userId
  And def teamMateId = response.teamMateId

  Given url 'http://localhost:3000/declarations'
  And header x-access-token = token
  And header user_id = userId
  And param teamMateId = 900
  When method get
  Then status 404

  Scenario: Get the latest declaration fail
  Given url 'http://localhost:3000/login'
  And request { "login": "user", "password": "user" }
  When method POST
  Then status 200
  And def token = response.token
  And def userId = response.userId
  And def teamMateId = response.teamMateId

  Given url 'http://localhost:3000/declarations'
  And header x-access-token = token
  And header user_id = userId
  And param teamMateId = 900
  When method get
  Then status 404

  Scenario: Get the latest declaration fail
  Given url 'http://localhost:3000/login'
  And request { "login": "user", "password": "user" }
  When method POST
  Then status 200
  And def token = response.token
  And def userId = response.userId
  And def teamMateId = response.teamMateId

  Given url 'http://localhost:3000/declarations'
  And header x-access-token = token
  And header user_id = userId
  And param teamMateId = 900
  When method get
  Then status 404

  Scenario: Get the latest declaration fail
  Given url 'http://localhost:3000/login'
  And request { "login": "user", "password": "user" }
  When method POST
  Then status 200
  And def token = response.token
  And def userId = response.userId
  And def teamMateId = response.teamMateId

  Given url 'http://localhost:3000/declarations'
  And header x-access-token = token
  And header user_id = userId
  And param teamMateId = 900
  When method get
  Then status 404

  Scenario: Get the latest declaration fail
  Given url 'http://localhost:3000/login'
  And request { "login": "user", "password": "user" }
  When method POST
  Then status 200
  And def token = response.token
  And def userId = response.userId
  And def teamMateId = response.teamMateId

  Given url 'http://localhost:3000/declarations'
  And header x-access-token = token
  And header user_id = userId
  And param teamMateId = 900
  When method get
  Then status 404

  Scenario: Get the latest declaration fail
  Given url 'http://localhost:3000/login'
  And request { "login": "user", "password": "user" }
  When method POST
  Then status 200
  And def token = response.token
  And def userId = response.userId
  And def teamMateId = response.teamMateId

  Given url 'http://localhost:3000/declarations'
  And header x-access-token = token
  And header user_id = userId
  And param teamMateId = 900
  When method get
  Then status 404

  Scenario: Get the latest declaration fail
  Given url 'http://localhost:3000/login'
  And request { "login": "user", "password": "user" }
  When method POST
  Then status 200
  And def token = response.token
  And def userId = response.userId
  And def teamMateId = response.teamMateId

  Given url 'http://localhost:3000/declarations'
  And header x-access-token = token
  And header user_id = userId
  And param teamMateId = 900
  When method get
  Then status 404
