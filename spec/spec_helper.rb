$:.unshift(File.dirname(__FILE__) + '/../lib')
$:.unshift(File.dirname(__FILE__))

require 'rubygems'
require 'bundler'
Bundler.setup
require "selenium_fury"
require "advanced_search_custom_generator_configuration"
require "advanced_search"


RSpec.configure do |config|
  config.after(:each) do
    browser.close_current_browser_session if defined?(browser) && !browser.nil?
  end
end