# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'listly/version'

Gem::Specification.new do |spec|
  spec.name          = "listly"
  spec.version       = Listly::VERSION
  spec.authors       = ["Steve Forkin"]
  spec.email         = ["steve.forkin@gmail.com"]

  spec.summary       = %q{List objects from hash data stored in i18n}
  spec.description   = %q{Gem to create simple list objects from hash data stored in i18n}
  spec.homepage      = "http://github.com/netflakes/listly"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  #if spec.respond_to?(:metadata)
  #  spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com' to prevent pushes to rubygems.org, or delete to allow pushes to any server."
  #end
  #
  # Development dependencies
  #
  spec.add_development_dependency "bundler", "~> 1.9"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "coveralls"
  #
  # - gem related ones
  spec.add_development_dependency 'rack'
  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'rspec-given'
  spec.add_development_dependency 'rspec-collection_matchers'
  spec.add_development_dependency 'rspec-rails'
  #
  # Runtime dependencies
  #
  spec.add_runtime_dependency 'rails', '>= 4.1.1'
  #
end
