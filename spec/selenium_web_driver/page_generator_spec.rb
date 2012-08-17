require 'spec_helper'
describe SeleniumFury::SeleniumWebDriver::PageGenerator do
  it "should find elements on the Test page" do
    launch_web_driver TEST_PAGE_URL
    result = generate(driver)
    result.should include 'found (15 elements)'
    result.should include 'element :form, {:id => "form"}'
  end
  it "should return a TestPage page object" do
    Object.instance_eval {remove_const :TestPage} if Object.const_defined? :TestPage
    launch_web_driver TEST_PAGE_URL
    test_page = get_page_object driver, "TestPage"
    test_page.should be_instance_of TestPage
    test_page.input_button.should be_instance_of Selenium::WebDriver::Element
    Object.instance_eval {remove_const :TestPage}
  end
end