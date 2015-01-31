# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'raph/version'

Gem::Specification.new do |spec|
  spec.name          = "raph"
  spec.version       = Raph::VERSION
  spec.authors       = ["Vitalii Elenhaupt"]
  spec.email         = ["velenhaupt@gmail.com"]
  spec.summary       = %q{Ruby Argument Parsing for Humans.}
  spec.description   = %q{Simple argument parser.}
  spec.homepage      = "https://github.com/veelenga/raph"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
end
