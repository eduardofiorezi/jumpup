require "aruba/cucumber"
require "pry"

root = Pathname.new(__FILE__).parent.parent.parent

# ENV["PATH"] = "#{root}/features/support/bin#{File::PATH_SEPARATOR}#{ENV["PATH"]}"

Before do
  @aruba_timeout_seconds = 60 * 5
end

After do
  system "rm -rf tmp/aruba"
end
