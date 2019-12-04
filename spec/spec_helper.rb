# frozen_string_literal: true

require 'coveralls'
Coveralls.wear!

require 'bundler/setup'
require 'ruby_instagram'
require 'pry'

require 'vcr'

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = '.rspec_status'

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end

VCR.configure do |c|
  c.cassette_library_dir = 'spec/vcr_cassetes'
  c.hook_into :faraday
  c.default_cassette_options = { record: :new_episodes }
end
