# frozen_string_literal: true

require 'base64'
require File.expand_path('error', __dir__)

module Huntress
  # Deals with authentication flow and stores it within global configuration
  module Authentication
    #
    # Authorize to the Hudu portal and return access_token
    def login(options = {})
      raise ArgumentError, 'client_id not set' unless client_id
      raise ArgumentError, 'client_secret not set' unless client_secret

      # pass api key (id) and secret using basic authentication/connection
      self.token_type = 'Basic'
      self.access_token = Base64.strict_encode64("#{client_id}:#{client_secret}")

      # will do sanitty check if token if valid
      get('/v1/account', options)
    rescue Faraday::Error => e
      raise AuthenticationError, e
    end
  end
end
