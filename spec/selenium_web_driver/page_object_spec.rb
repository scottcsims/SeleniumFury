require 'spec_helper'
describe PageObject do

  it "should go to the home page using launch site" do
    launch_web_driver "http://www.scottcsims.com"
    driver.current_url.should == "http://scottcsims.com/wordpress/"
    driver.navigate.to "http://www.scottcsims"
    driver.title.should == "Scott Sims"
  end
  it "should have elements" do
    launch_web_driver "http://www.homeaway.com"
    search=get_page_object(driver, 'Search')
    search.class.elements.should_not be_nil
    search.class.elements.should have(8).elements
    search.method(search.class.elements[0]).call.class.should == Selenium::WebDriver::Element
  end
  it 'should return a web_driver element when an attribute is accessed' do
    launch_web_driver "http://www.homeaway.com"
    search=get_page_object(driver, 'Search')
    search.start_date_input.class.should == Selenium::WebDriver::Element
    search.search_keywords Faker::Lorem.words
  end

  it "should raise an exception when the element can't be found'" do
    launch_web_driver "http://www.homeaway.com"
    search=get_page_object(driver, 'Search')
    Search.element(:not_a_element, {:id =>"not a element"})
    lambda{search.not_a_element}.should(raise_exception(RuntimeError,"Could not find element not_a_element"))
  end

  it "should have a property page that contains a inquiry sidebar" do
    launch_web_driver "http://www.homeaway.com/vacation-rental/p254680"
    property_page = PropertyPage.new(driver)
    property_page.should_not be_nil
    property_page.inquiry_side_bar.should_not be_nil
  end

  it "should have an error if a non page object class is passed to page method" do
    property_page = PropertyPage.new()
    PropertyPage.page(:not_a_page, String)
    lambda{property_page.not_a_page}.should raise_exception(RuntimeError,"String does not inherit from PageObject")
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