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
        # This module defines different types of waiting that an element might want to perform
        module WaitElementHelper
          def wait_for(opts={}, &condition)
            opts[:timeout] ||= @wait
            opts[:message] ||= ''
            Selenium::WebDriver::Wait.new(opts).until { condition.call }
          end

          def wait_present(timeout=@wait)
            wait_for(timeout: timeout, message: "Element at #{location} is not present") { present? }
          end

          def wait_not_present(timeout=@wait)
            wait_for(timeout: timeout, message: "Element at #{location} is still present") { !present? }
          end

          def wait_visible(timeout=@wait)
            wait_present(timeout)
            wait_visible!(timeout)
          end

          # Raises error if not present
          def wait_visible!(timeout=@wait)
            wait_for(timeout: timeout, message: "Element at #{location} is not visible") { visible? }
          end

          def wait_not_visible(timeout=@wait)
            wait_for(timeout: timeout, message: "Element at #{location} is still visible") { !present? || !visible? }
          end

          # Raises error if not present
          def wait_not_visible!(timeout=@wait)
            wait_for(timeout: timeout, message: "Element at #{location} is still visible") { !visible? }
          end
        end # WaitElementHelper
      end # ElementHelpers
    end # ElementTypes
  end # PageObject
end # SeleniumFury

