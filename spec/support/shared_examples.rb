RSpec.shared_examples "capture stdout" do
  before do
    require "stringio"
    $stdout = StringIO.new
    @output = $stdout
  end

  after do
    $stdout = STDOUT
  end
end
