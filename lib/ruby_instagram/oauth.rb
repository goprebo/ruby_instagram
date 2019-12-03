# frozen_string_literal: true

module RubyInstagram
  module OAuth
    OAUTH_ENDPOINT = 'https://api.instagram.com/'
    # Return URL for OAuth authorization
    def authorize_url(options = {})
      send('endpoint=', OAUTH_ENDPOINT)
      options[:response_type] ||= 'code'
      options[:redirect_uri] ||= options[:redirect_uri]
      options[:scope] ||= scope
      params = authorization_params.merge(options)
      connection.build_url('/oauth/authorize/', params).to_s
    end

    # Return an access token from authorization
    def get_access_token(code, options = {})
      send('endpoint=', OAUTH_ENDPOINT)
      options[:grant_type] ||= 'authorization_code'
      options[:redirect_uri] ||= redirect_uri
      params = access_token_params.merge(options)
      post('/oauth/access_token/', params.merge(code: code))
    end

    private

    def authorization_params
      { app_id: app_id }
    end

    def access_token_params
      {
        app_id: app_id,
        app_secret: app_secret
      }
    end
  end
end
