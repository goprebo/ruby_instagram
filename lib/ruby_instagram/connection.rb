# frozen_string_literal: true

require 'faraday_middleware'
Dir[File.expand_path('../faraday/*.rb', __dir__)].each { |f| require f }

module RubyInstagram
  module Connection
    private

    def connection(raw = false)
      options = { headers: { 'Accept' => 'application/json; charset=utf-8', 'User-Agent' => user_agent },
                  url: endpoint }.merge(connection_options)

      Faraday::Connection.new(options) do |builder|
        builder.use(FaradayMiddleware::OAuth2, access_token, token_type: :param) if access_token
        builder.use(Faraday::Request::UrlEncoded)
        builder.use FaradayMiddleware::Mashify unless raw
        builder.use(Faraday::Response::ParseJson) unless raw
        builder.use(FaradayMiddleware::RaiseHttpException)
        builder.adapter Faraday.default_adapter
      end
    end
  end
end
