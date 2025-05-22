module LLMSpecs
  Price = Data.define(:input, :output) do
    def total = input + output
  end
  
  class Calculator
    def initialize(model)
      @model = model
    end
    
    def call(input: 0, output: 0)
      Price.new(
        input:  calc(input,  @model.input_pricing),
        output: calc(output, @model.output_pricing)
      )
    end
    
    private
    
    def calc(tokens, price)
      tokens * price / 1_000_000
    end
  end
end