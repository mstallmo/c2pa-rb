# frozen_string_literal: true

require "bundler/gem_tasks"
require "rspec/core/rake_task"

RSpec::Core::RakeTask.new(:spec)

require "rubocop/rake_task"

RuboCop::RakeTask.new

require "rake/extensiontask"

SOURCE_PATTERN = "*.{rs,toml,lock,rb}"

Rake::ExtensionTask.new("c2pa_rb") do |ext|
  ext.lib_dir = "lib/c2pa_rb"
  ext.source_pattern = SOURCE_PATTERN
  ext.cross_compile = true
  ext.cross_platform = %w[x86-mingw32 x64-mingw-ucrt x64-mingw32 x86-linux x86_64-linux x86_64-darwin arm64-darwin
                          aarch64-linux]
  ext.config_script = ENV["ALTERNATE_CONFIG_SCRIPT"] || "extconf.rb"
end

desc "Compiles the Rust extension"
task :build do
  require "bundler"

  spec = Bundler.load_gemspec("c2pa_rb.gemspec")

  FileUtils.rm_rf("pkg/c2pa_rb")

  spec.files.each do |file|
    FileUtils.mkdir_p("pkg/c2pa_rb/#{File.dirname(file)}")
    FileUtils.cp(file, "pkg/c2pa_rb/#{file}")
  end

  FileUtils.cp("c2pa_rb.gemspec", "pkg/c2pa_rb")

  full_path = File.expand_path("./../../../crates/rb-sys", __dir__)
  cargo_toml_path = "pkg/c2pa_rb/ext/c2pa_rb/Cargo.toml"
  new_contents = File.read(cargo_toml_path).gsub("./../../../../crates/rb-sys", full_path)
  FileUtils.rm(cargo_toml_path)
  File.write(cargo_toml_path, new_contents)

  Dir.chdir("pkg/c2pa_rb") do
    sh "gem build c2pa_rb.gemspec --output=../c2pa_rb.gem"
  end
end

task default: %i[compile spec rubocop]
