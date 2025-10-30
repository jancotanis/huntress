# frozen_string_literal: true

module Huntress
  # Create connection including and keep it persistent so we add the rate throtling middleware only once
  module Connection
    private

    def connection
      unless @connection
        @connection = super
        @connection.use WrAPI::RateThrottleMiddleware, limit: 60, period: 60
      end
      @connection
    end
  end
end
