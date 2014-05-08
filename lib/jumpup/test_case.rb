module Jumpup
  if defined?(MiniTest::Test)
    TestCase = ::Minitest::Test
  else
    TestCase = ::MiniTest::Unit::TestCase
  end
end
