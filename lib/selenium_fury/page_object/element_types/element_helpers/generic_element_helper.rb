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
    module ElementTypes
      module ElementHelpers
        # Defines what we can do to all elements
        module GenericElementHelper
          def el
            raise "Locator at #{location} is not present" unless present?
            @driver.find_element(location)
          end

          def list
            (1..number_matching).map { |i| self.class.new({css: location[:css]+":nth-of-type(#{i})"}, @driver) }
          end

          def present?
            # Set implicit wait to zero so it doesn't wait that time each method call
            implicit_wait = driver.manage.timeouts.implicit_wait
            driver.manage.timeouts.implicit_wait = 0
            present = number_matching > 0
            driver.manage.timeouts.implicit_wait = implicit_wait
            present
          end

          def number_matching
            @driver.find_elements(location).size
          end

          # Raises error if not already present
          def visible?
            el.displayed?
          end

          def value
            el.attribute('value')
          end

          def move_to
            @driver.action.move_to(el).perform
          end

          def double_click
            @driver.action.double_click(el).perform
          end

          def double_click!
            el.click
          rescue Exception => e
            puts "Encountered #{e.class} trying to click element at #{self.location}"
          ensure
            el.click
          end

          # Use any methods from WebDriverElement not present
          def method_missing method_sym, *args
            if el.respond_to?(method_sym)
              el.send(method_sym, *args)
            else
              raise NoMethodError, "No such  method #{method_sym} for #{self.class}"
            end
          end
        end # GenericElementHelper
      end # ElementHelpers
    end # ElementTypes
  end # PageObject
end # SeleniumFury

