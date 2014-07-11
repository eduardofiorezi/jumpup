@announce
Feature: Git
  Scenario: jumpup:git:status_check task
    Given a file named "Rakefile" with:
      """
      require "jumpup"

      INTEGRATION_TASKS = %w(
        jumpup:git:status_check
      )
      """
    # we need to initialize an empty git repo, otherwise the jumpup .git will be taken
    When I run `git init -q`
    And I run `rake integrate`
    Then the stdout should contain:
      """
      On branch master
      """

  Scenario: jumpup:git:pull task
    Given a file named "Rakefile" with:
      """
      require "jumpup"

      INTEGRATION_TASKS = %w(
        jumpup:git:pull
      )
      """
    # we need to initialize an empty git repo, otherwise the jumpup .git will be taken
    When I run `git init -q`
    And I run `rake integrate`
    Then the stdout should contain:
      """
      No remote repository specified
      """

  Scenario: jumpup:git:push task
    Given a file named "Rakefile" with:
      """
      require "jumpup"

      INTEGRATION_TASKS = %w(
        jumpup:git:push
      )
      """
    # we need to initialize an empty git repo, otherwise the jumpup .git will be taken
    When I run `git init -q`
    And I run `rake integrate`
    Then the stdout should contain:
      """
      No configured push destination
      """
