# frozen_string_literal: true
require "json"
require "net/http"
require_relative "llm_specs/version"
require_relative "llm_specs/errors"
require_relative "llm_specs/cache"
require_relative "llm_specs/catalog"
require_relative "llm_specs/collection"
require_relative "llm_specs/model"

module LLMSpecs
  API_URI = "https://api.parsera.org/v1/llm-specs"
  
  class << self
    attr_writer :cache_path

    def cache_path
      @cache_path || "llm-specs.json"
    end

    def models
      @models ||= Catalog.new(api_uri: API_URI, cache_path: cache_path).models
    end
    
    def providers
      models.map(&:provider).uniq
    end
    
    %i[anthropic deepseek gemini openai].each do |prov|
      define_method(prov) { models.where(provider: prov.to_s) }
    end
  end
end
