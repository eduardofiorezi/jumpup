require "aruba/cucumber"
require "pry"

Before do
  @aruba_timeout_seconds = 60 * 5
end

After do
  system "rm -rf tmp/aruba"
end
