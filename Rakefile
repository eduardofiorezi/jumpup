require "bundler/gem_tasks"
require "cucumber/rake/task"
require "rspec/core/rake_task"

RSpec::Core::RakeTask.new do |t|
  t.pattern = "spec/**/*_spec.rb"
end

Cucumber::Rake::Task.new
task default: [:spec, :cucumber]
