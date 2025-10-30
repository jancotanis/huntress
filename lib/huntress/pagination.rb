# frozen_string_literal: true

require 'uri'
require 'json'

module Huntress
  # Defines HTTP request methods
  # @see https://api.huntress.io/docs
  module RequestPagination
    # The PaginationPager class provides a mechanism to handle pagination information for API responses.
    #
    # It manages the current page, page size, and provides utilities for determining if there are more pages to fetch.
    #
    # @example Basic Usage
    #   pager = PaginationPager.new(50)
    #   while pager.more_pages?
    #     response = api_client.get_data(pager.page_options)
    #     pager.next_page!(response.body)
    #   end
    class PaginationPager
      # Initializes a new PaginationPager instance.
      #
      # @param page_size [Integer] The number of records to fetch per page.
      def initialize(page_size)
        @page = 1
        @page_token = @pagination_data = nil
        @limit = page_size
      end

      # Provides the current pagination parameter options for each rest request.
      #
      # @return [Hash] A hash containing the current page and page size.
      #
      # @example
      #   pager.page_options # => { page_token: 'Mjadso43289', page_size: 50 }
      def page_options
        options = { limit: @limit }
        options.merge!({ page_token: @page_token }) if @page_token
        options
      end

      # Advances to the next page based on the response body and updates internal pagination state.
      #
      # @param body [Hash] The response body from the API, expected to contain a paginated resource.
      # @return [Integer] The updated page total, typically the count of items on the current page.
      #
      # @example
      #   response_body = { "items" => [...] }
      #   pager.next_page!(response_body)
      def next_page!(body)
        @page += 1
        @pagination_data = PaginationPager.pagination_data(body)
      end

      # Determines whether there are more pages to fetch.
      #
      # @return [Boolean] Returns `true` if the current page is full, indicating another page might exist.
      #
      # @example
      #   pager.more_pages? # => true or false
      def more_pages?
        # while full page we have next page
        if @pagination_data
          @page_token = @pagination_data['next_page_token']
        else
          @page.eql? 1
        end
      end

      # Extracts paginated data from the response body.
      #
      # @param body [Hash] The response body containing resource data, expected to be in a hash format.
      # @return [Array, Hash, Object] Returns the extracted data, which could be an array, hash, or other object.
      #
      # @example
      #   response_body = { "items" => [1, 2, 3] }
      #   PaginationPager.data(response_body) # => [1, 2, 3]
      def self.data(body)
        # assume hash {"resource":[...]}, get first key and return array data
        result = body
        if result.is_a?(Hash)
          _k, v = body.first
          result = v if v.is_a?(Array) || v.is_a?(Hash)
        end
        result
      end

      # Extracts pagination information
      #
      # @param body [Hash] The response body containing resource data, and pagination infromation in a hash format.
      # @return Hash Returns the extracted data, which could be an array, hash, or other object.
      #
      # @example
      #   response_body = {
      #     "items" => [1, 2, 3],
      #     "pagination" => {"current_page" => 1, "current_page_count": 10, "limit": 10, "total_count":60,
      #     "next_page": 2, "next_page_url": "https://api.xx.io/v1/signals?page_token=NjEyNjgxMzE%3D&limit=10",
      #     "next_page_token": "NjEyNjgxMzE=" } }
      #   PaginationPager.pagination_data(response_body) # => {"current_page" => 1, "current_page_count": 10, ...
      def self.pagination_data(body)
        # assume hash {"resource":[...], "pagination":{}}, return pagination data
        body.is_a?(Hash) ? body['pagination'] : nil
      end
    end
  end
end
