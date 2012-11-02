$:.unshift(File.dirname(__FILE__) + '/../../lib')
require 'rubygems'
require 'bundler'

require 'selenium_fury'


require_relative "../../spec/test_page/test_page_custom_generator_configuration"

TEST_PAGE_URL="file://"+ File.expand_path(File.dirname(__FILE__) + "/../../spec/test_page/test_page.html")
include SeleniumFury::SeleniumWebDriver::CreateSeleniumWebDriver
