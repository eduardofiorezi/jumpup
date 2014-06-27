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
  config.treat_symbols_as_metadata_keys_with_true_values = true
  config.run_all_when_everything_filtered = true
  config.filter_run :focus

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  # Run specs in random order to surface order dependencies. If you find an
  # order dependency and want to debug it, you can fix the order by providing
  # the seed, which is printed after each run.
  #     --seed 1234
  config.order = 'random'
end
