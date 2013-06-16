# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'h3m/version'

Gem::Specification.new do |spec|
  spec.name          = "h3m"
  spec.version       = H3m::VERSION
  spec.authors       = ["Maxim Andryunin"]
  spec.email         = ["maxim.andryunin@gmail.com"]
  spec.description   = %q{This gem will can extract info about players, teams, map size and version, win conditions of Heroes 3 map}
  spec.summary       = %q{Extract some info from Heroes of Might and Magic 3 map (.h3m)}
  spec.homepage      = "https://github.com/andryunin/h3m"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rspec", ">= 2.0.0"
  spec.add_development_dependency "rake"
end
