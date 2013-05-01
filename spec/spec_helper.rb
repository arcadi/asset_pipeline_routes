ENV["RAILS_ENV"] ||= 'test'
require 'simplecov'
require 'simplecov-rcov'

SimpleCov.formatter = SimpleCov::Formatter::RcovFormatter
SimpleCov.start 'rails' do
   add_filter "/.bundle/"
end

$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))

FIXTURE_ROOT = File.expand_path(File.join(File.dirname(__FILE__), "fixtures"))

require 'asset_pipeline_routes'
require 'rspec'
require 'ostruct'