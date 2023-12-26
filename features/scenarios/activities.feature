@login
Feature: Activities API Testing

  Scenario: Get a list of all activities
    When client send a GET request to "/api/v1/Activities"
    Then response status should be "200"
    And the response should contain a list of activities

  Scenario: Get a list of all activities
    Given client send a GET request to "/api/v1/Activities"
    When client collects "$.[0].id" as "id"
    When client send a GET request to "/api/v1/Activities/{id}"
    And show me the response
    Then response status should be "200"
