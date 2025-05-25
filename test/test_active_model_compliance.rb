class TestLLMSpecsActiveModelCompliance < TLDR
  include ActiveModel::Lint::Tests
  
  def setup
    @model = LLMSpecs.models.first
  end
  
  def test_to_key
    assert_respond_to model, :to_key
    #def model.persisted?() false end
    assert model.to_key.nil?, "to_key should return nil when `persisted?` returns false"
  end
  
  def test_to_param
    assert_respond_to model, :to_param
#    def model.to_key() [1] end
#    def model.persisted?() false end
    assert model.to_param.nil?, "to_param should return nil when `persisted?` returns false"
  end
end