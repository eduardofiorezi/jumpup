Feature: Coverage
  Scenario: run jumpup:bundle_install
    Given an empty file named "Gemfile"
    Given a file named "Rakefile" with:
      """
      require "jumpup"

      INTEGRATION_TASKS = %w(
        jumpup:bundle_install
      )
      """
    When I run `rake integrate`
    Then the following files should exist:
      | Gemfile.lock |
