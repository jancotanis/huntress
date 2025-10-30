# frozen_string_literal: true

require 'wrapi'
require File.expand_path('huntress/version', __dir__)
require File.expand_path('huntress/client', __dir__)
require File.expand_path('huntress/pagination', __dir__)

# The Huntress module provides utilities to manage and manipulate assets within the Huntress api
module Huntress
  extend WrAPI::Configuration
  extend WrAPI::RespondTo

  # Default User-Agent header sent with API requests, including gem version information.
  DEFAULT_UA = "Huntress Ruby API wrapper #{Huntress::VERSION}"
  # Default api endpoint
  DEFAULT_ENDPOINT = 'https://api.huntress.io'
  DEFAULT_PAGINATION = RequestPagination::PaginationPager
  DEFAULT_PAGE_SIZE = 25

  #
  # @return [Huntress::Client]
  def self.client(options = {})
    Huntress::Client.new({
      endpoint: DEFAULT_ENDPOINT,
      user_agent: DEFAULT_UA,
      page_size: DEFAULT_PAGE_SIZE,
      pagination_class: DEFAULT_PAGINATION
    }.merge(options))
  end

  # Resets the Skykick configuration to default values.
  #
  # This method resets the configuration values to their defaults:
  # - `DEFAULT_UA` for the User-Agent
  #
  # @example Reset the Huntress configuration:
  #   Huntress.reset
  def self.reset
    super
    self.endpoint = DEFAULT_ENDPOINT
    self.user_agent = DEFAULT_UA
    self.page_size        = DEFAULT_PAGE_SIZE
    self.pagination_class = DEFAULT_PAGINATION
  end
end
