# Sophos Central Partner API

[![Version](https://img.shields.io/gem/v/huntress.svg)](https://rubygems.org/gems/huntress)


This is a wrapper for the Huntress API.
You can see the [API endpoints](https://api.huntress.io/docs)

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'huntress'
```

And then execute:

```console
> bundle install
```

Or install it yourself as:

```console
> gem install huntress
```

## Usage

Before you start making the requests to API provide the client id and client secret
and email/password using the configuration wrapping.

```ruby
require 'huntress'

LOGGER = 'huntres-api.log'

Huntress.reset
Huntress.logger = Logger.new(AUTH_LOGGER)

Huntress.configure do |config|
  config.client_id = ENV['HUNTRESS_API_KEY']
  config.client_secret = ENV['HUNTRESS_API_SECRET']
end
client = Huntress.client
result = client.login
```

## Resources

### Authentication

```ruby
# setup configuration
#
client.login
```

|Resource|API endpoint|Description|
|:--|:--|:--|
|.login|||

### Operations

Huntress endpoint implemented

|Resource|API endpoint|
|:--|:--|
|.account                                               |/v1/account|
|.actor                                                 |/v1/actor|
|.agents, .agent(id)                                    |/v1/agents/{id}|
|.billing_reports, .billing_report                      |/v1/billing_reports/{id}|
|.incident_reports, .incident_report(id)                |/v1/incident_reports/{id}|
|.remediations(report_id), .remediation(report_id, id)  |/v1incident_reports/{report_id}/remediations/{id}|
|.organizations, .organization(id)                      |/v1/organizations/{id}|
|.reports, .report(id)                                  |/v1/reports/{id}|
|.signals, .signal(id)                                  |/v1/signals/{id}|

## Contributing

Bug reports and pull requests are welcome on [GitHub](https://github.com/jancotanis/huntress).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
