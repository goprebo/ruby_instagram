[![wercker status](https://app.wercker.com/status/18ae5df682bec0bc60b9ed3174f9f98b/s/master "wercker status")](https://app.wercker.com/project/byKey/18ae5df682bec0bc60b9ed3174f9f98b)
[![Coverage Status](https://coveralls.io/repos/github/goprebo/ruby_instagram/badge.svg?branch=master)](https://coveralls.io/github/goprebo/ruby_instagram?branch=master)

# RubyInstagram

Ruby wrapper for the Instagram APIs

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'ruby_instagram'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install ruby_instagram

## Usage

```ruby
RubyInstagram.configure do |config|
  config.client_id = "YOUR_CLIENT_ID"
  config.client_secret = "YOUR_CLIENT_SECRET"
  redirect_uri = "YOUR_REDIRECT_URI"
end
```

### Authentication

get "/oauth/connect" do
  redirect Instagram.authorize_url(:redirect_uri => CALLBACK_URL)
end

get "/oauth/callback" do
  response = Instagram.get_access_token(params[:code], :redirect_uri => CALLBACK_URL)
  session[:access_token] = response.access_token
  redirect "/nav"
end

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/goprebo/ruby_instagram. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the RubyInstagram project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/goprebo/ruby_instagram/blob/master/CODE_OF_CONDUCT.md).
