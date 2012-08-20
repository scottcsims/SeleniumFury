#/* Copyright (c) 2010 HomeAway, Inc.
# * All rights reserved.  http://www.homeaway.com
# *
# * Licensed under the Apache License, Version 2.0 (the "License");
# * you may not use this file except in compliance with the License.
# * You may obtain a copy of the License at
# *
# *      http://www.apache.org/licenses/LICENSE-2.0
# *
# * Unless required by applicable law or agreed to in writing, software
# * distributed under the License is distributed on an "AS IS" BASIS,
# * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# * See the License for the specific language governing permissions and
# * limitations under the License.
# */

require 'rubygems'
require 'bundler'

require "selenium-webdriver"
require "selenium-client"
require 'nokogiri'

require "selenium_fury/selenium_client/page_generator"
require "selenium_fury/selenium_client/custom_generator"
require "selenium_fury/selenium_client/page_validator"
require "selenium_fury/selenium_client/create_selenium_client_driver"
require "selenium_fury/selenium_client/locator_finder"
require "selenium_fury/common/page_parser"
require "selenium_fury/common/selenium_api_chooser"
require "selenium_fury/selenium_web_driver/create_selenium_web_driver"
require "selenium_fury/selenium_web_driver/element_finder"
require "selenium_fury/selenium_web_driver/page_object_components"
require "selenium_fury/selenium_web_driver/page_object"
require "selenium_fury/selenium_web_driver/page_generator"
require "selenium_fury/selenium_web_driver/page_validator"

include SeleniumFury::SeleniumClient::CustomGenerator
include SeleniumFury::SeleniumClient::PageGenerator
include SeleniumFury::SeleniumClient::PageValidator

include SeleniumFury::SeleniumWebDriver::PageGenerator
include SeleniumFury::SeleniumWebDriver::PageValidator

include SeleniumFury::SeleniumApiChooser
