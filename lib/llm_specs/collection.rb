# frozen_string_literal: true
module LLMSpecs
  class Collection < Array
    def find(id)
      super() { it.id == id } or raise ModelNotFound.new(id)
    end

    def where(**criteria)
      select do |model| 
        criteria.all? { |k,v| model.send(k) == v }
      end
    end
    
    %i[select reject filter].each do |method|
      define_method(method) do |&block|
        self.class.new(super(&block))
      end
    end
  end
end
