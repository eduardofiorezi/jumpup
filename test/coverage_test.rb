%w(minitest/autorun rubygems json).each { |lib| require lib }

class CoverageTest < Minitest::Test
  COVERAGE_FILE = "coverage/.last_run.json"
  def test_if_application_is_fully_covered
    last_run = JSON.parse(File.read(COVERAGE_FILE))
    covered_percent = last_run['result']['covered_percent']

    assert_equal 100, covered_percent, "\nBad Boy! Coverage is #{covered_percent}% < 100%..."
    puts "\nCongratulations! Your coverage is 100%!"
  end
end
