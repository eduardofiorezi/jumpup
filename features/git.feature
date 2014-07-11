Feature: Git
  @announce
  Scenario: git status check
    Given a file named "Rakefile" with:
      """
      require "jumpup"

      INTEGRATION_TASKS = %w(
        jumpup:git:status_check
      )
      """
    # we need to initialize an empty git repo, otherwise the jumpup .git will be taken
    When I run `git init`
    And I run `rake integrate`
    Then the stdout should contain:
      """
      On branch master
      """
