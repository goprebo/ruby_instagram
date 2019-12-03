# frozen_string_literal: true

require 'sinatra'
require 'pry'
require File.expand_path('lib/ruby_instagram', __dir__)

enable :sessions

CALLBACK_URL = 'localhost:4567/oauth/callback'

RubyInstagram.configure do |config|
  config.app_id = 2_335_514_866_760_592
  config.app_secret = 'f1b89d271654aba579f3c7eccfe7f7a9'
  config.access_token = 'IGQVJVUlRMY2hiRWxKbG9SLUxaNXZAhYTUtUFgyS3hLd1daTGZAOSTlDN29wTFdERG10aW82OVcwTWZAZAOE0wa3FvMFFHRkFZAUThGZA1dlTmV5ZAWktOGdTQm8wUHhnMlBfcEpmaGcyaEN4MnFNN1RMbGcwaEl1U1BhdTBSZAUw4'
end

get '/' do
  html =
    "\n <h1>Ruby Instagram Gem Sample Application</h1>
      <ol>
        <li><a href='/oauth/authorize'>Connect with Instagram</a></li>
        <li><a href='/user_media'>User Media</a> Get a list of a user's media</li>
      </ol>
    "
  html
end

get '/oauth/authorize' do
  redirect RubyInstagram.authorize_url(redirect_uri: CALLBACK_URL)
end

get '/oauth/callback' do
  response = RubyInstagram.get_access_token(params[:code], redirect_uri: CALLBACK_URL)
  session[:access_token] = response.access_token
  redirect '/nav'
end

get '/user_media' do
  access_token = session[:access_token] || RubyInstagram.access_token
  return '<h1>Not logged user</h1>' unless access_token

  client = RubyInstagram.client(access_token: access_token)
  user = client.user(fields: 'media_count,username,media,account_type')
  html = "<h1>#{user.username}'s media, media_count:#{user.media_count}, account_type: #{user.account_type} </h1>"
  items = client.user_media(fields: 'thumbnail_url,media_type,media_url,caption,username')
  items.each do |media_item|
    html += "<div style='float:left;'><img height='100' width='100' src='#{media_item.media_url}'><br/></div>"
  end
  html
end
