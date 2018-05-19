# frozen_string_literal: true
# coding: utf-8

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'metrica_api/version'

Gem::Specification.new do |spec|
  spec.name          = 'metrica_api'
  spec.version       = MetricaApi::VERSION
  spec.authors       = ['OneRetarget.com']
  spec.email         = ['help@oneretarget.com']
  spec.summary       = 'Ruby client for Yandex Metrica API'
  spec.description   = <<~DESC
    Ruby client for Yandex Metrica API.
    Make requests to counter and reporting sections of API.
    OneRetarget.com - advertising automation service
  DESC
  spec.homepage      = 'https://github.com/resivalex/metrica_api'
  spec.license       = 'MIT'

  spec.files         = Dir['**/*']
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^spec/})
  spec.require_paths = ['lib']

  spec.add_runtime_dependency 'json', '~> 2.0', '>= 2.0.0'
  spec.add_runtime_dependency 'rest-client', '~> 2.0', '>= 2.0.0'

  spec.add_development_dependency 'bundler', '~> 1.6'
  spec.add_development_dependency 'rake', '~> 12.3.0', '>= 12.3.0'
  spec.add_development_dependency 'rspec', '~> 3.7.0', '>= 3.7.0'
  spec.add_development_dependency 'rubocop', '~> 0.54.0'
  spec.add_development_dependency 'webmock', '~> 2.3.2', '>= 2.3.2'
end
