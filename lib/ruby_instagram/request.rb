# frozen_string_literal: true

require 'openssl'
require 'base64'

module RubyInstagram
  # Defines HTTP request methods
  module Request
    # Perform an HTTP GET request
    def get(path, options = {}, raw = false)
      request(:get, path, options, raw)
    end

    # Perform an HTTP POST request
    def post(path, options = {}, raw = false)
      request(:post, path, options, raw)
    end

    private

    # Perform an HTTP request
    def request(method, path, options, raw = false)
      response = connection(raw).send(method) do |request|
        options = options.compact
        case method
        when :get
          request.url(path, options)
        when :post
          request.url(path)
          request.body = options unless options.empty?
        end
      end

      return response if raw

      Response.create(response.body)
    end
  end
end
