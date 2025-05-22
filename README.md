# LLMSpecs

LLMSpecs is a lightweight Ruby interface for fetching and caching 
large language model (LLM) specifications from the [Parsera API](https://llmspecs.parsera.org).
It provides a simple, efficient way to access model metadata with built-in caching and query support.

## Features

- Fetches LLM specs from: https://api.parsera.org/v1/llm-specs
- Caches results locally to models.json
- Provides a queryable catalog of models via .models
- Supports filtering and lookup by model attributes

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

- Pricing breakdowns via `input_pricing` and `output_pricing`

You can easily check capabilities:
```ruby
model.supports?(:function_calling) # => true/false
model.function_calling?  # => shortcut for above


or input or output modalities:
```ruby
models.supports_input?(:audio) # => true/false
models.audio_input? # shortcut
models.image_input?
models.text_input?

models.supports_output?(:audio) # => true/false
models.audio_output? # shortcut
models.image_output?
models.text_output?
models.embeddings_output?
```

Pricing
```ruby
model.input_pricing      # => $ per 1M input tokens (default)
model.input_pricing(:text_tokens, :batch)
model.output_pricing(:embeddings)
```

## Example Usage
```ruby
require 'llm_specs'

models = LLMSpecs.models
```

### Find a model by ID
```ruby
model = LLMSpecs.models.find("claude-3-sonnet")
```

### Filter models
```ruby
# List all Anthropic models
anthropic_models = LLMSpecs.models.where(provider: "anthropic")

# List all Anthropic models by family "claude-3-7-sonnet"
claude_models = LLMSpecs.models.where(provider: "anthropic", family: "claude-3-7-sonnet")

# List all models that support streaming
streaming_models = LLMSpecs.models.select(&:streaming?)

# List all models that support audio output
streaming_models = LLMSpecs.models.select(&:audio_output?)

```

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
