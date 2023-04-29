Feature: put request

  Background:
    * url 'https://gorest.co.in'
    * def requestPayload =
    """
    {
      "status": "active"
    }
    """

  Scenario: update user with the given data
    Given path '/public/v2/users/101'
    And request requestPayload
    And header Authorization = 'Bearer '+token
    When method PUT
    Then status 200
    And match $.status == 'active'