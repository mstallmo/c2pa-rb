# frozen_string_literal: true

require_relative "lib/c2pa_rb/version"

Gem::Specification.new do |spec|
  spec.name = "c2pa_rb"
  spec.version = C2paRb::VERSION
  spec.authors = ["MasonStallmo"]
  spec.email = ["masonstallmo@hey.com"]

  spec.summary = "Content Authenticity Tools"
  spec.description = "Implementation of content authenticity tools for media"
  spec.homepage = "https://github.com/mstallmo/c2pa-rb"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 3.0.0"

  spec.metadata["rubygems_mfa_required"] = "true"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir["lib/**/*.rb", "ext/**/*.{rs,toml,lock,rb}"]
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]
  spec.extensions = ["ext/c2pa_rb/extconf.rb"]

  # Uncomment to register a new dependency of your gem
  # spec.add_dependency "example-gem", "~> 1.0"
  spec.add_dependency "rb_sys", "~> 0.9.39"

  # For more information and examples about making a new gem, check out our
  # guide at: https://bundler.io/guides/creating_gem.html
end
