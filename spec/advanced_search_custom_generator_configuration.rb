class AdvancedSearchCustomGeneratorConfiguration
  def initialize(options={})
    @selector ="form#adv-search-form div.cb-box"
    @nokogiri_element=options[:nokogiri_element]
  end

  attr_accessor :selector, :nokogiri_element

  def name
    if !nokogiri_element.nil?
      return nokogiri_element.text
    else
      return @name
    end
  end

  def name
    return nokogiri_element.at_css("input[name=refinements]+label").text

  end


  def value
    return nokogiri_element.at_css("input").get_attribute("id")
  end


end