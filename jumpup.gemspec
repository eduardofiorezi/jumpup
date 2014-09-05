# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'jumpup/version'

Gem::Specification.new do |spec|
  spec.name          = 'jumpup'
  spec.version       = Jumpup::VERSION
  spec.authors       = ['HE:labs']
  spec.email         = ['contato@helabs.com.br']
  spec.description   = 'A synchronous continuous integration gem.'
  spec.summary       = 'Jumpup gem help people that want to do synchronous continuous integration on their ruby projects.'
  spec.homepage      = 'https://github.com/Helabs/jumpup'
  spec.license       = 'MIT'

  spec.files         = `git ls-files`.split($INPUT_RECORD_SEPARATOR)
  spec.executables   = spec.files.grep(/^bin\//) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(/^(test|spec|features)\//)
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.3'
  spec.add_development_dependency 'rspec',   '~> 3.0'
  spec.add_development_dependency 'aruba'
  spec.add_development_dependency 'pry'
  spec.add_dependency 'rake'
  spec.add_dependency 'colorize'
end
