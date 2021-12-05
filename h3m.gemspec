# frozen_string_literal: true

require_relative "lib/h3m/version"

Gem::Specification.new do |spec|
  spec.name          = "h3m"
  spec.version       = H3m::VERSION
  spec.authors       = ["Maxim Andryunin"]
  spec.email         = ["maxim.andryunin@gmail.com"]

  spec.description   = %q{This gem will can extract info about players, teams, map size and version, win conditions of Heroes 3 map}
  spec.summary       = %q{Extract some info from Heroes of Might and Magic 3 map (.h3m)}
  spec.homepage      = "https://github.com/andryunin/h3m"
  spec.license       = "MIT"
  spec.required_ruby_version = Gem::Requirement.new(">= 2.3.0")

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = spec.homepage

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{\A(?:test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "bindata", "~> 2.4.10"
end
