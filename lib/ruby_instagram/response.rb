# frozen_string_literal: true

module RubyInstagram
  module Response
    def self.create(response_hash)
      return response_hash.data if response_hash.respond_to?(:data)

      response_hash
    end
  end
end
