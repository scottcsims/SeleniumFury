require "spec_helper"
describe SeleniumFury::SeleniumWebDriver::PageValidator do
  it "should find elements on the HomeAway advanced search page" do
    launch_web_driver("http://www.homeaway.com/searchForm")
    advanced_search = AdvancedSearchWebDriver.new(driver)
    advanced_search.amenity0_0.click
    web_driver_validate(AdvancedSearchWebDriver)
    advanced_search.adv_search_form.submit
  end
end