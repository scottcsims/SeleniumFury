class PageParser

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
        attribute_name =  html_element.get_attribute("id")
        attribute_value = html_element.get_attribute("id")
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

    html_elements.keys.sort.each do |key|
      puts "@#{key} = \"#{html_elements[key]}\""
    end
    html_elements.keys.sort.each do |key|
      print ":#{key}, "
    end
  end

  def get_source_and_print_elements(browser)
    html =browser.get_html_source
    html_elements_select=generate_instance_variables_from_html(:html =>html, :locator_type => "css", :locator => "select")
    html_elements_text_area=generate_instance_variables_from_html(:html =>html, :locator_type => "css", :locator => "textarea")
    html_elements_form = generate_instance_variables_from_html(:html =>html, :locator_type => "css", :locator => "form")
    html_elements_check_boxes = generate_instance_variables_from_html(:html =>html, :locator_type => "css", :locator => "input[type='checkbox']")
    html_elements_image = generate_instance_variables_from_html(:html =>html, :locator_type => "css", :locator => "input[type='image']")
    html_elements_radio = generate_instance_variables_from_html(:html =>html, :locator_type => "css", :locator => "input[type='radio']")
    html_elements_text = generate_instance_variables_from_html(:html =>html, :locator_type => "css", :locator => "input[type='text']")
    merge_and_print_elements([html_elements_check_boxes, html_elements_select, html_elements_text,
                              html_elements_text_area, html_elements_image, html_elements_radio, html_elements_form])
  end


end