require 'rubygems'
gem "rspec", "=1.1.12"
require "spec"
gem "selenium-client", ">=1.2.18"
require "selenium/client"
require 'nokogiri'

require File.dirname(__FILE__) + "/../lib/custom_generator"
require File.dirname(__FILE__) + "/../lib/page_generator"
require File.dirname(__FILE__) + "/../lib/page_validator"
require File.dirname(__FILE__) + "/advanced_search_custom_generator_configuration"
require File.dirname(__FILE__) + "/create_browser_driver"
require File.dirname(__FILE__) + "/advanced_search"

include CustomGenerator
include PageGenerator
include PageValidator
include CreateBrowserDriver

