Dir["#{Gem::Specification.find_by_name('jumpup').full_gem_path}/lib/tasks/*.rake"].each { |ext| load ext } if defined?(Rake)

module Jumpup
end

require "jumpup/ui"
