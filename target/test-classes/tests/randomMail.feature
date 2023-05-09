Feature: post request

  Background:
    * url 'https://gorest.co.in'
    * def random_string =
    """
      function(s) {
        var text = "";
        var pattern = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz";
        for(var i = 0; i < s; i++) {
          text += pattern.charAt(Math.floor(Math.random() * pattern.length()));
        }
        return text;
      }
    """
    * def randomString = random_string(10)
    * print randomString
    * def requestPayload =
    """
    {
      "name": "tom",
      "gender": "male",
      "status": "active"
    }
    """
    * requestPayload.email = randomString  +"@gmail.com"

  Scenario: create user with the given data
    Given path '/public/v2/users'
    And request requestPayload
    And header Authorization = 'Bearer '+token
    When method POST
    Then status 201
    And match $.id == '#present'
    And match $.name == '#present'
    And match $.name == 'tom'