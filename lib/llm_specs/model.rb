# frozen_string_literal: true
module LLMSpecs
  class Model < Data.define(:id, :name, :provider, :family, :context_window, :max_output_tokens, :modalities, :capabilities, :pricing)
    def supports?(capability)
      capabilities.include?(capability.to_s)
    end
    
    def supports_input?(mode)
      input_modalities.include?(mode.to_s)
    end
    
    def supports_output?(mode)
      output_modalities.include?(mode.to_s)
    end
    
    %i[function_calling structured_output batch reasoning citations streaming].each do |capability|
      define_method(:"#{capability}?") { supports?(capability) }
    end
    
    %i[text image audio].each do |method|
      define_method(:"#{method}_input?") { supports_input?(method) }
    end
    
     %i[text image audio embeddings].each do |method|
      define_method(:"#{method}_output?") { supports_output?(method) }
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
