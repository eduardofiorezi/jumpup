namespace :quality do

  desc 'Run all tasks to check quality'
  task check: ['check:rubocop', 'check:brakeman', 'check:sandi_meter',
               'check:mago', 'check:metric_fu']

  namespace :check do

    desc 'Run rubocop'
    task rubocop: :environment do
      flag('rubocop')
      system('rubocop')
    end

    desc 'Run brakeman'
    task brakeman: :environment do
      flag('brakeman')
      system('brakeman')
    end

    desc 'Run metric_fu'
    task metric_fu: :environment do
      flag('metric_fu')
      system('metric_fu')
    end

    desc 'Run sandi_meter'
    task sandi_meter: :environment do
      flag('sandi_meter')
      system('sandi_meter -d')
    end

    desc 'Run mago'
    task mago: :environment do
      flag('mago')
      system('mago')
    end
  end

  def flag(text)
    puts '=' * 80
    puts text
    puts '=' * 80
  end
end
