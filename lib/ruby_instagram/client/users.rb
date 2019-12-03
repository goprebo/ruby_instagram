# frozen_string_literal: true

module RubyInstagram
  class Client
    # Defines methods related to users
    module Users
      # Returns extended information of a given user
      #
      # @overload user(id=nil, options={})
      #   @param user [Integer] An Instagram user ID
      #   @return [Hashie::Mash] The requested user.
      #   @example Return extended information for @shayne
      #     RubyInstagram.user(20)
      # @authenticated true
      #
      #   If getting this data of a protected user, you must authenticate (and be allowed to see that user).
      # @see https://developers.facebook.com/docs/instagram-basic-display-api/reference/user
      def user(*args)
        options = args.last.is_a?(Hash) ? args.pop : {}
        get(args.first || 'me', options)
      end
    end

    # Returns a list of recent media items for a given user
    #
    # @overload user_recent_media(options={})
    #   @param options [Hash] A customizable set of options.
    #   @return [Hashie::Mash]
    #   @example Returns a list of user media items for the currently authenticated user
    #     RubyInstagram.user_media
    # @see https://developers.facebook.com/docs/instagram-basic-display-api/reference/user/media
    # @authenticated true
    #
    # For getting this data, you must authenticate (and be allowed to see that user).
    def user_media(*args)
      options = args.last.is_a?(Hash) ? args.pop : {}
      id = args.first || 'me'
      get("#{id}/media", options)
    end
  end
end
