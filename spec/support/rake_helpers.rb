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
  load File.expand_path("../../fixtures/integration.rake", __FILE__)

  [:one, :two, :three].each do |task|
    Rake::Task.define_task(task)
  end
end

