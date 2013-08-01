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
  module PageObject
    module PageObjectGenerator
      class << self
        # @return [String]
        # @param page_object_attributes [Hash]
        def print_selenium_web_driver_page_object(page_object_attributes, class_name='YourPageFile')
          result = ""
          result += "found (#{page_object_attributes.length} elements)\n"
          result += "class #{class_name} < PageObject\n"
          page_object_attributes.keys.sort.each do |attribute_name|
            result += "  element :#{attribute_name}, {:#{page_object_attributes[attribute_name].keys[0]} => \"#{page_object_attributes[attribute_name].values[0]}\"}\n"
          end
          result += "end"
          $stdout.puts result
          result
        end

        # @param page_object_attributes [Hash]
        # @param class_name [String]
        # @return [PageObject]
        def selenium_web_driver_page_object(driver, page_object_attributes, class_name)
          klass = Class.new(PageObject::PageObject) {
            page_object_attributes.keys.sort.each do |attribute_name|
              element attribute_name.to_sym, {page_object_attributes[attribute_name].keys[0] => page_object_attributes[attribute_name].values[0]}
            end
          }
          print_selenium_web_driver_page_object page_object_attributes, class_name
          Object.const_set(class_name, klass).new(driver)
        end

        # @param driver [Selenium::WebDriver::Driver]
        # @return [String]
        def web_driver_generate(driver)
          html =driver.page_source
          nokogiri_elements = SeleniumFury::PageParser.new(html).nokogiri_elements
          raise "The generator did not find nokogiri elements" unless nokogiri_elements
          page_object_attributes = ElementFinder.new(nokogiri_elements).web_driver_page_object_attributes
          raise "The generator did not find page object attributes" if page_object_attributes.empty?
          print_selenium_web_driver_page_object page_object_attributes
        end

        # @param driver [Selenium::WebDriver::Driver]
        # @return [String]
        def generate(driver)
          web_driver_generate(driver)
        end

        # @param driver [Selenium::WebDriver::Driver]
        # @param class_name [string]
        # @return [PageObject]
        def get_page_object(driver, class_name)
          html = driver.page_source
          nokogiri_elements = SeleniumFury::PageParser.new(html).nokogiri_elements
          raise "The generator did not find nokogiri elements" unless nokogiri_elements
          page_object_attributes = ElementFinder.new(nokogiri_elements).web_driver_page_object_attributes
          raise "The generator did not find page object attributes" if page_object_attributes.empty?
          selenium_web_driver_page_object(driver, page_object_attributes, class_name)
        end
      end # class << self

      class ElementFinder
        def initialize (nokogiri_elements)
          @nokogiri_elements=nokogiri_elements
          @valid_locators=['id', 'class', 'name']
        end

        attr_reader :nokogiri_elements, :valid_locators

        def find_elements
          locators=[]
          nokogiri_elements.each do |nokogiri_element|
            valid_locators.each do |valid_locator|
              if nokogiri_element.get_attribute(valid_locator) != nil
                locators.push({valid_locator.to_sym => nokogiri_element.get_attribute(valid_locator)})
                break
              end
            end
          end
          return locators
        end

        def web_driver_page_object_attributes
          locators=find_elements
          generated_attributes ={}
          locators.each do |locator|
            cleaned_name=clean_attribute_name(locator.values[0])
            generated_attributes[cleaned_name] = locator
          end
          return generated_attributes
        end

        def clean_attribute_name name
          if !name.nil?
            find_and_replace_patterns = [[/([A-Z]+)/, '_\1'],
                                         ['input-', ''],
                                         ['select-', ''],
                                         ['\\', ''],
                                         [' ', '_'],
                                         ['.', '_'],
                                         ['-', '_'],
                                         ['__', '_']
            ]
            find_and_replace_patterns.each do |pattern|
              name=name.gsub(pattern[0], pattern[1])
            end
            name=name.to_s.downcase
          end
          return name
        end
      end # ElementFinder
    end # PageGenerator
  end # PageObject
end # SeleniumFury
