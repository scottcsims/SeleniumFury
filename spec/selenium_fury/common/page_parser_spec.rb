require 'spec_helper'

describe SeleniumFury::PageParser do
  it "should have nokogiri_elements" do
    html="<input id='myTestId'>"
    page_parser=SeleniumFury::PageParser.new(html)
    page_parser.nokogiri_elements.should have(1).nokogiri_element
    page_parser.nokogiri_elements[0].get_attribute('id').should == 'myTestId'
  end
end
