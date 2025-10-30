# frozen_string_literal: true

require 'simplecov'
SimpleCov.start

$LOAD_PATH.unshift File.expand_path('../../wrapi/lib', __dir__)
$LOAD_PATH.unshift File.expand_path('../lib', __dir__)
require 'dotenv'
require 'minitest/autorun'
require 'minitest/spec'

Dotenv.load

require 'huntress'
