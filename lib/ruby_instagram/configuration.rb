# frozen_string_literal: true

require 'faraday'
require File.expand_path('version', __dir__)

module RubyInstagram
  # Defines constants and methods related to configuration
  module Configuration
    # An array of valid keys in the options hash when configuring a {RubyInstagram::API}
    VALID_OPTIONS_KEYS = %i[
      access_token
      app_id
      app_secret
      scope
      connection_options
      redirect_uri
      endpoint
      user_agent
    ].freeze

    # By default, don't set a user access token
    DEFAULT_ACCESS_TOKEN = nil

    # By default, don't set an application ID
    DEFAULT_APP_ID = nil

    # By default, don't set an application secret
    DEFAULT_APP_SECRET = nil

    # By default, don't set any connection options
    DEFAULT_CONNECTION_OPTIONS = {}.freeze

    # The endpoint that will be used to connect if none is set
    #
    # @note There is no reason to use any other endpoint at this time
    DEFAULT_ENDPOINT = 'https://graph.instagram.com/'

    # By default, don't set an application redirect uri
    DEFAULT_REDIRECT_URI = nil

    # By default, don't set a user scope
    DEFAULT_SCOPE = 'user_profile'

    # The user agent that will be sent to the API endpoint if none is set
    DEFAULT_USER_AGENT = "Instagram Ruby Gem #{RubyInstagram::VERSION}"

    # @private
    attr_accessor(*VALID_OPTIONS_KEYS)

    # When this module is extended, set all configuration options to their default values
    def self.extended(base)
      base.reset
    end

    # Convenience method to allow configuration options to be set in a block
    def configure
      yield self
    end

    # Create a hash of options and their values
    def options
      VALID_OPTIONS_KEYS.inject({}) do |option, key|
        option.merge!(key => send(key))
      end
    end

    # Reset all configuration options to defaults
    def reset
      self.access_token       = DEFAULT_ACCESS_TOKEN
      self.app_id             = DEFAULT_APP_ID
      self.app_secret         = DEFAULT_APP_SECRET
      self.connection_options = DEFAULT_CONNECTION_OPTIONS
      self.scope              = DEFAULT_SCOPE
      self.redirect_uri       = DEFAULT_REDIRECT_URI
      self.endpoint           = DEFAULT_ENDPOINT
      self.user_agent         = DEFAULT_USER_AGENT
    end
  end
end
