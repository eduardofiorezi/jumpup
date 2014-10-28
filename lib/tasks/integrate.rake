namespace :jumpup do

  namespace :git do
    desc 'Check if project can be committed to the repository.'
    task :status_check do
      Jumpup::GitCommand.status_check
    end

    desc 'Update files from repository.'
    task :pull do
<<<<<<< HEAD
      sh "git pull"
=======
      Jumpup::GitCommand.pull
>>>>>>> helabs/master
    end

    desc 'Push project.'
    task :push do
      Jumpup::GitCommand.push
    end
  end

  namespace :integration do
    desc 'Checks if there\'s someone integrating.'
    task :check do
      Jumpup::GitCommand.check_integration
    end

    desc 'Lock integration.'
    task :lock do
      Jumpup::GitCommand.lock_integration
    end

    desc 'Unlock integration.'
    task :unlock do
      Jumpup::GitCommand.unlock_integration
    end
  end

  task start: ['integration:check', 'integration:lock', 'git:status_check', 'log:clear', 'tmp:clear', 'git:pull'] do
    ENV['coverage'] = 'on'
  end
  task finish: ['git:push', 'integration:unlock']

  desc 'Run bundle install'
  task :bundle_install do
    Jumpup::BundlerCommand.install_with_clean_env
  end

end

desc 'Integrate new code to repository'
task :integrate do
  Jumpup.perform_integration
end
