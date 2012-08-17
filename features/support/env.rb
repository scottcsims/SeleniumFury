$:.unshift(File.dirname(__FILE__) + '/../../lib')
$:.unshift(File.dirname(__FILE__))
require 'rubygems'
require 'bundler/setup'

require File.expand_path(File.dirname(__FILE__) + "/../../lib/selenium_fury")

require 'rspec'

require File.expand_path(File.dirname(__FILE__) + "/../../spec/test_page/test_page_rc")
require File.expand_path(File.dirname(__FILE__) + "/../../spec/test_page/test_page_custom_generator_configuration")

TEST_PAGE_URL="file:///"+ File.expand_path(File.dirname(__FILE__) + "/../../spec/test_page/test_page.html")
include SeleniumFury::SeleniumWebDriver::CreateSeleniumWebDriver
include SeleniumFury::SeleniumClient::CreateSeleniumClientDriver
