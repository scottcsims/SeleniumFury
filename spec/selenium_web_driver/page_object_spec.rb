require 'spec_helper'
describe PageObject do

  it "should go to the home page using launch site" do
    launch_web_driver "http://www.scottcsims.com"
    driver.current_url.should == "http://scottcsims.com/wordpress/"
    driver.navigate.to "http://www.scottcsims"
    driver.title.should == "Scott Sims"
  end

  it 'should return a web_driver element when an attribute is accessed' do
    launch_web_driver "http://www.homeaway.com/vacation-rental/p254680"
    inquiry_side_bar = InquirySideBar.new(driver)
    inquiry_side_bar.first_name.class.should == Selenium::WebDriver::Element
    inquiry_side_bar.first_name.send_keys Faker::Name.first_name
  end

  it "should raise an exception when the element can't be found'" do
    launch_web_driver "http://www.homeaway.com/vacation-rental/p254680"
    inquiry_side_bar = InquirySideBar.new(driver)
    InquirySideBar.element(:not_a_element, {:id =>"not a element"})
    begin
      inquiry_side_bar.not_a_element
    rescue Exception => e
      e.message.should == "Could not find element not_a_element"
    end
    e.should_not be_nil, "we were expecting an exception"
  end

  it "should have a property page that contains a inquiry sidebar" do
    launch_web_driver "http://www.homeaway.com/vacation-rental/p254680"
    property_page = PropertyPage.new(driver)
    property_page.should_not be_nil
    property_page.inquiry_side_bar.should_not be_nil
    property_page.inquiry_side_bar.first_name.class.should == Selenium::WebDriver::Element
  end

  it "should have an error if a non page object class is passed to page method" do
    property_page = PropertyPage.new()
    PropertyPage.page(:not_a_page, String)
    begin
      property_page.not_a_page
    rescue Exception => e
      e.message.should == "String does not inherit from PageObject"
    end
    e.should_not be_nil, "we were expecting and exception"
  end
  it "should use elements on the HomeAway advanced search page" do
    launch_web_driver("http://www.homeaway.com/searchForm")
    advanced_search = AdvancedSearchWebDriver.new(driver)
    advanced_search.amenity0_0.click
    advanced_search.adv_search_form.submit
  end

  it "should use methods on the HomeAway advanced search page" do
    launch_web_driver("http://www.homeaway.com/searchForm")
    advanced_search = AdvancedSearchWebDriver.new(driver)
    advanced_search.click_one_item
  end
end