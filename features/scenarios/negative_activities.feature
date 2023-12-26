@exercise
Feature: Activities API Testing

  @get-detail-activities @negative
  Scenario: Get details of a specific activity
    When client sends a GET request to "/api/v1/Activities/X"
    And show me the response
    Then response status should be "400"
    And the response should have "One or more validation errors occurred."

  @get-detail-activities @negative
  Scenario: Get details of a specific activity
    When client sends a GET request to "/api/v1/Activities/999999"
    And show me the response
    Then response status should be "404"
    And the response should have "Not Found"

  @delete-activities @negative
  Scenario: delete details of a specific activity
    When client sends a DELETE request to "/api/v1/Activities/XX" with body:
    """
      {
        "id": 0,
        "title": "string",
        "dueDate": "2023-12-26T16:32:21.219Z",
        "completed": true
      }
    """
    And show me the response
    Then response status should be "400"
    And the response should have "One or more validation errors occurred."
    And response header should have "transfer-encoding" containing "chunked"

  @post-activities @negative
  Scenario: post details of a specific activity
    When client sends a POST request to "/api/v1/Activities/" with body:
    """
      {
      }
    """
    And show me the response
    Then response status should be "200"
    And the response should have ""completed":false"
    And response header should have "transfer-encoding" containing "chunked"

  @put-activities @negative
  Scenario: Change details of a specific activity
    When client sends a PUT request to "/api/v1/Activities/XXX" with body:
    """
      {
        "id": 0,
        "title": "string",
        "dueDate": "2023-12-26T16:32:21.219Z",
        "completed": true
      }
    """
    And show me the response
    Then response status should be "400"
    And the response should have "One or more validation errors occurred."
    And response header should have "transfer-encoding" containing "chunked"
