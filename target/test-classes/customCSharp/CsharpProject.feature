Feature: Feature that tests the reservation application implemented in .NET

  Background:
    * url baseUrl
    * def registerOwner = read('classpath:payloads/csharp/registerOwner.json')
    * def registerPersonell = read('classpath:payloads/csharp/registerPersonell.json')
    * def loginOwner = read('classpath:payloads/csharp/loginOwner.json')
    * def loginPersonell = read('classpath:payloads/csharp/loginPersonell.json')
    * def registerHotel = read('classpath:payloads/csharp/registerHotel.json')
    * def random_string = read('classpath:customCSharp/randomStringFunction.js')
    * def random_number = read('classpath:customCSharp/randomNumberFunction.js')
    * def addReservation = read('classpath:payloads/csharp/addReservation.json')
    * def getReservations = read('classpath:payloads/csharp/getReservations.json')

  Scenario: Testing register, login for both type of users, create a hotel, add employee to hotel
    # register owner
    Given path '/api/User/register'
    And request registerOwner
    When method POST
    Then status 200
    And match response.message == "Success"
    # register personell
    Given path '/api/User/register'
    And request registerPersonell
    When method POST
    Then status 200
    And match response.message == "Success"
    # login owner and keep token
    Given path '/api/User/login'
    And request loginOwner
    When method POST
    Then status 200
    * def tokenOwner = response.responseData
    # login personell and keep token
    Given path '/api/User/login'
    And request loginPersonell
    When method POST
    Then status 200
    * def tokenPersonell = response.responseData
    # generate random hotel name
    * def hotelName = random_string(10)
    * print hotelName
    * registerHotel.name = hotelName
    # register new hotel
    Given path '/api/Hotel/register'
    And request registerHotel
    And header Authorization = 'Bearer '+tokenOwner
    When method POST
    Then status 200
    And match response.responseData == "The hotel profile has been created!"
    # generate random number
    * def numberOfPersons = random_number(1, 10)
    * print numberOfPersons
    * def addRoom = read('classpath:payloads/csharp/addRoom.json')
    # add new room
    Given path '/api/Room/addNewRoom'
    And request addRoom
    And header Authorization = 'Bearer '+tokenOwner
    When method POST
    Then status 200
    And match response.responseData == "The room has been added!"
    # generate comment
    * def comment = random_string(25);
    * print comment
    * def addComment = read('classpath:payloads/csharp/addComment.json')
    * addComment.message = comment
    # add new comment
    Given path '/api/Comments/addComment'
    And request addComment
    And header Authorization = 'Bearer '+tokenOwner
    When method POST
    Then status 200
    And match response.responseData == "The comment has been saved"
    # get hotel names
    Given path '/api/Hotel/getHotelNames'
    And header Authorization = 'Bearer '+tokenPersonell
    When method GET
    Then status 200
    * print response
    * def arrayLength = karate.sizeOf(response.responseData)
    * def lastElement = response.responseData[arrayLength - 1]
    And match lastElement == hotelName
    # add employee to hotel
    * def addEmployee = read('classpath:payloads/csharp/addEmployee.json')
    Given path '/api/Hotel/addEmployee'
    And request addEmployee
    When method POST
    Then status 200
    And match response.responseData == "The employee has been added at the hotel!"
    # add reservation
    Given path '/api/Reservation/addReservation'
    And request addReservation
    And header Authorization = 'Bearer '+tokenPersonell
    When method POST
    Then status 200
    And match response.responseData == "The reservation has been added!"
    # get reservation
    Given path '/api/Reservation/getReservations'
    And request getReservations
    And header Authorization = 'Bearer '+tokenPersonell
    When method POST
    Then status 200
    * print response
    # delete hotel
    Given path '/api/Hotel/delete'
    And path hotelName
    And header Authorization = 'Bearer '+tokenOwner
    When method DELETE
    Then status 200
    And match response.responseData == "The hotel profile has been  deleted!"
