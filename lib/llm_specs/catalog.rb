# frozen_string_literal: true
module LLMSpecs
  class Catalog    
    def initialize(api_uri:, cache_path:)
      @uri   = URI(api_uri)
      @cache = Cache.new(cache_path)
    end
    
    def models
      Collection.new fetch.map(&Model)
    end
    
    private
    
    def fetch
      @cache.fetch {
        Net::HTTP.get_response(@uri).tap(&:value).body # .value raises Net::HTTPError if not 2xx
      }.then {
        JSON.parse it, symbolize_names: true
      }
    end
  end
end


