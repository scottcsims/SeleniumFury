require "spec_helper"
describe SeleniumFury::SeleniumWebDriver::PageGenerator do
  it "should find elements on the HomeAway advanced search page" do
    launch_web_driver("http://www.homeaway.com/searchForm")
    result = generate(driver)
    result.should include("found (39 elements)")
    result.should include("element :adv_search_form, {:id => \"adv-search-form\"}")
  end
end