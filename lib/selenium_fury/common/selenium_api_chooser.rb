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
  module SeleniumApiChooser
    def generate(selenium_api_object)
      if selenium_api_object.class == Selenium::Client::Driver
        return get_source_and_print_elements(selenium_api_object)
      end
      if selenium_api_object.class == Selenium::WebDriver::Driver
        return web_driver_generate(selenium_api_object)
      end
    end

    # @return [Array] validated page elements
    # @param [PageObject] page_object
    # @param [string] live_url
    def validate(page_object, live_url = nil)
      if defined?(browser)
        unless browser.nil?
          return check_page_file_class(page_object, *live_url)
        end
      end
      unless driver.nil?
        return web_driver_validate(page_object)
      end
    end

  end
end