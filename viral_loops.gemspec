# frozen_string_literal: true

require_relative 'lib/viral_loops/version'

Gem::Specification.new do |spec|
  spec.name          = 'viral_loops'
  spec.version       = ViralLoops::VERSION
  spec.summary       = 'Ruby client for the Viral Loops API'
  spec.authors       = ['Cairo Noleto']
  spec.email         = ['hey@caironoleto.dev']
  spec.files         = Dir['lib/**/*', 'README.md']
  spec.require_paths = ['lib']
  spec.license       = 'MIT'
  spec.homepage      = 'https://github.com/caironoleto/viral-loops'
  spec.required_ruby_version = '>= 3.0'

  spec.add_dependency 'faraday', '~> 2.14'
  spec.add_dependency 'rack', '~> 3.2'
  spec.metadata['rubygems_mfa_required'] = 'true'
end
