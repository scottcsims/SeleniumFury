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
        # Defines what we can do to a selectable element
        module SelectableElementHelper
          def selected?
            el.selected?
          end

          # Raises error if not selectable
          def select!
            raise "Locator at #{location} is not visible" unless visible?
            begin
              el.click
            rescue
              raise "Locator at #{location} can not be interacted with" unless visible?
            end
            check_errors
          end

          def select
            wait_visible
            begin
              el.click
            rescue Exception => e
              retry_select(e)
            end
            check_errors
          end

          def retry_select(exception)
            raise "Locator at #{location} can not be interacted with - Failed with #{exception}"
          end

          # Overwrite in your project if desired
          def check_errors; end
        end # SelectableElementHelper
      end # ElementHelpers
    end # ElementTypes
  end # PageObject
end # SeleniumFury

