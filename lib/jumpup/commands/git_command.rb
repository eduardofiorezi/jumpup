module Jumpup::GitCommand
  extend Rake::DSL

  class << self

    def status_check
      result = `git status`
      if result.include?('Untracked files:') || result.include?('unmerged:') || result.include?('modified:')
        Jumpup::UI.say result
        exit
      end
    end

    def pull
      sh "git pull --rebase"
    end

    def push
      sh "git push"
    end

    def check_integration
      Jumpup::UI.say "  --> Checking if there's someone integrating...".yellow
      Jumpup::UI.say `git tag -d integrating`
      Jumpup::UI.say `git fetch --tags`

      tags = `git tag`.strip.split("\n")
      if tags.include?('integrating')
        tag_info = `git show integrating`
        integrating_by = /Tagger: (.*) <.*>/.match(tag_info)[1]
        if integrating_by == user
          Jumpup::UI.say "  --> Project is locked to you ('#{integrating_by}'), go ahead!".green
        else
          Jumpup::UI.say "  --> Project is already being integrated by '#{integrating_by}', halting!".red
          exit
        end
      else
        Jumpup::UI.say "  --> No, go ahead!".green
      end
    end

    def lock_integration
      Jumpup::UI.say "  --> Locking integration...".yellow
      Jumpup::UI.say `git tag -a -f integrating -m "Integration started at #{Time.now.strftime("%d/%m/%Y %T %Z")}"`
      Jumpup::UI.say `git push -f origin integrating`
      Jumpup::UI.say "  --> OK!".green
    end

    def unlock_integration
      Jumpup::UI.say "  --> Unlocking integration...".yellow
      Jumpup::UI.say `git tag -d integrating`
      Jumpup::UI.say `git push origin :refs/tags/integrating`
      Jumpup::UI.say "  --> OK!".green
    end

    private

    def user
      @user = `git config --get user.name`.strip
    end

  end
end
