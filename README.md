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

You can easily check capabilities or pricing:
```ruby
model.function_calling?  # => true/false
model.input_pricing      # => $ per 1M input tokens (default)
model.output_pricing(:image_tokens)
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
anthropic_models = LLMSpecs.models.where(provider: "anthropic")

claude_models = LLMSpecs.models.where(provider: "anthropic", family: "claude-3-7-sonnet")
```

### List all models that support streaming
```ruby
streaming_models = LLMSpecs.models.select(&:streaming?)
```

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
