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
        # Defines what we can do to a drop down element
        module DropDownElementHelper
          def selected_option
            Selenium::WebDriver::Support::Select.new(el).first_selected_option.text
          end

          # how can be :text, :index, :value
          def select_option(how=nil, what=nil)
            raise "Locator at #{location} can not be interacted with" unless visible?
            el.click if how.nil?
            Selenium::WebDriver::Support::Select.new(el).select_by(how, what)
          end
        end # DropDownElementHelper
      end # ElementHelpers
    end # ElementTypes
  end # PageObject
end # SeleniumFury

