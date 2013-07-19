require 'spec_helper'
describe SeleniumFury::SeleniumWebDriver::PageGenerator do
  it "should find elements on the Test page" do
    launch_web_driver TEST_PAGE_URL
    result = generate(driver)
    result.should include 'found (16 elements)'
    result.should include 'element :form, {:id => "form"}'
  end
  it "should return a TestPage page object" do
    launch_web_driver TEST_PAGE_URL
    test_page = get_page_object driver, "TestPage"
    test_page.should be_instance_of TestPage
    test_page.input_button.should be_instance_of Selenium::WebDriver::Element
  end
end