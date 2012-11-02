require 'rubygems'
require 'bundler'

require 'selenium_fury'

require "test_page/test_page_custom_generator_configuration"

TEST_PAGE_URL="file://"+File.dirname(__FILE__) + "/test_page/test_page.html"
include SeleniumFury::SeleniumWebDriver::CreateSeleniumWebDriver

RSpec.configure do |config|
  config.before(:each) do
    # because we use get_page_object in some of our tests, there's no guarantee that class is loaded at the
    # beginning of each test.  checkout massive comment in page_object_spec for more details.
    load "test_page/test_page.rb"
  end
  config.after(:each) do
    driver.quit unless driver.nil?
  end
end
