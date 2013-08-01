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
require 'selenium_fury/common/page_parser'
require 'selenium_fury/common/utilities'

# PageObject ElementType ElementHelpers
require 'selenium_fury/page_object/element_types/element_helpers/checkbox_element_helper'
require 'selenium_fury/page_object/element_types/element_helpers/drop_down_element_helper'
require 'selenium_fury/page_object/element_types/element_helpers/generic_element_helper'
require 'selenium_fury/page_object/element_types/element_helpers/image_element_helper'
require 'selenium_fury/page_object/element_types/element_helpers/link_element_helper'
require 'selenium_fury/page_object/element_types/element_helpers/selectable_element_helper'
require 'selenium_fury/page_object/element_types/element_helpers/text_input_element_helper'
require 'selenium_fury/page_object/element_types/element_helpers/wait_element_helper'

# PageObject ElementTypes
require 'selenium_fury/page_object/element_types/generic_element'
require 'selenium_fury/page_object/element_types/checkbox_element'
require 'selenium_fury/page_object/element_types/drop_down_element'
require 'selenium_fury/page_object/element_types/image_element'
require 'selenium_fury/page_object/element_types/link_element'
require 'selenium_fury/page_object/element_types/radio_button_element'
require 'selenium_fury/page_object/element_types/selectable_element'
require 'selenium_fury/page_object/element_types/submit_element'
require 'selenium_fury/page_object/element_types/text_element'
require 'selenium_fury/page_object/element_types/text_input_element'

# PageObject
require 'selenium_fury/page_object/page_object'

# PageObject Utilities
require 'selenium_fury/page_object/page_object_generator'
require 'selenium_fury/page_object/page_object_validator'

include SeleniumFury::PageObject