require "spec_helper"
describe SeleniumFury::SeleniumWebDriver::PageValidator do
  it "should find a missing element" do
    class MissingElement < PageObject
      element :not_a_element1, {:id=>"not a element1"}
      element :not_a_element2, {:id=>"not a element2"}
    end
    launch_web_driver("http://www.homeaway.com/searchForm")
    result=web_driver_validate(MissingElement)
    result.should include(:not_a_element1)
    result.should include(:not_a_element2)
    result.should have(2).missing_elements

  end
  it "should validate elements" do
      launch_web_driver("http://www.homeaway.com/searchForm")
      result=web_driver_validate(AdvancedSearchWebDriver)
      result.should have(0).missing_elements
    end

end