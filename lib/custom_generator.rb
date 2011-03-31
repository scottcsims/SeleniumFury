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
require File.dirname(__FILE__) + "/page_generator"
require 'nokogiri'
module CustomGenerator
  include PageGenerator
  def custom_generator(options)
    custom_configuration = options[:custom_configuration]
    browser = options[:browser]
    if !browser.nil?
      html = browser.get_html_source
    else
      html = options[:html]
    end
    doc = Nokogiri::HTML(html)
    html_menu_elements ={}
    doc.css(custom_configuration.selector).each do |nokogiri_element|
      custom_configuration.nokogiri_element = nokogiri_element
      puts "Html element is #{nokogiri_element}" if $DEBUG
      generated_name = clean_attribute_name(custom_configuration.name)
      puts "generated name is #{generated_name}" if $DEBUG
      generated_value = custom_configuration.value
      puts "generated value is #{generated_value}" if $DEBUG
      puts "@#{generated_name} = \"#{generated_value}\"" if $DEBUG
      html_menu_elements[generated_name]= generated_value
    end
    merge_and_print_elements [html_menu_elements]
    return html_menu_elements
  end

  def clean_attribute_name(attribute_name)
    attribute_name.gsub!('input-', '')
    attribute_name.gsub!('select-', '')
    attribute_name.gsub!(/([A-Z]+)/, '_\1')
    attribute_name.gsub!('\\', '')
    attribute_name.gsub!(' ', '_')
    attribute_name.gsub!('.', '_')
    attribute_name.gsub!('-', '_')
    attribute_name.gsub!('__', '_')
    attribute_name.gsub!(/^_/, '')
    attribute_name = attribute_name.to_s.downcase
    return attribute_name
  end
end
