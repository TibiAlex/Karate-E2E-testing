Feature: auth with token

  Scenario: get user details
    Given header Authorization = 'Bearer '+token
    Given url baseUrl+'/public/v2/users'
    And path '626'
    When method GET
    Then status 200