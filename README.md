[![wercker status](https://app.wercker.com/status/18ae5df682bec0bc60b9ed3174f9f98b/s/master "wercker status")](https://app.wercker.com/project/byKey/18ae5df682bec0bc60b9ed3174f9f98b)
[![Coverage Status](https://coveralls.io/repos/github/goprebo/ruby_instagram/badge.svg?branch=HEAD)](https://coveralls.io/github/goprebo/ruby_instagram?branch=master)

# RubyInstagram

Ruby wrapper for the [Instagram Basic display API](https://developers.facebook.com/docs/instagram-basic-display-api). Based on already deprecated [Instagram API](https://github.com/facebookarchive/instagram-ruby-gem) gem

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

### Build authentatication window url

```ruby
RubyInstagram.authorize_url(redirect_uri: <CALLBACK_URL>)
```

### Get access token
```ruby
RubyInstagram.get_access_token(code, redirect_uri: <CALLBACK_URL>)
```

### Get user info
```ruby
client = RubyInstagram.client(access_token: <access_token>)
user = client.user(fields: 'media_count,username,media,account_type')
```

### Get user media
```ruby
client = RubyInstagram.client(access_token: <access_token>)
user = client.user(fields: 'media_count,username,media,account_type')
items = client.user_media(fields: 'thumbnail_url,media_type,media_url,caption,username')
```

### Sample Client

Run ```ruby sample_app.rb``` to test above descripted usage.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/goprebo/ruby_instagram. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the RubyInstagram project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/goprebo/ruby_instagram/blob/master/CODE_OF_CONDUCT.md).
