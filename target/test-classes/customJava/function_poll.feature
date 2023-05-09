@ignore
Feature: Prin acest feature vom verifica daca s-a adaugat videoclipul cu success
  Background:
    * url baseUrl
    * def loadMyCoursesResponse = read('classpath:payloads/java/loadMyCoursesResponse.json')

  Scenario: Acest test va fii ignorat de fisierul .feature principal, si apelat doar in asteptarea terminarii upload-ului
    # moderator loads his courses using a polling function
    * def query = {status:'active'}
    Given path '/api/loadMyCourses'
    And params {email:'tibi.buzera@gmail.com'}
    And header Authorization = 'Bearer '+moderatorToken
    When method GET
    Then status 200