require 'find'

namespace :jumpup do

  namespace :git do
    desc 'Check if project can be committed to the repository.'
    task :status_check do
      result = `git status`
      if result.include?('Untracked files:') || result.include?('unmerged:') || result.include?('modified:')
        Jumpup::UI.say result
        exit
      end
    end

    desc 'Update files from repository.'
    task :pull do
      Jumpup::UI.say `git pull --rebase 2>&1`
    end

    desc 'Push project.'
    task :push do
      Jumpup::UI.say `git push 2>&1`
    end
  end

  task :start => ["git:status_check", "log:clear", "tmp:clear", "git:pull"] do
    ENV['coverage'] = 'on'
  end
  task :finish => ["git:push"]

  desc 'Run bundle install'
  task :bundle_install do
    Bundler.with_clean_env do
      sh 'bundle install --quiet'
    end
  end

end

desc 'Integrate new code to repository'
task :integrate do
  if !defined?(INTEGRATION_TASKS)
    Jumpup::UI.header %{
You should define INTEGRATION_TASKS constant. We recommend that you define it on lib/tasks/jumpup.rake file. The file doesn't exists. You should create it in your project.

You'll probably want to add coverage/ to your .gitignore file.

A sample content look like this:

INTEGRATION_TASKS = %w(
  jumpup:start
  jumpup:bundle_install
  db:migrate
  spec
  jumpup:finish
)

}
    exit
  end

  INTEGRATION_TASKS.each do |subtask|
    Jumpup::UI.header("Executing #{subtask}...") do
      Rake::Task[subtask].invoke
    end
  end
end
