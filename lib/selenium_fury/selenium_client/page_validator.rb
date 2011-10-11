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
module PageValidator
  @found_missing_locators
  attr_accessor :found_missing_locators
# @param page_file_class [Class] The page object class you want to test
# @param live_url [String] the url of the page your testing
  def check_page_file_class(page_file_class, *live_url)
    missing_locators={}
    puts "Validating the #{page_file_class} class"
      #all initialize methods of page files should have *browser specified as the argument. This is an optional argument
    test_page = page_file_class.new(@browser)
    test_page.should_not be_nil
      #skip the open if we don't need to open the url agian
    if !live_url.empty?
      $stderr.puts "Opening  #{@browser.browser_url}/#{live_url}" if $DEBUG
      browser.open live_url
    end

      #check for class methods and execute.
    verify_class_variables(test_page, missing_locators) if test_page.public_methods(all=false).length > 0

      #check for instance methods and execute.
    verify_instance_variables(test_page, missing_locators) if test_page.instance_variables.length > 0
    @found_missing_locators=missing_locators
    print_missing_locators(missing_locators)
  end


    # @param missing_locators [Hash] locator name and values
  def print_missing_locators missing_locators
    puts "Missing locators are " if missing_locators != {}
    missing_locators.each_pair do |locator_name, locator_value|
      puts "     #{locator_name} =>  #{locator_value}"
    end
    missing_locators.should have(0).missing_locators
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
      #prepare the locator values
      locator_name.slice!(0)
      if attribute_name_filter(locator_name)
        puts "Skipping validation for #{locator_name}"
        next
      end
      next if (test_page.method(locator_name).call.class.to_s != "String")
      puts "     Validating the #{locator_name} page element locator" #chomp the @ sign off of the method name.
      locator_value = test_page.method(locator_name) # Create the reference to the get method of the instance variable
      begin
        browser.wait_for_element(locator_value.call, {:timeout_in_seconds => "5"})
      rescue
        puts "    -----------------------------------    Could not find #{locator_name}"
      end
      missing_locators[locator_name]= locator_value.call if !browser.element?(locator_value.call) # Use the value of the instance variable
    end
  end

    # @param test_page [Object] an instantiated page object
    # @param missing_locators [Hash]
  def verify_class_variables(test_page, missing_locators)
    test_page.public_methods(all=false).each do |locator_name|
      #Only operate with the set methods not the get methods
      next if (!locator_name.include?("="))

      locator_name.slice!(locator_name.length-1)

      if attribute_name_filter(locator_name)
        puts "Skipping validation for #{locator_name}"
        next
      end
      next if (test_page.method(locator_name).call.class.to_s != "String")
      puts "     Validating the #{locator_name} page element locator" #chomp the @ sign off of the method name.
      locator_value = test_page.method(locator_name) # Create the reference to the get method of the instance variable

        #Now validate the page
      begin
        browser.wait_for_element(locator_value.call, {:timeout_in_seconds => "5"})
      rescue
        puts "    -----------------------------------          Could not find #{locator_name}"
      end
      missing_locators[locator_name]= locator_value.call if !browser.element?(locator_value.call) # Use the value of the instance variable

    end
  end

  alias_method :validate, :check_page_file_class

end