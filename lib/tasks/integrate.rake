namespace :jumpup do

  namespace :git do
    desc 'Check if project can be committed to the repository.'
    task :status_check do
      Jumpup::GitCommand.status_check
    end

    desc 'Update files from repository.'
    task :pull do
      Jumpup::GitCommand.pull
    end

    desc 'Push project.'
    task :push do
      Jumpup::GitCommand.push
    end
  end

  task :start => ["git:status_check", "log:clear", "tmp:clear", "git:pull"] do
    ENV['coverage'] = 'on'
  end
  task :finish => ["git:push"]

  desc 'Run bundle install'
  task :bundle_install do
    Jumpup::BundlerCommand.install_with_clean_env
  end

end

desc 'Integrate new code to repository'
task :integrate do
  Jumpup.perform_integration
end
