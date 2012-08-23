class TestPageCustomGeneratorConfiguration
  def initialize(options={})
    @selector ="a"
    @nokogiri_element=options[:nokogiri_element]
  end

  attr_accessor :selector, :nokogiri_element

  def name
    return nokogiri_element.text
  end

  def value
    return nokogiri_element.get_attribute("id")
  end
end