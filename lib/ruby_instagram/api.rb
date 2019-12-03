# frozen_string_literal: true

require File.expand_path('connection', __dir__)
require File.expand_path('request', __dir__)
require File.expand_path('oauth', __dir__)

module RubyInstagram
  class API
    attr_accessor(*Configuration::VALID_OPTIONS_KEYS)

    # Creates a new API
    def initialize(options = {})
      options = RubyInstagram.options.merge(options)
      Configuration::VALID_OPTIONS_KEYS.each do |key|
        send("#{key}=", options[key])
      end
    end

    def config
      {}.tap do |conf|
        Configuration::VALID_OPTIONS_KEYS.each do |key|
          conf[key] = send(key)
        end
      end
    end

    include Connection
    include Request
    include OAuth
  end
end
