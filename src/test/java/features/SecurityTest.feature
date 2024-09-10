@Regression
Feature: API testing for Security Functions

  Background: Setup Test
    Given url BASE_URL
    Given path '/api/token'

  @US_1
  Scenario: Valid token with valid credentials
    Given request
    """
      {
          "username": "supervisor",
          "password": "tek_supervisor"
      }
    """
    When method post
    Then print response
    Then status 200
    Then assert response.username == "supervisor"

  @US_2
  Scenario Outline: Token with invalid credentials
    Given request
      """
      {
        "username": "<username>",
        "password": "<password>"
      }
      """
    When method post
    Then print response
    Then status <statusCode>
    Then assert response.errorMessage == "<error>"

    Examples:
    |username | password  | statusCode |error|
    |supervisors |tek_supervisor| 404   |User supervisors not found|
    |supervisor | tek_supervisors | 400  | Password not matched|


