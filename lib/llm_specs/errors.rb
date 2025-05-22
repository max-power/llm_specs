# frozen_string_literal: true
module LLMSpecs
  class ModelNotFound < StandardError
    def initialize(id)
      super("Couldn't find model with id='#{id}'")
    end
  end
end
