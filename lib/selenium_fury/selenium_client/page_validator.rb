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
    module PageValidator
      @found_missing_locators
      attr_accessor :found_missing_locators
      # @param page_file_class [Class] The page object class you want to test
      # @param live_url [String] the url of the page your testing
      def check_page_file_class(page_file_class, live_url = nil)
        raise "cannot access the selenium client driver" if browser.nil?
        missing_locators={}
        puts "Validating the #{page_file_class} class"
        #all initialize methods of page files should have *browser specified as the argument. This is an optional argument
        test_page = page_file_class.new(browser)
        raise "The test class is nil" if test_page.nil?
        #skip the open if we don't need to open the url again
        if live_url
          puts "Opening  #{browser.browser_url}/#{live_url}" #if $DEBUG
          browser.open live_url
        end

        #check for instance methods and execute.
        verify_instance_variables(test_page, missing_locators) if test_page.instance_variables.length > 0

        @found_missing_locators=missing_locators
        return print_missing_locators(missing_locators)
      end


      # @param missing_locators [Hash] locator name and values
      def print_missing_locators missing_locators
        puts "Missing locators are " if missing_locators != {}
        missing_locators.each_pair do |locator_name, locator_value|
          puts "     #{locator_name} =>  #{locator_value}"
        end
        raise "found missing locators" unless missing_locators.empty?
      end

      def attribute_name_filter locator_name
        #Add names of attributes to filter
        skip_words=["browser"]

        skip_words=skip_words+@known_missing_locators if !@known_missing_locators.nil?

        return skip_words.include?(locator_name)
      end

      # @param test_page [Object] an instantiated page object
      # @param missing_locators [Hash]
      def verify_instance_variables(test_page, missing_locators)
        #test_page.print_properties browser
        test_page.instance_variables.each do |locator_name|
          locator_name_string = locator_name.to_s
          #prepare the locator values
          locator_name_string.slice!(0)

          if attribute_name_filter(locator_name_string)
            puts "Skipping validation for #{locator_name}"
            next
          end

          # I don't understand where this would ever be true, but I'll leave it I guess?
          # next if (test_page.method(locator_name_string.to_sym).class.to_s != "String")
          puts "     Validating the #{locator_name} page element locator" #chomp the @ sign off of the method name.
          locator_value = test_page.method(locator_name_string.to_sym) # Create the reference to the get method of the instance variable
          begin
            browser.wait_for_element(locator_value.call, {:timeout_in_seconds => "5"})
          rescue
            puts "    -----------------------------------    Could not find '#{locator_name}'"
            missing_locators[locator_name_string]= locator_value.call
          end
        end
      end


    end
  end
end