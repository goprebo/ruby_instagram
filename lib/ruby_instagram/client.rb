# frozen_string_literal: true

module RubyInstagram
  # Wrapper for the Instagram REST API
  #
  # @note All methods have been separated into modules and follow the same grouping used in https://developers.facebook.com/docs/instagram-basic-display-api/reference
  # @see http://instagram.com/developer/
  class Client < API
    Dir[File.expand_path('client/*.rb', __dir__)].each { |f| require f }
    include RubyInstagram::Client::Utils

    include RubyInstagram::Client::Users
  end
end
