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
module Selenium
  module WebDriver
    class Timeouts

      # A getter for implicit_wait
      # @return [Integer] the value that implicit_wait is set to
      def implicit_wait
        @implicit_wait ||= 0
      end

      # A setter for implicit_wait
      # @param seconds [Integer] the number of seconds we want to set implicit_wait to
      # @return []
      def implicit_wait=(seconds)
        @implicit_wait = seconds
        @bridge.setImplicitWaitTimeout Integer(@implicit_wait * 1000)
      end

    end # Timeouts
  end # WebDriver
end # Selenium
