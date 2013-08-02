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

# Create a fundamental object in Ruby defining what a PageObject should be.
module SeleniumFury
  module PageObject
    class PageObject

      class << self
        def elements
          @elements ||= []
        end

        # The class helper for creating an element
        #
        # @param element_sym [:Symbol]
        # @param element_hash [Hash]
        # @param opts [Hash
        # @return [Selenium::WebDriver::Element]
        def element(element_sym, element_hash, opts={})
          #@transient_elements ||= []
          # define a new method with the name of the symbol after locator that returns the value
          define_method(element_sym) do
            wait = Selenium::WebDriver::Wait.new(:timeout => 0.5) # seconds
            begin
              wait.until { @driver.find_element element_hash }
            rescue Selenium::WebDriver::Error::TimeOutError
              raise "Could not find element #{element_sym}"
            end
          end

          # keep a running track of all elements and transient elements
          elements << element_sym
          #@transient_elements << element_hash if opts[:transient]
        end

        # The class helper for creating an element_list
        #
        # @param element_sym [:Symbol]
        # @param element_hash [Hash]
        # @param opts [Hash]
        # @return [Selenium::WebDriver::Element]
        def element_list(element_sym, element_hash, opts={})
          define_method(element_sym) do
            wait = Selenium::WebDriver::Wait.new(timeout: 0.5)
            begin
              wait.until { !@driver.find_elements(element_hash).empty? }
              @driver.find_elements(element_hash)
            rescue Selenium::WebDriver::Error::TimeOutError
              raise "Could not find any elements like #{element_sym}"
            end
          end
        end


        # @return [PageObject]
        def page(page_sym, page_class)
          define_method(page_sym) do
            raise "#{page_class.to_s} does not inherit from PageObject" unless page_class.superclass == PageObject::PageObject
            page_class.new(@driver)
          end
        end

        element_types = Dir.entries(File.expand_path('../element_types', __FILE__)).select {|f| f.match(/_element.rb$/) }
        element_types.each do |file|
          method_name = file[0..-4]
          define_method(method_name) do |element_sym, locator, opt={} |
            class_name = Object.const_get("ElementTypes::#{ActiveSupport::Inflector.classify(method_name)}")
            define_method(element_sym) do
              class_name.new(locator, @driver, opt)
            end
            elements << element_sym unless elements.include? element_sym
          end
        end
      end # class << self

      attr_accessor :driver

      def initialize driver = nil
        @driver = driver
      end
    end # PageObject
  end # PageObject
end # SeleniumFury
