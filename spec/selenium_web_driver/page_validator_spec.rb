require "spec_helper"
describe SeleniumFury::SeleniumWebDriver::PageValidator do

  it "should have a missing element exception" do
    class MissingElement < PageObject
      element :not_a_element1, {:id=>"not a element1"}
    end
    launch_web_driver("http://www.homeaway.com/searchForm")
    begin
      web_driver_validate(MissingElement)
    rescue Exception => e
      e.message.should == "Found Missing Elements"
    end
  end

  it "should validate elements" do
    launch_web_driver("http://www.homeaway.com/searchForm")
    web_driver_validate(AdvancedSearchWebDriver)
  end

end