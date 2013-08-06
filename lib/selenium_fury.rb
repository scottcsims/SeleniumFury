#/* Copyright (c) 2010 HomeAway, Inc.
# * All rights reserved.  http://www.homeaway.com
# *
# * Licensed under the Apache License, Version 2.0 (the 'License');
# * you may not use this file except in compliance with the License.
# * You may obtain a copy of the License at
# *
# *      http://www.apache.org/licenses/LICENSE-2.0
# *
# * Unless required by applicable law or agreed to in writing, software
# * distributed under the License is distributed on an 'AS IS' BASIS,
# * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# * See the License for the specific language governing permissions and
# * limitations under the License.
# */
require 'selenium-webdriver'
require 'nokogiri'
require 'active_support/inflector/methods'

require 'selenium_fury/version'
require 'selenium_fury/monkey_patches/selenium/webdriver/common/timeouts'

gem_root = File.dirname(File.absolute_path(__FILE__)) + '/selenium_fury/'
# Common
Dir.glob(gem_root + 'common/*.rb', &method(:require))

# PageObject ElementType ElementHelpers
Dir.glob(gem_root + 'page_object/element_types/element_helpers/*.rb', &method(:require))

# PageObject ElementTypes
Dir.glob(gem_root + 'page_object/element_types/*.rb', &method(:require))

# PageObject
Dir.glob(gem_root + 'page_object/*.rb', &method(:require))

include SeleniumFury::PageObject
include SeleniumFury::Utilities