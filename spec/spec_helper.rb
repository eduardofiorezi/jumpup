require "bundler/setup"
Bundler.setup

require "pry"
require "rake"
require "jumpup"

def rake_integrate
  begin
    [:one, :two, :three].each do |task|
      Rake::Task[task].reenable
    end
  rescue
    # TODO improve this
    # Ignore the tasks if not defined
  end
  Rake::Task["integrate"].reenable
  Rake::Task["integrate"].invoke
end

def load_tasks
  load File.expand_path("../fixtures/integration.rake", __FILE__)

  [:one, :two, :three].each do |task|
    Rake::Task.define_task(task)
  end
end

RSpec.configure do |config|
  config.disable_monkey_patching!
  config.order = :random
  Kernel.srand config.seed
  config.filter_run focus: true
  config.run_all_when_everything_filtered = true
  config.expect_with :rspec do |expectations|
    expectations.syntax = :expect
  end
  config.mock_with :rspec do |mocks|
    mocks.syntax = :expect
    mocks.verify_partial_doubles = true
  end
  if config.files_to_run.one?
    config.default_formatter = 'doc'
  end
end
