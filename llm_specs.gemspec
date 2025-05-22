# frozen_string_literal: true

require_relative "lib/llm_specs/version"

Gem::Specification.new do |spec|
  spec.name        = "llm_specs"
  spec.version     = LLMSpecs::VERSION
  spec.authors     = ["Max Power"]
  spec.email       = ["kevin.melchert@gmail.com"]

  spec.summary     = "Ruby interface for fetching LLM specifications from the Parsera API"
  spec.description = "LLMSpecs is a lightweight Ruby interface for fetching and caching large language model (LLM) specifications from the Parsera API. It provides a simple, efficient way to access model metadata with built-in caching and query support."
  spec.homepage    = "https://github.com/max-power/llm_specs"
  spec.license     = "MIT"
  spec.metadata    = { "source_code_uri" => spec.homepage }
  

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  gemspec = File.basename(__FILE__)
  spec.files = IO.popen(%w[git ls-files -z], chdir: __dir__, err: IO::NULL) do |ls|
    ls.readlines("\x0", chomp: true).reject do |f|
      (f == gemspec) ||
        f.start_with?(*%w[bin/ test/ spec/ features/ .git appveyor Gemfile])
    end
  end

  spec.required_ruby_version = ">= 3.2.0"
  spec.require_paths = ["lib"]
  spec.add_development_dependency "tldr", "~> 1.0"
end
