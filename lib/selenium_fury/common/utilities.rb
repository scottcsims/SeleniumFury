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
  module Utilities

    # Initialize our global to be a hash.
    $driver = {}

    #@return [Selenium::WebDriver::Driver]
    def driver(tag=:standard)
      $driver[tag]
    end

    def drivers
      $driver
    end

    # @param url [string]
    # @return [Selenium::WebDriver::Driver]
    def start_web_driver url=nil, tag=:standard
      raise 'Cannot open a second browser with the same key.' if $driver.has_key?(tag)
      $driver[tag] = Selenium::WebDriver.for :chrome
      $driver[tag].navigate.to url unless url.nil?
      $driver[tag]
    end

    def stop_web_driver(tag=:standard)
      begin
        driver(tag).quit unless driver(tag).nil?
        $driver.delete(tag)
      rescue => e
        if /(CLIENT_STOPPED_SESSION|Errno::ECONNREFUSED)/ === e.inspect
          puts "Ignoring #{e.class} because it was thrown by Driver#quit being called on an already-closed driver"
        else
          raise e
        end
      end
    end

    def stop_all_web_drivers
      $driver.keys.each { |tag| stop_web_driver(tag) }
    end

  end # Utilities
end # SeleniumFury
