Given(/^I setup a git repo$/) do
  steps %(
    When I run `git init -q`
    And a directory named "/tmp/jumpup-git-repo"
    And I run `git init --bare -q /tmp/jumpup-git-repo`
    And I run `git remote add origin /tmp/jumpup-git-repo`
  )
end
