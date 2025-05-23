# frozen_string_literal: true
module LLMSpecs
  class Cache
    def initialize(file, ttl: 86400)
      @file = file
      @ttl  = ttl
    end
    
    def fetch
      return read if valid?
      yield.tap { write it }
    end
    
    def valid?
      File.exist?(@file) && (Time.now - File.mtime(@file) < @ttl)
    end
    
    def read
      JSON.parse(File.read(@file), symbolize_names: true)
    end

    def write(data)
      File.write(@file, JSON.pretty_generate(data)) if data
    end
  end
end
