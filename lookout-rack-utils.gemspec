# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'lookout/rack/utils/version'

Gem::Specification.new do |spec|
  spec.name          = "lookout-rack-utils"
  spec.version       = Lookout::Rack::Utils::VERSION
  spec.authors       = ["Ian Smith"]
  spec.email         = ["ian.smith@lookout.com"]
  spec.description   = %q{A collection of rack utils.}
  spec.summary       = %q{}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "rack-test"
  spec.add_development_dependency "sinatra"
  spec.add_development_dependency "timecop"

  spec.add_runtime_dependency "i18n"

  spec.add_dependency "rack"
  spec.add_dependency "rack-graphite"
  spec.add_dependency "rack-requestash"
  spec.add_dependency "configatron", '~> 2.13'
  spec.add_dependency "log4r"
  spec.add_dependency "lookout-statsd", '>= 0.7.0'
end
