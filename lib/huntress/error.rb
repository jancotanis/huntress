# frozen_string_literal: true

module Huntress
  # Generic error to be able to rescue all Hudu errors
  class HuntressError < StandardError; end

  # Error when authentication fails
  class AuthenticationError < HuntressError; end
end
