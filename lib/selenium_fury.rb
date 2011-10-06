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
Bundler.setup
require "selenium/webdriver"
require "selenium/client"
require 'nokogiri'

require "selenium_fury/page_generator"
require "selenium_fury/custom_generator"
require "selenium_fury/page_validator"
require "selenium_fury/create_browser_driver"

include CustomGenerator
include PageGenerator
include PageValidator
include CreateBrowserDriver
