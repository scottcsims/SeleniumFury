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
    module CreateSeleniumClientDriver

      # @return [Selenium::Client::Driver]
      def browser
        return @browser
      end

      # @param url [string]
      # @return [Selenium::Client::Driver]
      def create_selenium_driver(url)

        @browser = Selenium::Client::Driver.new(
            :host => ENV['HOST'] || "localhost",
            :port => 4444,
            :browser => ENV['SELENIUM_RC_BROWSER'] || "*firefox",
            :url => url,
            :timeout_in_second => 60)
      end
    end
  end
end