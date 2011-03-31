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

  def get_name_and_value(html_element)
    if html_element.get_attribute("id") != nil
      attribute_name =  html_element.get_attribute("id")
      attribute_value = html_element.get_attribute("id")
    elsif html_element.get_attribute("name") != nil
      attribute_name =  html_element.get_attribute("name")
      attribute_value = html_element.get_attribute("name")
    elsif  html_element.get_attribute("title") != nil
      attribute_name =  html_element.get_attribute("title")
      attribute_value = html_element.get_attribute("title")
    end
    return attribute_name, attribute_value
  end

  def generate_instance_variables_from_html(options)
    if options.kind_of?(Hash)
      @html = options[:html]
      @locator_type = options[:locator_type]
      @locator = options[:locator]
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

  def merge_and_print_elements(page_elements_types)
    html_elements={}
    page_elements_types.each do |element_type|
      html_elements.merge!(element_type)
    end
    puts "found (#{html_elements.length} elements)"
    puts "class YourPageFile"
    puts "\tdef initialize *browser\n\t\t@browser = *browser"
    html_elements.keys.sort.each do |key|
      puts "\t\t@#{key} = \"#{html_elements[key]}\""
    end
    puts "\tend"
    count=1
    html_elements.keys.sort.each do |key|
      if count == 1
        print "\tattr_accessor :browser, "
      end
      if count % 5 == 0
        print "\n\t"
      end
      if count != html_elements.length
        print ":#{key}, "
      else
        print ":#{key}"
      end
      count = count + 1
    end
    puts "\n\nend"
  end

  def get_source_and_print_elements(browser)
    html =browser.get_html_source
    print_elements(html)
  end
  def print_elements(html)
    html_elements_select=generate_instance_variables_from_html(:html =>html, :locator_type => "css", :locator => "select")
    html_elements_text_area=generate_instance_variables_from_html(:html =>html, :locator_type => "css", :locator => "textarea")
    html_elements_form = generate_instance_variables_from_html(:html =>html, :locator_type => "css", :locator => "form")
    html_elements_check_boxes = generate_instance_variables_from_html(:html =>html, :locator_type => "css", :locator => "input[type='checkbox']")
    html_elements_image = generate_instance_variables_from_html(:html =>html, :locator_type => "css", :locator => "input[type='image']")
    html_elements_radio = generate_instance_variables_from_html(:html =>html, :locator_type => "css", :locator => "input[type='radio']")
    html_elements_text = generate_instance_variables_from_html(:html =>html, :locator_type => "css", :locator => "input[type='text']")
    html_elements_submit = generate_instance_variables_from_html(:html =>html, :locator_type => "css", :locator => "input[type='submit']")
    merge_and_print_elements([html_elements_check_boxes, html_elements_select, html_elements_text,
                              html_elements_text_area, html_elements_image, html_elements_radio, html_elements_form,html_elements_submit])
  end


end