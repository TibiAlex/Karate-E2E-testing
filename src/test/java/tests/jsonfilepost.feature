Feature: post request

  Background:
    * url 'https://gorest.co.in'
    * def requestPayload = read('classpath:payloads/tests/user.json')

  Scenario: create user with the given data
    Given path '/public/v2/users'
    And request requestPayload
    And header Authorization = 'Bearer '+token
    When method POST
    Then status 201
    And match $.id == '#present'
    And match $.name == '#present'
    And match $.name == 'tom'