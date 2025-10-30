# frozen_string_literal: true

require File.expand_path('api', __dir__)

module Huntress
  # The Client class serves as a wrapper for the Hudu REST API, providing methods to interact
  # with various Hudu resources.
  #
  # This class dynamically defines methods to fetch, create, update, and manipulate Hudu resources
  # such as companies, articles, assets, and more.
  #
  # @example Basic Usage
  #   client.companies # Fetch all companies
  #   client.company(1) # Fetch a company by ID
  #   client.update_company(1, { name: "Updated Company" }) # Update a company
  #   client.create_company({ name: "New Company" }) # Create a new company
  class Client < API
    # Dynamically defines methods for interacting with Hudu API resources.
    #
    # Depending on the arguments, this will define methods to:
    # - Fetch all records for a resource
    # - Fetch a specific record by ID
    # - Update a record
    # - Create a new record
    #
    # @param method [Symbol] The method name for fetching all records.
    # @param singular_method [Symbol, nil] The method name for fetching a single record by ID. Optional.
    # @param path [String] The API path for the resource. Defaults to the method name.
    #
    # @example Defining endpoints
    #   api_endpoint :companies, :company
    #   # Defines:
    #   # - `companies(params = {})` to fetch all companies.
    #   # - `company(id, params = {})` to fetch a single company by ID.
    #   # - `update_companies(id, params = {})` to update a company.
    #   # - `create_companies(params = {})` to create a new company.
    def self.api_endpoint(method, singular_method, path = method)
      # Define method to fetch all records and one by id
      send(:define_method, method) do |params = {}|
        get_paged(api_url(path), params)
      end
      # Define method to fetch a single record by ID
      send(:define_method, singular_method) do |id, params = {}|
        get(api_url("#{path}/#{id}"), params)
      end
    end

    def account(options = {})
      get(api_url('account'), options)
    end

    def actor(options = {})
      get(api_url('actor'), options)
    end

    def remediation(incident_report_id, remediation, options = {})
      get_paged(api_url("incident_reports/#{incident_report_id}/remediations/#{remediation}"), options)
    end

    def remediations(incident_report_id, options = {})
      remediation(incident_report_id, nil, options)
    end

    # Define API endpoints for various resources
    api_endpoint :agents, :agent
    api_endpoint :billing_reports, :billing_report
    api_endpoint :incident_reports, :incident_report
    api_endpoint :organizations, :organization
    api_endpoint :reports, :report
    api_endpoint :signals, :signal

    # Constructs the full API URL for a given path.
    #
    # @param path [String] The API path.
    # @return [String] The full API URL.
    def api_url(path)
      "/v1/#{path}"
    end
  end
end
