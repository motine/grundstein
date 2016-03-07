# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'grundstein/version'

Gem::Specification.new do |spec|
  spec.name          = 'grundstein'
  spec.version       = Grundstein::VERSION
  spec.authors       = ['Tom Rothe']
  spec.email         = ['info@tomrothe.de']
  spec.summary       = 'Automates adding common files to your project.'
  spec.description   = 'Grundstein automates adding common files by we adding (smart) templates. E.g. add a Vagrantfile, a .gitignore, or a sinatra app.'
  spec.homepage      = ''
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency 'thor', '~> 0.19.1'
  spec.add_runtime_dependency 'highline', '~> 1.7'
  spec.add_runtime_dependency 'mustache', '~> 1.0'
  spec.add_development_dependency 'bundler', '~> 1.7'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency "rubocop"
  spec.add_development_dependency 'sdoc'
end
