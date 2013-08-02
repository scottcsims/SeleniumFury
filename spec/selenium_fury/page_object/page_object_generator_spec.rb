require 'spec_helper'

describe PageObjectGenerator do
  before(:all) { launch_web_driver TEST_PAGE_URL }
  after(:all) { stop_web_driver }

  it "should find elements on the Test page" do
    result = PageObjectGenerator.generate(driver)
    result.should include 'found (16 elements)'
    result.should include 'element :form, {:id => "form"}'
  end

  it "should return a TestPage page object" do
    test_page = PageObjectGenerator.get_page_object driver, 'GeneratedTestPage'
    test_page.should be_instance_of GeneratedTestPage
    test_page.input_button.should be_instance_of Selenium::WebDriver::Element
  end

  describe PageObjectGenerator::ElementFinder do
    it "should find elements" do
      html="<input id='myTestId1'><input name='myTestId2'>"
      nokogiri_elements = SeleniumFury::PageParser.new(html).nokogiri_elements
      nokogiri_elements.should have(2).elementS
      PageObjectGenerator::ElementFinder.new(nokogiri_elements).find_elements[0].should == {id: 'myTestId1'}
      PageObjectGenerator::ElementFinder.new(nokogiri_elements).find_elements[1].should == {name: 'myTestId2'}
    end

    it "should clean an attribute name" do
      PageObjectGenerator::ElementFinder.new(nil).clean_attribute_name('myTestId1').should == 'my_test_id1'
    end

    it "should have page object attributes with a locator type and locator" do
      html="<input id='myTestId1'><input name='myTestId2'>"
      expected_hash ={'my_test_id1' => {id: 'myTestId1'}, 'my_test_id2' => {name: 'myTestId2'}}
      nokogiri_elements = SeleniumFury::PageParser.new(html).nokogiri_elements
      nokogiri_elements.should have(2).elements
      page_object_attributes = PageObjectGenerator::ElementFinder.new(nokogiri_elements).web_driver_page_object_attributes
      page_object_attributes.should_not be_nil
      page_object_attributes.should == expected_hash
    end
  end

end

