# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'restricted_access/version'

Gem::Specification.new do |spec|
  spec.name          = "restricted_access"
  spec.version       = RestrictedAccess::VERSION
  spec.authors       = ["4nt1"]
  spec.email         = ["antoinemary@hotmail.fr"]
  spec.summary       = %q{An access rights management tool}
  spec.description   = %q{An access rights management tool. Define routes and part of views that can be accessed by resources.}
  spec.homepage      = "https://github.com/4nt1/restricted_access"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.5"
end
