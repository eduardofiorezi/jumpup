# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'jumpup/version'

Gem::Specification.new do |spec|
  spec.name          = "jumpup"
  spec.version       = Jumpup::VERSION
  spec.authors       = ["HE:labs"]
  spec.email         = ["contato@helabs.com.br"]
  spec.description   = %q{A synchronous continuous integration gem.}
  spec.summary       = %q{Jumpup gem help people that want to do synchronous continuous integration on their ruby projects.}
  spec.homepage      = "https://github.com/Helabs/jumpup"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency 'rubocop',              '0.17.0'
  spec.add_dependency 'brakeman',             '2.3.1'
  spec.add_dependency 'metric_fu',            '4.7.2'
  spec.add_dependency 'sandi_meter',          '1.0.5'
  spec.add_dependency 'mago',                 '0.1.0'

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake",    "~> 0"
end
