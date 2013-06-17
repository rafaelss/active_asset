# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'active_asset/version'

Gem::Specification.new do |spec|
  spec.name          = "active_asset"
  spec.version       = ActiveAsset::VERSION
  spec.authors       = ["Rafael Souza"]
  spec.email         = ["me@rafaelss.com"]
  spec.description   = %q{An application to process files and other files}
  spec.summary       = %q{ActiveAsset is a Rack application that can process any kind of file on-the-fly}
  spec.homepage      = "http://github.com/rafaelss/active_asset"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec", "2.14.0.rc1"
  spec.add_development_dependency "mongo", "~> 1.9.0"
end
