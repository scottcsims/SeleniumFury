require 'rubygems'
require 'bundler'
Bundler.setup
require "selenium_fury"
require "faker"
require "rspec"

require "test_page/test_page_custom_generator_configuration"
require "test_page/test_page_rc"

TEST_PAGE_URL="file://"+File.dirname(__FILE__) + "/test_page/test_page.html"
include SeleniumFury::SeleniumWebDriver::CreateSeleniumWebDriver
include SeleniumFury::SeleniumClient::CreateSeleniumClientDriver

RSpec.configure do |config|
  config.before(:each) do
    # because we use get_page_object in some of our tests, there's no guarantee that class is loaded at the
    # beginning of each test.  checkout massive comment in page_object_spec for more details.
    load "test_page/test_page.rb"
  end
  config.after(:each) do
    browser.close_current_browser_session unless(browser.nil? || browser.session_id.nil?)
    driver.quit unless driver.nil?
  end
end
