# frozen_string_literal: true

require File.expand_path('ruby_instagram/error', __dir__)
require File.expand_path('ruby_instagram/configuration', __dir__)
require File.expand_path('ruby_instagram/api', __dir__)
require File.expand_path('ruby_instagram/client', __dir__)
require File.expand_path('ruby_instagram/response', __dir__)

module RubyInstagram
  extend Configuration

  # Alias for Instagram::Client.new
  #
  # @return [Instagram::Client]
  def self.client(options = {})
    RubyInstagram::Client.new(options)
  end

  # Delegate to Instagram::Client
  def self.method_missing(method, *args, &block)
    return super unless client.respond_to?(method)

    client.send(method, *args, &block)
  end

  # Delegate to Instagram::Client
  def self.respond_to?(method, include_all = false)
    client.respond_to?(method, include_all) || super
  end
end
