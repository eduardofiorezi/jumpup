@announce
Feature: Lifecycle tasks
  Scenario: running jumpup:start task without dirty files
    Given a file named "Rakefile" with:
      """
      require "jumpup"

      # dummy rails rake tasks
      namespace :log do
        task :clear do
          puts "Clearing log files"
        end
      end

      namespace :tmp do
        task :clear do
          puts "Clearing tmp files"
        end
      end

      INTEGRATION_TASKS = %w(
        jumpup:start
      )
      """
    # we need to initialize an empty git repo, otherwise the jumpup .git will be taken
    When I run `git init -q`
    And I run `git add .`
    And I run `git commit -m "Initial commit" -q`
    And I run `rake integrate`
    Then the stdout should contain "Clearing log files"
    Then the stdout should contain "Clearing tmp files"
    Then the stdout should contain "No remote repository specified"

  Scenario: running jumpup:start task with dirty files should abort after jumpup:git:status_check task
    Given a file named "Rakefile" with:
      """
      require "jumpup"

      # dummy rails rake tasks
      namespace :log do
        task :clear do
          puts "Clearing log files"
        end
      end

      namespace :tmp do
        task :clear do
          puts "Clearing tmp files"
        end
      end

      INTEGRATION_TASKS = %w(
        jumpup:start
      )
      """
    # we need to initialize an empty git repo, otherwise the jumpup .git will be taken
    When I run `git init -q`
    And I run `rake integrate`
    Then the stdout should contain "On branch master"
    Then the stdout should not contain "Clearing log files"
    Then the stdout should not contain "Clearing tmp files"
    Then the stdout should not contain "No remote repository specified"

