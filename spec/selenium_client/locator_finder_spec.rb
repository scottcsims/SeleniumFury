require 'spec_helper'
describe SeleniumFury::SeleniumClient::LocatorFinder do
  it "should find locators" do
    html="<input id='myTestId1'><input name='myTestId2'>"
    nokogiri_elements = SeleniumFury::PageParser.new(html).nokogiri_elements
    nokogiri_elements.should have(2).elementS
    SeleniumFury::SeleniumClient::LocatorFinder.new(nokogiri_elements).find_locators[0].should == "myTestId1"
    SeleniumFury::SeleniumClient::LocatorFinder.new(nokogiri_elements).find_locators[1].should == "myTestId2"
  end
  it "should find get an attribute name" do
    SeleniumFury::SeleniumClient::LocatorFinder.new(nil).attribute_name("myTestId1").should == "my_test_id1"
  end
  it "should have page object attributes" do
    html="<input id='myTestId1'><input name='myTestId2'>"
    nokogiri_elements = SeleniumFury::PageParser.new(html).nokogiri_elements
    nokogiri_elements.should have(2).elementS
    page_object_attributes = SeleniumFury::SeleniumClient::LocatorFinder.new(nokogiri_elements).page_object_attributes
    page_object_attributes.should_not be_nil
  end
end