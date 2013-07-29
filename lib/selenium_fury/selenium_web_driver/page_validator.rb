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
  module SeleniumWebDriver
    module PageValidator
      def web_driver_validate(page_class, validate_tags={})
        raise("Cannot find driver") if driver.nil?
        missing_elements=[]
        skipped_elements=[]
        puts "class #{page_class}"
        page_object=page_class.new(driver)
        raise "Could not find web driver elements in #{page_class}" if page_class.elements.nil?
        page_source = Nokogiri::HTML(@driver.page_source) if validate_tags.fetch(:verification_type, nil) == :nokogiri
        page_class.elements.each do |web_driver_element_name|
          puts "\tValidating #{web_driver_element_name}"
          begin
            element_obj = page_object.send(web_driver_element_name)
          rescue
            puts "\t\t\tCould not find #{web_driver_element_name}"
            missing_elements.push(web_driver_element_name)
          end
          next unless element_obj.respond_to? :validate?
          validate_element = case
                               when validate_tags[:validate_any] && validate_tags[:validate_all]
                                 raise "Can't use both :validate_any and :validate_all tags"
                               when !element_obj.validate?
                                 false # Already set to skip
                               when validate_tags[:validate_any] && element_obj.tags
                                 element_obj.tags.any? { |tag| validate_tags[:validate_any].include? tag }
                               when validate_tags[:validate_all] && element_obj.tags
                                 element_obj.tags.all? { |tag| validate_tags[:validate_all].include? tag }
                               else
                                 true
                             end
          if validate_element
            # Note - Using Nokogiri type requires valid CSS and no periods present in ID attributes to work
            if validate_tags.fetch(:verification_type, nil) == :nokogiri
              css_value = element_obj.location.invert.keys.first
              element_obj.location.keys.first == :id && css_value = "##{css_value.gsub('.', '\.')}"
              element_present = page_source.css(css_value).size >= 1
            else
              element_present = element_obj.present?
            end
            unless element_present
              puts "\t\t\tCould not find #{web_driver_element_name}"
              missing_elements.push(web_driver_element_name)
            end
          else
            skipped_elements.push(web_driver_element_name)
          end
        end
        if missing_elements.length > 0
          puts "Missing Elements:"
          missing_elements.each { |element| puts "\t#{element}" }
        end
        if skipped_elements.length > 0
          puts "Skipped Elements:"
          skipped_elements.each { |element| puts "\t#{element}" }
        end
        raise "Found Missing Elements: #{missing_elements.inspect}" if missing_elements.length > 0
      end

      def validate(page_class, validate_tags={})
        web_driver_validate(page_class, validate_tags)
      end
    end
  end
end
