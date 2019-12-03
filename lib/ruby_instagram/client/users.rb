# frozen_string_literal: true

module RubyInstagram
  class Client
    # Defines methods related to users
    module Users
      # Returns extended information of a given user
      #
      # @overload user(id=nil, options={})
      #   @param user [Integer] An Instagram user ID
      #   @return [Hash] The requested user.
      #   @example Return extended information for @shayne
      #     RubyInstagram.user(20)
      # @format :json
      # @authenticated true
      #
      #   If getting this data of a protected user, you must authenticate (and be allowed to see that user).
      # @rate_limited true
      # @see http://instagram.com/developer/endpoints/users/#get_users
      def user(*args)
        options = args.last.is_a?(Hash) ? args.pop : {}
        get(args.first || 'me', options)
      end
    end

    # Returns a list of recent media items for a given user
    #
    # @overload user_recent_media(options={})
    #   @param options [Hash] A customizable set of options.
    #   @return [Hash]
    #   @example Returns a list of recent media items for the currently authenticated user
    #     RubyInstagram.user_recent_media
    # @overload user_recent_media(id=nil, options={})
    #   @param user [Integer] An Instagram user ID.
    #   @param options [Hash] A customizable set of options.
    #   @option options [Integer] :max_id (nil) Returns results with an ID less than (that is, older than) or equal to the specified ID.
    #   @option options [Integer] :count (nil) Limits the number of results returned per page.
    #   @return [Hash]
    #   @example Return a list of media items taken by @mikeyk
    #     Instagram.user_recent_media(4) # @mikeyk user ID being 4
    # @see http://instagram.com/developer/endpoints/users/#get_users_media_recent
    # @format :json
    # @authenticated true
    #
    #   For getting this data, you must authenticate (and be allowed to see that user).
    # @rate_limited true
    def user_media(*args)
      options = args.last.is_a?(Hash) ? args.pop : {}
      id = args.first || 'me'
      get("#{id}/media", options)
    end
  end
end
