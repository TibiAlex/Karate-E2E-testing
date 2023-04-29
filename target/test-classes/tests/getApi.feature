Feature: Get API feature

  Scenario: Get user details
    Given url baseUrl+'/public/v2/users'
    And path '626'
    When method GET
    Then status 200
    * print response
    * def jsonResponse = response
    * print jsonResponse
    * def actName = jsonResponse.name
    * print actName
    * match actName == "Sushil Marar"

  Scenario: Get user details that do not exist
    Given url baseUrl+'/public/v2/users'
    And path '1'
    When method GET
    Then status 404
