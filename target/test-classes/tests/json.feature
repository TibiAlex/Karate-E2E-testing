Feature: Json feature testing

  Scenario: Json reader parser

    * def jsonObject =
    """
    [
    {
      "name" : "Tom",
      "city" : "Banglore",
      "age" : 25
    },
    {
      "name" : "Peter",
      "city" : "LA",
      "age" : 35
    }
    ]
    """

    * print jsonObject
    * print jsonObject[0].name

  Scenario: Complex json reader
    * def jsonObject =
    """
    {"menu": {
        "id": "file",
        "value": "File",
        "popup": {
          "menuitem": [
            {"value": "New", "onclick": "CreateNewDoc()"},
            {"value": "Open", "onclick": "OpenDoc()"},
            {"value": "Close", "onclick": "CloseDoc()"}
          ]
        }
    }}
    """
    * print jsonObject