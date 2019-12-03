# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'ruby_instagram/version'

Gem::Specification.new do |spec|
  spec.name          = 'ruby_instagram'
  spec.version       = RubyInstagram::VERSION
  spec.authors       = ['Kickser', 'Federico Farina', 'Alejo Zárate', 'Nicolás Vázquez']
  spec.email         = ['support@goprebo.com', 'federico@goprebo.com', 'ale@goprebo.com', 'nico@goprebo.com']

  spec.summary       = 'Ruby wrapper for the Instagram API'
  spec.homepage      = 'https://github.com/goprebo/ruby_instagram'
  spec.license       = 'MIT'

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = spec.homepage

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 2.0'
  spec.add_development_dependency 'pry'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'sinatra', '~> 2.0'

  spec.add_runtime_dependency('faraday', '~> 0.17.0')
  spec.add_runtime_dependency('faraday_middleware', '~> 0.13')
  spec.add_runtime_dependency('hashie', '~> 4.0')
end
