# frozen_string_literal: true

require File.expand_path('../../spec_helper', __dir__)

RSpec.describe RubyInstagram::Client::Users do
  describe '#get_user_info' do
    let(:access_token) { 'IGQVJXdGRuX1RhdDVTNW1pRUozRm5yNXF2d3BScWp3dzBOZAm51RWpBZAUZAOMV9TVHVOZAlpfcWtDd2Y2WjVHNXJERHBLbFBJQU95OTZAidjJNMnpTSk44V0xIQzZAPQjVLbkNaMHZATMXowcFZAVd3lSZAmQ4Sm5GNktsbFY5dmp3' }
    let(:fields) { 'media_count,username,media,account_type' }
    let(:options) do
      { app_id: app_id, app_secret: 'a_secret', redirect_uri: 'https://goprebo.com/' }
    end
    describe 'common expected_fields' do
      it 'should get the expected response' do
        VCR.use_cassette('get_user_info') do
          client = RubyInstagram.client(access_token: access_token)
          response = client.user(fields: fields)
          expect(response.username).to be_truthy
          expect(response.media_count).to be_truthy
          expect(response.account_type).to be_truthy
          expect(response.media).to be_truthy
        end
      end
    end
  end
  describe '#get_user_media' do
    let(:access_token) { 'IGQVJXdGRuX1RhdDVTNW1pRUozRm5yNXF2d3BScWp3dzBOZAm51RWpBZAUZAOMV9TVHVOZAlpfcWtDd2Y2WjVHNXJERHBLbFBJQU95OTZAidjJNMnpTSk44V0xIQzZAPQjVLbkNaMHZATMXowcFZAVd3lSZAmQ4Sm5GNktsbFY5dmp3' }
    let(:fields) { 'media_count,username,media,account_type' }
    let(:options) do
      { app_id: app_id, app_secret: 'a_secret', redirect_uri: 'https://goprebo.com/' }
    end
    describe 'expected_fields' do
      let(:fields) { 'thumbnail_url,media_type,media_url,caption,username' }
      it 'should get the expected response' do
        VCR.use_cassette('user_media') do
          client = RubyInstagram.client(access_token: access_token)
          media_items = client.user_media(fields: fields)
          expect(media_items).to all(satisfy('has all fields') do |item|
            fields = case item.media_type
                     when 'VIDEO'
                       %i[thumbnail_url media_type caption username]
                     else
                       %i[media_type media_url caption username]
                     end
            fields.all? { |field| item.send(field) }
          end)
        end
      end
    end
  end
end
