# frozen_string_literal: true

module LLMSpecs
  class ModelNotFound < StandardError
    def initialize(id)
      super("Couldn't find model with id='#{id}'")
    end
  end
  
  class FetchError < StandardError
    attr_reader :response
    def initialize(response)
      @response = response
      super("HTTP fetch failed (status: #{response.status})")
    end
  end
end
