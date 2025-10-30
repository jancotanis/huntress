# frozen_string_literal: true

require 'logger'
require 'test_helper'

CLIENT_LOGGER = 'client_test.log'
File.delete(CLIENT_LOGGER) if File.exist?(CLIENT_LOGGER)

describe 'client' do
  before do
    Huntress.reset
    Huntress.configure do |config|
      config.logger = Logger.new(CLIENT_LOGGER)
      config.client_id = ENV['HUNTRESS_API_KEY']
      config.client_secret = ENV['HUNTRESS_API_SECRET']
    end
    @client = Huntress.client
    @client.login
  end
  describe '#api_url' do
    it 'prefixes paths with /v1/' do
      _(@client.api_url('test')).must_equal('/v1/test')
    end
  end

  describe '#account' do
    it 'calls get with /v1/account' do
      a = @client.account
      ['id', 'name', 'subdomain','status'].each do |attribute|
        refute_nil a[attribute]
      end
    end
  end

  describe '#actor' do
    it 'calls get with /v1/actor' do
      a = @client.actor
      ['id', 'name', 'subdomain','status'].each do |attribute|
        refute_nil a[attribute]
      end
    end
  end

  describe '#agents' do
    it 'calls get with /v1/agents' do
#      a = @client.agents
    end
  end

  describe '#billing_reports' do
    it 'calls get with /v1/billing_reports' do
      b = @client.billing_reports
      if b1 = b.first
        b2 = @client.billing_report(b1.id)
        assert_equal b2, b1
      end
    end
  end

  describe '#incident_reports' do
    it 'calls get with /v1/incident_reports' do
      i = @client.incident_reports
      if i1 = i.first
        i2 = @client.incident_report(i1.id)
        assert_equal i2, i1
        r = @client.remediations(i1.id)
        if r1 = r.first
          r2 = @client.remediation(i1.id, r1.id)
          assert_equal r2, r1
        end
      end
    end
  end

  describe '#organizations' do
    it 'calls get with /v1/organizations' do
      o = @client.organizations
      if o1 = o.first
        o2 = @client.organization(o1.id)
        assert_equal o2, o1
      end
    end
  end

  describe '#reports' do
    it 'calls get with /v1/reports' do
      r = @client.reports
      if r1 = r.first
        r2 = @client.report(r1.id)
        assert_equal r2, r1
      end
    end
  end

  describe '#signals' do
    it 'calls get with /v1/signals' do
      s = @client.signals
      if s1 = s.first
        s2 = @client.signal(s1.id)
        assert_equal s2, s1
      end
    end
  end
end
