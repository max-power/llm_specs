# frozen_string_literal: true

class TestLLMSpecs < TLDR
  def test_that_it_has_a_version_number
    refute_nil ::LLMSpecs::VERSION
  end

  def test_load_models
    assert LLMSpecs.models
    assert_kind_of LLMSpecs::Collection, LLMSpecs.models
  end
  
  def test_where
    result = LLMSpecs.models.where(provider: 'openai')
    assert_kind_of LLMSpecs::Collection, result
    assert_equal 57, result.count
  end
  
  def test_find
    model = LLMSpecs.models.find('claude-3-7-sonnet-20250219')
    assert_instance_of LLMSpecs::Model, model
  end
  
  def test_find_with_invalid_id
    assert_raises(LLMSpecs::ModelNotFound) {
      LLMSpecs.models.find('not-in-catalog')
    }
  end
  
  def test_reject
    result = LLMSpecs.models.reject(&:batch?)
    assert_instance_of LLMSpecs::Collection, result
  end
  
  def test_model_methods
    model = LLMSpecs.models.find('claude-3-7-sonnet-20250219')
    assert_equal 'claude-3-7-sonnet-20250219', model.id
    assert_equal 'Claude 3.7 Sonnet', model.name
    assert_equal 'claude-3-7-sonnet', model.family
  end
  
  def test_model_output_inquiry
    model = LLMSpecs.models.find('claude-3-7-sonnet-20250219')
    assert model.text_output?
    refute model.image_output?
    refute model.audio_output?
    refute model.audio_output?
  end
  
  def test_model_input_inquiry
    model = LLMSpecs.models.find('claude-3-7-sonnet-20250219')
    assert model.text_input?
    assert model.image_input?
    refute model.audio_input?
  end
  
  def test_capability_inquiry
    model = LLMSpecs.models.find('claude-3-7-sonnet-20250219')
    assert model.function_calling?
    assert model.batch?
  end
end
