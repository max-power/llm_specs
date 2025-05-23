# LLMSpecs

LLMSpecs is a lightweight Ruby interface for fetching 
large language model (LLM) specifications from the [Parsera API](https://llmspecs.parsera.org).
It provides a simple, efficient way to access model metadata with built-in caching and query support.

## Features

- Fetches LLM specs from: https://api.parsera.org/v1/llm-specs
- Caches results locally to llm-specs.json
- Provides a queryable catalog of models via .models
- Supports filtering and lookup by model attributes


## Example Usage
```ruby
require 'llm_specs'

models = LLMSpecs.models # all models

models = LLMSpecs.gemini # provider specific models
models = LLMSpecs.anthropic
models = LLMSpecs.openai
models = LLMSpecs.deepseek
```

### Find a model by ID
```ruby
model = LLMSpecs.models.find("claude-3-sonnet")
```

### Filter models
```ruby
# List all Anthropic models
anthropic_models = LLMSpecs.models.where(provider: "anthropic")
# or 
anthropic_models = LLMSpecs.anthropic

# List all Anthropic models by family "claude-3-7-sonnet"
claude_models = LLMSpecs.models.where(provider: "anthropic", family: "claude-3-7-sonnet")
#or 
claude_models = LLMSpecs.anthropic.where(family: "claude-3-7-sonnet")

# List all models that support streaming
streaming_models = LLMSpecs.models.select(&:streaming?)

# List all models that support audio output
audio_models = LLMSpecs.models.select(&:audio_output?)

```

##  Model Capabilities
Each model is represented by an instance of `LLMSpecs::Model`, a value object that encapsulates:

- `id`, `name`, `provider`, `family`
- Token limits (`context_window`, `max_output_tokens`)
- Supported modalities (e.g. `text`, `image`)
- Capabilities such as:
    - `function_calling?`
    - `structured_output?`
    - `streaming?`
    - `reasoning?`
    - `citations?`
    - `batch?`

- Pricing breakdowns via `pricing`, `input_pricing` and `output_pricing`

You can easily check capabilities:
```ruby
model.supports?(:function_calling) # => true/false
model.function_calling?  # => shortcut for above
# with multiple arguments
model.supports?(:function_calling, :batch) # => true/false
```

or input or output modalities:
```ruby
model.supports_input?(:audio) # => true/false
model.supports_input?(:audio, :text) # multiple argument
model.audio_input? # shortcut
model.image_input?
model.text_input?

model.supports_output?(:audio) # => true/false
model.supports_output?(:audio, :embeddings) # multiple argument
model.audio_output? # shortcut
model.image_output?
model.text_output?
model.embeddings_output?
```

Pricing methods:
```ruby
model.input_pricing # => returns a hash: 
#  {
#    text_tokens: {
#      standard: {
#        input_per_million: 15.0,
#        cached_input_per_million: 18.75,
#        output_per_million: 75.0
#      },
#      batch: {
#        input_per_million: nil,
#        output_per_million: nil
#      }
#    },
#    embeddings: {
#      standard: {
#        input_per_million: nil
#      },
#      batch: {
#        input_per_million: nil
#      }
#    }
#  }

model.input_pricing  # 15.0 => $ per 1M input tokens (default to pricing[:text_tokens][:standard][:input_per_million])
model.output_pricing

model.input_pricing(:text_tokens, :batch)
model.output_pricing(:embeddings)
```

## Cache configuration

```ruby
LLMSpecs.cache_path = Rails.root.join("tmp", "cache", "llm-specs-cache.json")
```

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
