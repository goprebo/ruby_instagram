# frozen_string_literal: true

require 'faraday'

# @private
module FaradayMiddleware
  # @private
  class RaiseHttpException < Faraday::Middleware
    def call(env)
      @app.call(env).on_complete do |response|
        case response[:status].to_i
        when 400
          raise RubyInstagram::BadRequest, error_message_400(response)
        when 404
          raise RubyInstagram::NotFound, error_message_400(response)
        when 429
          raise RubyInstagram::TooManyRequests, error_message_400(response)
        when 500
          raise RubyInstagram::InternalServerError, error_message_500(response, 'Something is technically wrong.')
        when 502
          raise RubyInstagram::BadGateway, error_message_500(response, 'The server returned an invalid or incomplete response.')
        when 503
          raise RubyInstagram::ServiceUnavailable, error_message_500(response, 'Instagram is rate limiting your requests.')
        when 504
          raise RubyInstagram::GatewayTimeout, error_message_500(response, '504 Gateway Time-out')
        end
      end
    end

    def initialize(app)
      super app
      @parser = nil
    end

    private

    def content_type(response)
      response[:response_headers][:content_type]
    end

    def text_response?(response)
      content_type(response) == 'text/html; charset=utf-8'
    end

    def error_message_400(response)
      "#{response[:method].to_s.upcase} #{response[:url]}: #{response[:status]} #{error_body(response)}"
    end

    def error_message_500(response, body = nil)
      "#{response[:method].to_s.upcase} #{response[:url]}: #{[response[:status].to_s + ':', body].compact.join(' ')}"
    end

    def error_body(response)
      return response[:body] if text_response?(response)

      JSON.parse(response[:body])
    end
  end
end
