require 'spec_helper'
describe SeleniumFury::SeleniumWebDriver::PageValidator do

  it "should have a missing element exception" do
    class MissingElement < PageObject
      element :not_a_element1, {:id=>"not a element1"}
      element :not_a_element2, {:id=>"not a element2"}
    end
    launch_web_driver TEST_PAGE_URL
    expect{web_driver_validate(MissingElement)}.to raise_exception RuntimeError,"Found Missing Elements: [:not_a_element1, :not_a_element2]"
  end

  it "should validate elements" do
    launch_web_driver TEST_PAGE_URL
    validate TestPage
  end

end