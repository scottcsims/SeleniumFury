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
module SeleniumFury
  module SeleniumWebDriver
    module PageGenerator

      # @return [String]
      # @param page_object_attributes [Hash]
      def print_selenium_web_driver_page_object(page_object_attributes,class_name='YourPageFile')
        result = ""
        result += "found (#{page_object_attributes.length} elements)\n"
        result += "class #{class_name} < PageObject\n"
        page_object_attributes.keys.sort.each do |attribute_name|
          result += "\t\telement :#{attribute_name}, {#{page_object_attributes[attribute_name].keys[0]}: \"#{page_object_attributes[attribute_name].values[0]}\"}\n"
        end
        result += "\n\nend"
        $stdout.puts result
        return result
      end

# @param page_object_attributes [Hash]
# @param class_name [String]
# @return [PageObject]
      def selenium_web_driver_page_object(page_object_attributes, class_name)
        klass = Class.new(PageObject) {
          page_object_attributes.keys.sort.each do |attribute_name|
            element attribute_name.to_sym, {page_object_attributes[attribute_name].keys[0] => page_object_attributes[attribute_name].values[0]}
          end
        }
        print_selenium_web_driver_page_object page_object_attributes,class_name
        return Object.const_set(class_name, klass).new(driver)

      end

# @param driver [Selenium::WebDriver::Driver]
# @return [String]
      def web_driver_generate(driver)
        html =driver.page_source
        nokogiri_elements = SeleniumFury::PageParser.new(html).nokogiri_elements
        raise "The generator did not find nokogiri elements" unless nokogiri_elements
        page_object_attributes = SeleniumFury::SeleniumWebDriver::ElementFinder.new(nokogiri_elements).web_driver_page_object_attributes
        raise "The generator did not find page object attributes" if page_object_attributes.empty?
        print_selenium_web_driver_page_object page_object_attributes
      end

# @param driver [Selenium::WebDriver::Driver]
# @param class_name [string]
# @return [PageObject]
      def get_page_object(driver, class_name)
        html =driver.page_source
        nokogiri_elements = SeleniumFury::PageParser.new(html).nokogiri_elements
        raise "The generator did not find nokogiri elements" unless nokogiri_elements
        page_object_attributes = SeleniumFury::SeleniumWebDriver::ElementFinder.new(nokogiri_elements).web_driver_page_object_attributes
        raise "The generator did not find page object attributes" if page_object_attributes.empty?
        selenium_web_driver_page_object(page_object_attributes, class_name)
      end
    end
  end
end
