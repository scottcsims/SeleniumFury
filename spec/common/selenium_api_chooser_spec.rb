require 'spec_helper'
describe SeleniumFury::SeleniumApiChooser do
  it "should find the generator for selenium client tests" do
    create_selenium_client_driver "http://www.scottcsims.com"
    SeleniumFury::SeleniumClient::PageGenerator.should_receive(:get_source_and_print_elements)
    generate(browser)
  end
  it "should find the generator for selenium web_driver tests" do
    launch_web_driver "http://www.scottcsims.com"
    SeleniumFury::SeleniumWebDriver::PageGenerator.should_receive(:web_driver_generate)
    generate(driver)
  end
  it "should find the validator for selenium client tests" do
    create_selenium_client_driver "http://www.scottcsims.com"
    SeleniumFury::SeleniumClient::PageValidator.should_receive(:check_page_file_class)
    validate(NilClass)
  end
  it "should find the validator for selenium web driver tests" do
    launch_web_driver "http://www.scottcsims.com"
    SeleniumFury::SeleniumWebDriver::PageValidator.should_receive(:web_driver_validate)
    validate(NilClass)
  end
end