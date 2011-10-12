require "spec_helper"
describe SeleniumFury::SeleniumWebDriver::PageGenerator do
  it "should find elements on the HomeAway advanced search page" do
    launch_site("http://www.homeaway.com/searchForm")
    result = web_driver_generate(driver)
    result.should include("found (39 elements)")
  end
end