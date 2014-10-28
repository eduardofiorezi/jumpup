Feature: Git
  Scenario: running jumpup:git:status_check task with dirty files
    Given a file named "Rakefile" with:
      """
      require "jumpup"

      INTEGRATION_TASKS = %w(
        jumpup:git:status_check
      )
      """
    When I setup a git repo
    And I run `rake integrate`
    Then the stdout should contain:
      """
      On branch master
      """
  Scenario: running jumpup:git:status_check task without dirty files
    Given a file named "Rakefile" with:
      """
      require "jumpup"

      INTEGRATION_TASKS = %w(
        jumpup:git:status_check
      )
      """
    When I setup a git repo
    And I run `git add .`
    And I run `git commit -m "Initial commit" -q`
    And I run `rake integrate`
    Then the stdout should not contain:
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
    # TODO Use "When I setup a git repo" instead
    When I run `git init -q`
    And I run `rake integrate`
    Then the stderr should contain:
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
    # TODO Use "When I setup a git repo" instead
    When I run `git init -q`
    And I run `rake integrate`
    Then the stderr should contain:
      """
      No configured push destination
      """
