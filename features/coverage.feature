Feature: Coverage
  Scenario: run jumpup:coverage_verify task in a 100% covered project
    Given a file named "Rakefile" with:
      """
      require "jumpup"

      INTEGRATION_TASKS = %w(
        jumpup:coverage_verify
      )
      """
    And a file named "coverage/.last_run.json" with:
      """
      {
        "result": {
          "covered_percent": 100
        }
      }
      """
    When I run `rake integrate`
    Then the stdout should contain:
      """
      Congratulations! Your coverage is 100%!
      """
  Scenario: run jumpup:coverage_verify task in a not 100% covered project
    Given a file named "Rakefile" with:
      """
      require "jumpup"

      INTEGRATION_TASKS = %w(
        jumpup:coverage_verify
      )
      """
    And a file named "coverage/.last_run.json" with:
      """
      {
        "result": {
          "covered_percent": 80
        }
      }
      """
    When I run `rake integrate`
    Then the stdout should contain:
      """
      Bad Boy! Coverage is 80% < 100%
      """
