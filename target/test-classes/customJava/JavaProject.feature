Feature: Acest feature cuprinde un scenariu complex pentru testarea request-urilor de register, login, subscribe si unsubscribe, upload, load, delete and rate videos si delete users

  Background:
    # Motivul alegerii unui scenariu complex in locul mai multor mai mici este prezentarea tuturor feature-urilor framework-ului.
    * url baseUrl
    * def registerUser = read('classpath:payloads/java/registerUser.json')
    * def registerModerator = read('classpath:payloads/java/registerModerator.json')
    * def loginUser = read('classpath:payloads/java/loginUser.json')
    * def loginModerator = read('classpath:payloads/java/loginModerator.json')
    * def subscribe = read('classpath:payloads/java/subscribe.json')
    * def unsubscribe = read('classpath:payloads/java/unsubscribe.json')
    * configure retry = { count: 100, interval: 10000 }
    * def count = 1
    * def interval = 10000
    * def waitUntil = read('classpath:customJava/waitUntilTrueFunction.js')
    * def userRating = read('classpath:payloads/java/userRating.json')
    * def deleteCourse = read('classpath:payloads/java/deleteCourse.json')
    * def loginAdmin = read('classpath:payloads/java/loginAdmin.json')
    * def deleteModerator =
    """
      {
        "email" : "tibi.buzera@gmail.com"
      }
    """
    * def deleteUser =
    """
      {
        "email" : "tibi.alex@yahoo.com"
      }
    """

  Scenario: Testam request-urile mentionate mai sus
    # register user
    Given path '/api/register'
    And request registerUser
    When method POST
    Then status 200
    And match response == "You have been registered, now confirm your email!"
    # register moderator
    Given path '/api/register'
    And request registerModerator
    When method POST
    Then status 200
    And match response == "You have been registered, now confirm your email!"
    # login user and keep token
    Given path '/api/login'
    And request loginUser
    When method POST
    Then status 200
    * def userToken = response.jwt
    # login moderator and keep token
    Given path '/api/login'
    And request loginModerator
    When method POST
    Then status 200
    * def moderatorToken = response.jwt
    # user subscribes to moderator
    Given path '/api/subscribe'
    And request subscribe
    And header Authorization = 'Bearer '+userToken
    When method POST
    Then status 200
    And match response == "You have subscribed to tibi.buzera@gmail.com"
    # user unsubscribes from moderator
    Given path '/api/unsubscribe'
    And request unsubscribe
    And header Authorization = 'Bearer '+userToken
    When method POST
    Then status 200
    And match response == "You have unsubscribed from tibi.buzera@gmail.com"
    # moderator uploads video
    Given path '/api/uploadCourse'
    And header Authorization = 'Bearer '+moderatorToken
    And multipart file file = { read:'classpath:payloads/java/video.mp4', filename:'video.mp4', Content-type:'multipart/form-data' }
    And multipart field email = "tibi.buzera@gmail.com"
    And multipart field title = "Titlu"
    And multipart field description = "Descriere"
    And multipart field type = "crypto"
    And configure connectTimeout = 300000
    When method POST
    Then status 200
    And match response == "SUCCESS"
    # moderator loads his courses using a polling function
    * eval waitUntil(count, interval, moderatorToken)
    # user rates the video
    Given path '/api/rateCourse'
    And request userRating
    And header Authorization = 'Bearer '+userToken
    When method POST
    Then status 200
    And match response == "The rating has been updated"
    # moderator deletes the video
    Given path '/api/deleteCourse'
    And request deleteCourse
    And header Authorization = 'Bearer '+moderatorToken
    When method POST
    Then status 200
    And match response == "success"
    # login admin and keep token
    Given path '/api/login'
    And request loginAdmin
    When method POST
    Then status 200
    * def adminToken = response.jwt
    # admin deletes the users
    Given path '/api/deleteUser'
    And request deleteModerator
    When method POST
    Then status 200
    And match response == "success"
    Given path '/api/deleteUser'
    And request deleteUser
    When method POST
    Then status 200
    And match response == "success"