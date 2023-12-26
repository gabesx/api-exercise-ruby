@login
Feature: Activities API Testing

  Scenario: Get a list of all activities
    When client sends a GET request to "/api/v1/Activities"
    Then response status should be "200"
    And the response should contain a list of activities

  Scenario: Get details of a specific activity
    Given client sends a GET request to "/api/v1/Activities"
    When client collects "$.[0].id" as "id"
    And client sends a GET request to "/api/v1/Activities/{id}"
    And show me the response
    Then response status should be "200"

  Scenario: Get details of a specific activity
    Given client sends a GET request to "/api/v1/Activities"
    When client collects "$.[0].id" as "id"
    And client sends a DELETE request to "/api/v1/Activities/{id}" with body:
    """
      {
        "id": 0,
        "title": "string",
        "dueDate": "2023-12-26T16:32:21.219Z",
        "completed": true
      }
    """
    And show me the response
    Then response status should be "200"
      And response header should have "content-length" containing "0"
    And response header should have "connection" containing "close"
