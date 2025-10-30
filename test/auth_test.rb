# frozen_string_literal: true

require 'logger'
require 'test_helper'

AUTH_LOGGER = 'auth_test.log'
File.delete(AUTH_LOGGER) if File.exist?(AUTH_LOGGER)

describe 'auth' do
  before do
    Huntress.reset
    Huntress.logger = Logger.new(AUTH_LOGGER)
  end
  it '#0 check required params' do
    c = Huntress.client
    # missing endpoint
    assert_raises ArgumentError do
      c.login
    end
  end
  it '#1 check required params' do
    Huntress.configure do |config|
      config.client_id = 'api-key-token'
    end
    c = Huntress.client
    # missing access_token
    assert_raises ArgumentError do
      c.login
    end
    Huntress.configure do |config|
      config.client_id = nil
      config.client_secret = 'api-secret'
    end
    c = Huntress.client
    assert_raises ArgumentError do
      c.login
    end
  end
  it '#2 wrong credentials' do
    Huntress.configure do |config|
      config.client_id = 'api-key-token'
      config.client_secret = 'api-secret'
    end
    c = Huntress.client
    assert_raises Huntress::AuthenticationError do
      c.login
    end
  end
  it '#3 logged in' do
    Huntress.configure do |config|
      config.client_id = ENV['HUNTRESS_API_KEY']
      config.client_secret = ENV['HUNTRESS_API_SECRET']
    end
    c = Huntress.client
    result = c.login
    refute_empty result, '.login'
  end
end
