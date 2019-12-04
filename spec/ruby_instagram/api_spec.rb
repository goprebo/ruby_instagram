# frozen_string_literal: true

require File.expand_path('../spec_helper', __dir__)

RSpec.describe RubyInstagram::API do
  let(:keys) { RubyInstagram::Configuration::VALID_OPTIONS_KEYS }

  context 'module configuration' do
    before do
      RubyInstagram.configure do |config|
        keys.each { |key| config.send("#{key}=", key) }
      end
    end

    it 'should inherit module configuration' do
      keys.each do |key|
        expect(subject.send(key)).to eq(key)
      end
    end
  end

  describe '#config' do
    let(:config) do
      config = {}
      keys.each { |key| config[key] = key }
      config
    end
    it 'returns a hash representing the configuration' do
      keys.each { |key| subject.send("#{key}=", key) }
      expect(subject.config).to eq(config)
    end
  end
end
