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
    class PageParser
      def initialize (html_source)
        @html_source = html_source
        @nokogiri_selectors= ["select",
                              "textarea",
                              "form",
                              "input",
                              "input[type='button']",
                              "input[type='file']",
                              "input[type='checkbox']",
                              "input[type='password']",
                              "input[type='radio']",
                              "input[type='reset']",
                              "input[type='image']",
                              "input[type='submit']",
                              "input[type='text']"]

      end

      attr_reader :browser, :nokogiri_selectors,:html_source

      def nokogiri_elements
        nokogiri_elements=[]
        doc = Nokogiri::HTML(html_source)
        nokogiri_selectors.each do |selector|
          doc.css(selector).each do |nokogiri_element|
            nokogiri_elements.push(nokogiri_element)
          end
        end
        return nokogiri_elements
      end
    end
end