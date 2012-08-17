require 'spec_helper'
describe SeleniumFury::SeleniumWebDriver::ElementFinder do
  it "should find elements" do
    html="<input id='myTestId1'><input name='myTestId2'>"
    nokogiri_elements = SeleniumFury::PageParser.new(html).nokogiri_elements
    nokogiri_elements.should have(2).elementS
    SeleniumFury::SeleniumWebDriver::ElementFinder.new(nokogiri_elements).find_elements[0].should == {:id=>"myTestId1"}
    SeleniumFury::SeleniumWebDriver::ElementFinder.new(nokogiri_elements).find_elements[1].should == {:name=>"myTestId2"}
  end
  it "should clean an attribute name" do
    SeleniumFury::SeleniumWebDriver::ElementFinder.new(nil).clean_attribute_name("myTestId1").should == "my_test_id1"
  end
  it "should have page object attributes with a locator type and locator" do
    html="<input id='myTestId1'><input name='myTestId2'>"
    expected_hash ={"my_test_id1"=>{:id =>'myTestId1'}, "my_test_id2"=>{:name =>'myTestId2'}}
    nokogiri_elements = SeleniumFury::PageParser.new(html).nokogiri_elements
    nokogiri_elements.should have(2).elements
    page_object_attributes = SeleniumFury::SeleniumWebDriver::ElementFinder.new(nokogiri_elements).web_driver_page_object_attributes
    page_object_attributes.should_not be_nil
    page_object_attributes.should == expected_hash

  end
end