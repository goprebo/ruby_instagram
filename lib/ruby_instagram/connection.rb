# frozen_string_literal: true

require 'faraday_middleware'
Dir[File.expand_path('../faraday/*.rb', __dir__)].each { |f| require f }

module RubyInstagram
  module Connection
    private

    def connection(raw = false)
      options = { headers: { 'Accept' => 'application/json; charset=utf-8', 'User-Agent' => user_agent },
                  url: endpoint }.merge(connection_options)

      Faraday::Connection.new(options) do |connection|
        connection.use(FaradayMiddleware::OAuth2, access_token) if access_token
        connection.use(Faraday::Request::UrlEncoded)
        connection.use FaradayMiddleware::Mashify unless raw
        connection.use(Faraday::Response::ParseJson) unless raw
        connection.use(FaradayMiddleware::RaiseHttpException)
        connection.adapter Faraday.default_adapter
      end
    end
  end
end
