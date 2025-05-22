# frozen_string_literal: true
require "json"
require "net/http"
require "forwardable"
require_relative "llm_specs/errors"
require_relative "llm_specs/cache"
require_relative "llm_specs/catalog"
require_relative "llm_specs/collection"
require_relative "llm_specs/model"

module LLMSpecs
  API_URI    = "https://api.parsera.org/v1/llm-specs"
  CACHE_PATH = "models.json"
  
  def self.models
    @models ||= Catalog.new(api_uri: API_URI, cache_path: CACHE_PATH).models
  end
end
