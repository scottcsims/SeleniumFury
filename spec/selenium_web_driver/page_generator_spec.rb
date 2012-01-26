require "spec_helper"
describe SeleniumFury::SeleniumWebDriver::PageGenerator do
  it "should find elements on the HomeAway advanced search page" do
    launch_web_driver("http://www.homeaway.com/searchForm")
    result = generate(driver)
    result.should include("found (43 elements)")
    result.should include("element :adv_search_form, {:id => \"adv-search-form\"}")
  end
  it "should return a page object" do
    launch_web_driver("http://www.homeaway.com/searchForm")
    search_form = get_page_object(driver,"SearchForm")
    search_form.should be_instance_of SearchForm
    search_form.special_offers.should be_instance_of Selenium::WebDriver::Element
  end
end