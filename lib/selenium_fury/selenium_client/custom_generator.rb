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
  module SeleniumClient
    module CustomGenerator
# Use a custom configuration object to define a location strategy for a locators name and value
# @param [Hash] options the options to use with a custom generator.
# @option opts [CustomConfiguration] :custom_configuration a class that explains how to parse the page
# @option opts [String] :browser the selenium driver
# @option opts [String] :html html from the page under test
      def custom_generator(options)
        custom_configuration = options[:custom_configuration]
        browser = options[:browser]
        if !browser.nil?
          html = browser.get_html_source
        else
          html = options[:html]
        end
        doc = Nokogiri::HTML(html)
        html_menu_elements ={}
        doc.css(custom_configuration.selector).each do |nokogiri_element|
          custom_configuration.nokogiri_element = nokogiri_element
          puts "Html element is #{nokogiri_element}" if $DEBUG
          generated_name = clean_attribute_name(custom_configuration.name)
          puts "generated name is #{generated_name}" if $DEBUG
          generated_value = custom_configuration.value
          puts "generated value is #{generated_value}" if $DEBUG
          puts "@#{generated_name} = \"#{generated_value}\"" if $DEBUG
          html_menu_elements[generated_name]= generated_value
        end
        return print_page_object(html_menu_elements)
      end

      # Parse the html attribute to a ruby variable
      # @return [String]
      # @param attribute_name [String] the html id,name, or title of an element
      def clean_attribute_name(attribute_name)
        attribute_name.gsub!('input-', '')
        attribute_name.gsub!('select-', '')
        attribute_name.gsub!(/([A-Z]+)/, '_\1')
        attribute_name.gsub!('\\', '')
        attribute_name.gsub!(' ', '_')
        attribute_name.gsub!('.', '_')
        attribute_name.gsub!('-', '_')
        attribute_name.gsub!('__', '_')
        attribute_name.gsub!(/^_/, '')
        attribute_name = attribute_name.to_s.downcase
        return attribute_name
      end
    end
  end
end