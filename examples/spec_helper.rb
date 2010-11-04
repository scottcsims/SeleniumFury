require 'rubygems'
gem "rspec", "=1.1.12"
require "spec"
gem "selenium-client", ">=1.2.18"
require "selenium/client"
require File.dirname(__FILE__) + "/create_browser_driver"
require 'nokogiri'