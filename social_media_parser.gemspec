# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'social_media_parser/version'

Gem::Specification.new do |spec|
  spec.name          = "social_media_parser"
  spec.version       = SocialMediaParser::VERSION
  spec.authors       = ["Markus Nordin", "Jonas Brusman", "Alexander Rothe"]
  spec.email         = ["dev@mynewsdesk.com"]
  spec.summary       = %q{Parse social media profile username and provider}
  spec.homepage      = "http://devcorner.mynewsdesk.com"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "public_suffix", "~> 1.4.5"

  spec.add_development_dependency "rspec", "~> 3.0.0"
end
