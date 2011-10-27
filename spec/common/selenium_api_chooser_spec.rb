require 'spec_helper'
describe SeleniumFury::SeleniumApiChooser do
  context "Finding generate/validate methods" do
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
      should_receive(:check_page_file_class).with(NilClass)
      validate(NilClass)
    end
    it "should find the validator for selenium web driver tests" do
      launch_web_driver "http://www.scottcsims.com"
      SeleniumFury::SeleniumWebDriver::PageValidator.should_receive(:web_driver_validate).with(NilClass)
      validate(NilClass)
    end
  end
  context "Integrating with generator/validator methods" do
    it "should find generate elements for selenium client tests" do
      create_selenium_client_driver "http://www.scottcsims.com"
      browser.start_new_browser_session
      browser.open "/"
      generate(browser).should include("found (8 elements)")

    end
    it "should find validate elements for selenium client tests" do
      create_selenium_driver("http://www.homeaway.com")
      browser.start_new_browser_session
      puts "Testing #{browser.browser_url} on #{browser.browser_string} "
      validate(AdvancedSearch, "/searchForm")
    end
    it "should have found missing locators in module", SeleniumFury::SeleniumApiChooser do
      SeleniumFury::SeleniumClient::PageValidator.respond_to?(:found_missing_locators).should be_true
    end

  end
end