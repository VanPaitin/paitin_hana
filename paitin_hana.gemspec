# coding: utf-8
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "paitin_hana/version"

Gem::Specification.new do |spec|
  spec.name          = "paitin_hana"
  spec.version       = PaitinHana::VERSION
  spec.authors       = ["Mayowa Pitan"]
  spec.email         = ["mayowa.pitan@andela.com"]

  spec.summary       = "Hana MVC"
  spec.description   = "This is my checkpoint 4. A Ruby MVC framework built with Rack"
  spec.homepage      = "http://github.com/andela-mpitan/paitin_hana"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org by setting 'allowed_push_host', or
  # delete this section to allow pushing this gem to any host.
  if spec.respond_to?(:metadata)
    spec.metadata["allowed_push_host"] = "https://rubygems.org"
  else
    raise "RubyGems 2.0 or newer is required to protect against public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.11"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "pry", "~>0.10.3"
  spec.add_development_dependency "rack-test", "~> 0.6"
  spec.add_development_dependency "sqlite3", "~> 1.3"
  spec.add_development_dependency "capybara"
  spec.add_development_dependency "puma"
  spec.add_development_dependency "faker"
  spec.add_development_dependency "selenium-webdriver", "2.35.0"
  spec.add_development_dependency "factory_girl"
  spec.add_development_dependency "simplecov"

  spec.add_runtime_dependency "rack", "~> 1.6"
  spec.add_runtime_dependency "tilt", "~> 2.0"
end
