# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'henry/version'

Gem::Specification.new do |spec|
  spec.name          = "henry"
  spec.version       = Henry::VERSION
  spec.authors       = ["pezholio"]
  spec.email         = ["pezholio@gmail.com"]

  spec.summary       = "Continuously deploy your Rubygems via Travis"
  spec.homepage      = "https://github.com/theodi/henry"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "git", "~> 1.3"
  spec.add_dependency "github_api", "~> 0.13"
  spec.add_dependency "github_changelog_generator", "1.9.0"
  spec.add_dependency "thor", "~> 0.19.1"
  spec.add_dependency "travis", "~> 1.8.2"

  spec.add_development_dependency "bundler", "~> 1.11"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "pry", "~> 0.10"
  spec.add_development_dependency "dotenv", "~> 2.0"
  spec.add_development_dependency "vcr", "~> 3.0"
  spec.add_development_dependency "coveralls", "~> 0.8"
  spec.add_development_dependency "webmock", "~> 1.24"
end
