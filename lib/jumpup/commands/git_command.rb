module Jumpup::GitCommand
  class << self

    def status_check
      result = `git status`
      if result.include?('Untracked files:') || result.include?('unmerged:') || result.include?('modified:')
        Jumpup::UI.say result
        exit
      end
    end

    def pull
      Jumpup::UI.say `git pull --rebase 2>&1`
    end

    def push
      Jumpup::UI.say `git push 2>&1`
    end

  end
end
