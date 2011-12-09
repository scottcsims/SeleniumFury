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
require "selenium_web_driver/advanced_search"

RSpec.configure do |config|
  config.after(:each) do
    browser.close_current_browser_session unless(browser.nil? || browser.session_id.nil?)
    driver.quit unless driver.nil?
  end
  config.include SeleniumFury::SeleniumClient::CreateSeleniumClientDriver
  config.include SeleniumFury::SeleniumWebDriver::CreateSeleniumWebDriver
end
