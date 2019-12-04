# frozen_string_literal: true

require File.expand_path('../lib/ruby_instagram', __dir__)

RSpec.describe RubyInstagram do
  it 'has a version number' do
    expect(RubyInstagram::VERSION).not_to be nil
  end
end
