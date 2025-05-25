# frozen_string_literal: true

class TestLLMSpecs < TLDR
  def test_that_it_has_a_version_number
    refute_nil ::LLMSpecs::VERSION
  end

  def test_load_models
    assert LLMSpecs.models
    assert_kind_of LLMSpecs::Collection, LLMSpecs.models
  end

  def test_provider_models
    assert_kind_of LLMSpecs::Collection, LLMSpecs.openai
    assert_kind_of LLMSpecs::Collection, LLMSpecs.anthropic
    assert_kind_of LLMSpecs::Collection, LLMSpecs.gemini
    assert_kind_of LLMSpecs::Collection, LLMSpecs.deepseek
  end
  

  
  def test_where
    result = LLMSpecs.models.where(provider: 'openai')
    assert_kind_of LLMSpecs::Collection, result
    assert result.count > 0
  end
  
  def test_find
    model = LLMSpecs.models.find('o4-mini')
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
    model = LLMSpecs.models.find('gemini-2.5-flash-preview-native-audio-dialog')
    assert_equal 'gemini-2.5-flash-preview-native-audio-dialog', model.id
    assert_equal 'Gemini 2.5 Flash Native Audio', model.name
    assert_equal 'gemini-2.5-flash-preview-native-audio-dialog', model.family
  end
  
  def test_model_output_inquiry
    model = LLMSpecs.models.find('o4-mini')
    assert model.text_output?
    refute model.image_output?
    refute model.audio_output?
    refute model.audio_output?
  end
  
  def test_model_input_inquiry
    model = LLMSpecs.models.find('o4-mini')
    assert model.text_input?
    assert model.image_input?
    refute model.audio_input?
  end
  
  def test_capability_inquiry
    model = LLMSpecs.models.find('o4-mini')
    assert model.function_calling?
    assert model.batch?
  end
  
  def test_default_cache_path
    assert_equal "llm-specs.json", LLMSpecs.cache_path
  end
  
  def test_custom_cache_path
    path = "/files/tempory/cache.json"
    LLMSpecs.cache_path = path
    assert_equal path, LLMSpecs.cache_path
  ensure
    LLMSpecs.cache_path = nil
  end
  
  def test_providers_list
    assert_equal ["anthropic", "gemini", "deepseek", "openai"], LLMSpecs.providers
  end
end
