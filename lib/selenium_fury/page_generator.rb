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
module PageGenerator

  # @param html_element [String] a html element that could contain a id, name, or title.
  def get_name_and_value(html_element)
    if html_element.get_attribute("id") != nil
      attribute_name = html_element.get_attribute("id")
      attribute_value = html_element.get_attribute("id")
    elsif html_element.get_attribute("name") != nil
      attribute_name = html_element.get_attribute("name")
      attribute_value = html_element.get_attribute("name")
    elsif  html_element.get_attribute("title") != nil
      attribute_name = html_element.get_attribute("title")
      attribute_value = html_element.get_attribute("title")
    end
    return attribute_name, attribute_value
  end

# @param [Hash] opts the opts to use with a custom generator.
# @option opts [String] :locator_type css or xpath
# @option opts [String] :locator the html id,name, or title to be used as a selenium locator
# @option opts [String] :html html from the page under test
# @return [Hash] a list of variable names and locator values that can be used in a test
  def generate_instance_variables_from_html(opts)
    if opts.kind_of?(Hash)
      @html = opts[:html]
      @locator_type = opts[:locator_type]
      @locator = opts[:locator]
    end
    doc = Nokogiri::HTML(@html)
    html_elements = {}
    if (@locator_type=="css")
      doc.css(@locator).each do |html_element|
        attribute_name, attribute_value = get_name_and_value(html_element)
        if !attribute_name.nil?
          attribute_name.gsub!('input-', '')
          attribute_name.gsub!('select-', '')
          attribute_name.gsub!(/([A-Z]+)/, '_\1')
          attribute_name.gsub!('\\', '')
          attribute_name.gsub!(' ', '_')
          attribute_name.gsub!('.', '_')
          attribute_name.gsub!('-', '_')
          attribute_name.gsub!('__', '_')
          attribute_name = attribute_name.to_s.downcase
          puts "@#{attribute_name} = \"#{attribute_value}\"" if $debug
          html_elements[attribute_name]= attribute_value
        end
      end
    end
    return html_elements
  end

    # Print the ruby class using the html elements we found from the page.
    # @param page_elements_types [Array,Hash] an array of hashes for each type of found html element.
  def merge_and_print_elements(page_elements_types)
    html_elements={}
    page_elements_types.each do |element_type|
      html_elements.merge!(element_type)
    end
    $stdout.puts "found (#{html_elements.length} elements)"
    $stdout.puts "class YourPageFile"
    $stdout.puts "\tdef initialize *browser\n\t\t@browser = *browser"
    html_elements.keys.sort.each do |key|
      $stdout.puts "\t\t@#{key} = \"#{html_elements[key]}\""
    end
    $stdout.puts "\tend"
    count=1
    html_elements.keys.sort.each do |key|
      if count == 1
        $stdout.print "\tattr_accessor :browser, "
      end
      if count % 5 == 0
        $stdout.print "\n\t"
      end
      if count != html_elements.length
        $stdout.print ":#{key}, "
      else
        $stdout.print ":#{key}"
      end
      count = count + 1
    end
    $stdout.puts "\n\nend"

  end


  def get_source_and_print_elements(browser)
    html =browser.get_html_source
    return print_elements(html)
  end

    # @param html [String] html source from your page
    # @return [Hash,Array] an array of hashes for each type of found html element.
  def print_elements(html)
    html_elements_select=generate_instance_variables_from_html(:html =>html, :locator_type => "css", :locator => "select")
    html_elements_text_area=generate_instance_variables_from_html(:html =>html, :locator_type => "css", :locator => "textarea")
    html_elements_form = generate_instance_variables_from_html(:html =>html, :locator_type => "css", :locator => "form")
    html_elements_buttons = generate_instance_variables_from_html(:html =>html, :locator_type => "css", :locator => "input[type='button']")
    html_elements_file = generate_instance_variables_from_html(:html =>html, :locator_type => "css", :locator => "input[type='file']")
    html_elements_check_boxes = generate_instance_variables_from_html(:html =>html, :locator_type => "css", :locator => "input[type='checkbox']")
    html_elements_password = generate_instance_variables_from_html(:html =>html, :locator_type => "css", :locator => "input[type='password']")
    html_elements_radio = generate_instance_variables_from_html(:html =>html, :locator_type => "css", :locator => "input[type='radio']")
    html_elements_reset = generate_instance_variables_from_html(:html =>html, :locator_type => "css", :locator => "input[type='reset']")
    html_elements_image = generate_instance_variables_from_html(:html =>html, :locator_type => "css", :locator => "input[type='image']")
    html_elements_submit = generate_instance_variables_from_html(:html =>html, :locator_type => "css", :locator => "input[type='submit']")
    html_elements_text = generate_instance_variables_from_html(:html =>html, :locator_type => "css", :locator => "input[type='text']")

    elements = [html_elements_check_boxes, html_elements_select, html_elements_text, html_elements_buttons, html_elements_file,
                html_elements_password, html_elements_text_area, html_elements_image, html_elements_radio, html_elements_reset,
                html_elements_form, html_elements_submit]
    merge_and_print_elements(elements)
    return elements
  end


end