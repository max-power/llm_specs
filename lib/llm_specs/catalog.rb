# frozen_string_literal: true

module LLMSpecs
  class Catalog
    extend Forwardable
#    def_delegators :all, :each, :find, :where, :reject, :select, :filter
    
    def initialize(api_uri:, cache_path:)
      @uri   = URI(api_uri)
      @cache = Cache.new(cache_path)
    end
    
    def models
      Collection.new fetch.map(&Model)
    end
    
    private
    
    def fetch
      @cache.fetch do
        response = Net::HTTP.get_response(@uri)
        raise FetchError.new(response) unless response.is_a? Net::HTTPSuccess
        JSON.parse(response.body, symbolize_names: true)
      end
    end
  end
end
