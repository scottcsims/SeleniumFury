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
    module PageObjectComponents
      # when this module is loaded, add on the ClassMethods module
      def self.included(base)
        base.extend ClassMethods
      end

      module ClassMethods
        
        def elements
          @elements ||= []
        end

        # this is a method on the class now
        # @method element(element_sym, element_hash, opts={})
        # @param element_sym [:Symbol]
        # @param element_hash [Hash]
        # @param opts [Hash]
        # @return [Selenium::WebDriver::Element]
        def element(element_sym, element_hash, opts={timeout: 0.5})
          #@transient_elements ||= []
          # define a new method with the name of the symbol after locator that returns the value
          send :define_method, element_sym do
            wait = Selenium::WebDriver::Wait.new(timeout: opts[:timeout]) # seconds
            begin
              wait.until { driver.find_element element_hash }
            rescue Selenium::WebDriver::Error::TimeOutError
              raise "Could not find element #{element_sym} (Waited #{opts[:timeout]} seconds.)"
            end
          end

          # keep a running track of all elements and transient elements
          elements << element_sym
          #@transient_elements << element_hash if opts[:transient]
        end

        def element_list(element_sym, element_hash, opts={timeout: 0.5})
          send :define_method, element_sym do
            wait = Selenium::WebDriver::Wait.new(timeout: opts[:timeout])
            begin
              wait.until { !driver.find_elements(element_hash).empty? }
              driver.find_elements(element_hash)
            rescue Selenium::WebDriver::Error::TimeOutError
              raise "Could not find any elements like #{element_sym} (Waited #{opts[:timeout]} seconds.)"
            end
          end 
        end      

        # @return [PageObject]
        def page(page_sym, page_class)
          send :define_method, page_sym do
            raise "#{page_class.to_s} does not inherit from PageObject" unless page_class.superclass == PageObject
            page_class.new(driver)
          end
        end
      end
    end
  end
end