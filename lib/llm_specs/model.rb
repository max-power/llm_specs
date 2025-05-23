# frozen_string_literal: true
module LLMSpecs
  class Model < Data.define(:id, :name, :provider, :family, :context_window, :max_output_tokens, :modalities, :capabilities, :pricing)
    def supports?(*caps)
      caps.all? { capabilities.include? it.to_s }
    end
    
    def supports_input?(*modes)
      modes.all? { input_modalities.include? it.to_s }
    end
    
    def supports_output?(*modes)
      modes.all? { output_modalities.include? it.to_s }
    end
    
    %i[function_calling structured_output batch reasoning citations streaming].each do |capability|
      define_method(:"#{capability}?") { supports? capability }
    end
    
    %i[text image audio].each do |mode|
      define_method(:"#{mode}_input?") { supports_input? mode }
    end
    
     %i[text image audio embeddings].each do |mode|
      define_method(:"#{mode}_output?") { supports_output? mode }
    end
    
    def input_modalities
      modalities[:input]
    end
    
    def output_modalities
      modalities[:output]
    end
      
    def input_pricing(type=:text_tokens, price_type=:standard)
      pricing.dig(type, price_type, :input_per_million)
    end
    
    def output_pricing(type=:text_tokens, price_type=:standard)
      pricing.dig(type, price_type, :output_per_million)
    end
      
    def self.to_proc
      ->(hash) { new(**hash) }
    end
  end
end
