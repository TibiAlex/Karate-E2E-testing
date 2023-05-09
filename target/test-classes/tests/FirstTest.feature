Feature: Sample API tests

  Scenario: Test a Sample Get API

    * print 'hello world'
    Given url 'https://reqres.in/api/users?page=2'
    When method GET
    Then status 200

  Scenario: Declare and print variables

    * def balance = 200
    * def fee = 20
    * def tax = 10
    * print 'total amount ->' + balance + fee + tax

