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
        def element(element_sym, element_hash, opts={})
          #@transient_elements ||= []
          # define a new method with the name of the symbol after locator that returns the value
          send :define_method, element_sym do
            wait = Selenium::WebDriver::Wait.new(:timeout => 0.5) # seconds
            begin
              wait.until { driver.find_element element_hash }
            rescue Selenium::WebDriver::Error::TimeOutError
              raise "Could not find element #{element_sym}"
            end
          end

          # keep a running track of all elements and transient elements
          elements << element_sym
          #@transient_elements << element_hash if opts[:transient]
        end

        def element_list(element_sym, element_hash, opts={})
          send :define_method, element_sym do
            wait = Selenium::WebDriver::Wait.new(timeout: 0.5)
            begin
              wait.until { !driver.find_elements(element_hash).empty? }
              driver.find_elements(element_hash)
            rescue Selenium::WebDriver::Error::TimeOutError
              raise "Could not find any elements like #{element_sym}"
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


        def generic_element(element_sym, locator, opt={})
          define_method(element_sym) do
            GenericElement.new(locator, driver, opt.merge(method: element_sym))
          end
          elements << element_sym unless elements.include? element_sym
        end

        def text_element(element_sym, locator, opt={})
          define_method(element_sym) do
            TextElement.new(locator, driver, opt.merge(method: element_sym))
          end
          elements << element_sym unless elements.include? element_sym
        end

        def link_element(element_sym, locator, opt={})
          define_method(element_sym) do
            LinkElement.new(locator, driver, opt.merge(method: element_sym))
          end
          elements << element_sym unless elements.include? element_sym
        end

        def text_input_element(element_sym, locator, opt={})
          define_method(element_sym) do
            TextInputElement.new(locator, driver, opt.merge(method: element_sym))
          end
          elements << element_sym unless elements.include? element_sym
        end

        def drop_down_element(element_sym, locator, opt={})
          define_method(element_sym) do
            DropDownElement.new(locator, driver, opt.merge(method: element_sym))
          end
          elements << element_sym unless elements.include? element_sym
        end

        def submit_element(element_sym, locator, opt={})
          define_method(element_sym) do
            SubmitElement.new(locator, driver, opt.merge(method: element_sym))
          end
          elements << element_sym unless elements.include? element_sym
        end

        def checkbox_element(element_sym, locator, opt={})
          define_method(element_sym) do
            CheckboxElement.new(locator, driver, opt.merge(method: element_sym))
          end
          elements << element_sym unless elements.include? element_sym
        end

        def image_element(element_sym, locator, opt={})
          define_method(element_sym) do
            ImageElement.new(locator, driver, opt.merge(method: element_sym))
          end
          elements << element_sym unless elements.include? element_sym
        end

        def radio_button_element(element_sym, locator, opt={})
          define_method(element_sym) do
            RadioButtonElement.new(locator, driver, opt.merge(method: element_sym))
          end
          elements << element_sym unless elements.include? element_sym
        end
      end
    end
  end
end
