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

    def read
      File.read(@file)
    end

    def write(data)
      File.write(@file, data)
    end

    def valid?
      exist? && fresh?
    end

    def exist?
      File.exist?(@file)
    end

    def fresh?
      Time.now - File.mtime(@file) < @ttl
    end
  end
end
