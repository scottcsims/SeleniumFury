require 'rubygems'
require 'bundler'

require 'selenium_fury'

require 'test_page/test_page_custom_generator_configuration'
require 'test_page/test_page.rb'

TEST_PAGE_URL='file://' + File.dirname(__FILE__) + '/test_page/test_page.html'
include SeleniumFury::SeleniumWebDriver::CreateSeleniumWebDriver

RSpec.configure do |config|
  config.after(:each) do
    driver.quit unless driver.nil?
  end
end
