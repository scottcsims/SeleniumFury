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
    module PageGenerator

      # @return [String]
      # @param html_elements [Hash]
      def print_page_object(html_elements)
        result = ""
        result += "found (#{html_elements.length} elements)\n"
        result += "class YourPageFile\n"
        result += "\tdef initialize *browser\n\t\t@browser = *browser\n"
        html_elements.keys.sort.each do |key|
          result += "\t\t@#{key} = \"#{html_elements[key]}\"\n"
        end
        result += "\tend\n"
        count=1
        html_elements.keys.sort.each do |key|
          if count == 1
            result += "\tattr_accessor :browser, "
          end
          if count % 5 == 0
            result += "\n\t"
          end
          if count != html_elements.length
            result += ":#{key}, "
          else
            result += ":#{key}"
          end
          count = count + 1
        end
        result += "\n\nend"
        $stdout.puts result
        return result
      end


      def get_source_and_print_elements(browser)
        html =browser.get_html_source
        nokogiri_elements = SeleniumFury::PageParser.new(html).nokogiri_elements
        raise "The generator did not find nokogiri elements" unless nokogiri_elements
        page_object_attributes = SeleniumFury::SeleniumClient::LocatorFinder.new(nokogiri_elements).page_object_attributes
        raise "The generator did not find page object attributes" if page_object_attributes.empty?
        print_page_object page_object_attributes
        #return print_elements(html)
      end

      alias_method :generate, :get_source_and_print_elements

    end
  end
end