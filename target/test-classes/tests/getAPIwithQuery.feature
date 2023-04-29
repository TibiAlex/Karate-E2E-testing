Feature: Get API with query parameters

  Scenario: Get all active users
    * def query = {status:'active', gender:'male', id:23}
    Given url baseUrl+'/public/v2/users'
    And params query
    When method GET
    Then status 200
    * print response

  Scenario: Get all active users count
    * def query = {status:'active'}
    Given url baseUrl+'/public/v2/users'
    And params query
    When method GET
    Then status 200
    * def jsonResponse = response
    * print jsonResponse
    * def userCount = jsonResponse.length
    * print userCount