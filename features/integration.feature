Feature: Integration
  Scenario: running jumpup:integration:check task with no one integrating
    Given a file named "Rakefile" with:
      """
      require "jumpup"

      INTEGRATION_TASKS = %w(
        jumpup:integration:check
      )
      """
    When I setup a git repo
    And I run `rake integrate`
    Then the stdout should contain "--> Checking if there's someone integrating..."
    Then the stdout should contain "--> No, go ahead!"
  Scenario: running jumpup:integration:check task when the same user is integrating
    Given a file named "Rakefile" with:
      """
      require "jumpup"

      INTEGRATION_TASKS = %w(
        jumpup:integration:check
      )
      """
    When I setup a git repo
    And I run `git commit --allow-empty -am 'first commit'`
    And I run `git tag -a integrating -m ''`
    And I run `git push -f origin integrating`
    And I run `rake integrate`
    Then the stdout should contain "--> Checking if there's someone integrating..."
    Then the stdout should contain "--> Project is locked to you"
  Scenario: running jumpup:integration:lock task
    Given a file named "Rakefile" with:
      """
      require "jumpup"

      INTEGRATION_TASKS = %w(
        jumpup:integration:lock
      )
      """
    When I setup a git repo
    And I run `git commit --allow-empty -am 'first commit'`
    And I run `rake integrate`
    Then the stdout should contain "--> Locking integration..."
    Then the stdout should contain "--> OK!"
  Scenario: running jumpup:integration:unlock task
    Given a file named "Rakefile" with:
      """
      require "jumpup"

      INTEGRATION_TASKS = %w(
        jumpup:integration:unlock
      )
      """
    When I setup a git repo
    And I run `git commit --allow-empty -am 'first commit'`
    And I run `git tag -a -f integrating -m "Integration started"`
    And I run `rake integrate`
    Then the stdout should contain "--> Unlocking integration..."
    Then the stdout should contain "Deleted tag 'integrating'"
    Then the stdout should contain "--> OK!"
