%w(test/unit rubygems json).each { |lib| require lib }

class CoverageTest < Test::Unit::TestCase
  COVERAGE_FILE = "coverage/.last_run.json"
  def test_if_application_is_fully_covered
    last_run = JSON.parse(File.read(COVERAGE_FILE))
    covered_percent = last_run['result']['covered_percent']

    if covered_percent < 100
      puts "Bad Boy! Coverage is #{covered_percent}% < 100%..."
    else
      puts "Congratulations! Your coverage is 100%!"
    end
  end
end
