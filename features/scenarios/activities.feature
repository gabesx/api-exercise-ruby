@exercise
Feature: Activities API Testing

  @get-activities-list @positive
  Scenario: Get a list of all activities
    When client sends a GET request to "/api/v1/Activities"
    Then response status should be "200"
    And the response should contain a list of activities

  @get-detail-activities  @positive
  Scenario: Get details of a specific activity
    Given client sends a GET request to "/api/v1/Activities"
    When client collects "$.[0].id" as "id"
    And client sends a GET request to "/api/v1/Activities/{id}"
    And show me the response
    Then response status should be "200"

  @delete-activities @positive
  Scenario: delete details of a specific activity
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

  @post-activities @positive
  Scenario: post details of a specific activity
    Given client sends a GET request to "/api/v1/Activities"
    When client collects "$.[0].id" as "id"
    And client sends a POST request to "/api/v1/Activities/" with body:
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

  @put-activities @positive
  Scenario: Change details of a specific activity
    Given client sends a GET request to "/api/v1/Activities"
    When client collects "$.[0].id" as "id"
    And client sends a PUT request to "/api/v1/Activities/{id}" with body:
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
