require 'find'

namespace :jumpup do

  def p80(message)
    puts "-"*80
    puts message if message
    yield if block_given?
  end

  namespace :git do
    desc 'Check if project can be committed to the repository.'
    task :status_check do
      result = `git status`
      if result.include?('Untracked files:') || result.include?('unmerged:') || result.include?('modified:')
        puts result
        exit
      end
    end

    desc 'Update files from repository.'
    task :pull do
      sh "git pull --rebase"
    end

    desc 'Push project.'
    task :push do
      sh "git push"
    end
  end

  task :start => ["git:status_check", "log:clear", "tmp:clear", "git:pull"] do
    ENV['coverage'] = 'on'
  end
  task :finish => ["git:push"]

  desc 'Check code coverage'
  task :coverage_verify do
    sh "ruby #{File.expand_path(File.dirname(__FILE__) + '/../../test/coverage_test.rb')}"
  end

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
    p80 %{
You should define INTEGRATION_TASKS constant. We recommend that you define it on lib/tasks/jumpup.rake file. The file doesn't exists. You should create it in your project.

You'll probably want to add coverage/ to your .gitignore file.

A sample content look like this:

INTEGRATION_TASKS = %w(
  jumpup:start
  jumpup:bundle_install
  db:migrate
  spec
  jumpup:coverage_verify
  jumpup:finish
)

}
    exit
  end

  INTEGRATION_TASKS.each do |subtask|
    p80("Executing #{subtask}...") do
      RAILS_ENV = ENV['RAILS_ENV'] || 'development'
      Rake::Task[subtask].invoke
    end
  end
end
