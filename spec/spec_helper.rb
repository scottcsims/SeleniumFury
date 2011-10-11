$:.unshift(File.dirname(__FILE__) + '/../lib')
$:.unshift(File.dirname(__FILE__))

require 'rubygems'
require 'bundler'
Bundler.setup
require "selenium_fury"
require "faker"
require "rspec"
require "selenium_client/advanced_search_custom_generator_configuration"
require "selenium_client/advanced_search"
require "selenium_web_driver/inquiry_side_bar"
require "selenium_web_driver/property_page"

RSpec.configure do |config|
  config.after(:each) do
    browser.close_current_browser_session if !browser.nil?
    driver.quit if !driver.nil?
  end
end