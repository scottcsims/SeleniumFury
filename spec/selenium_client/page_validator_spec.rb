require "spec_helper"
describe SeleniumFury::SeleniumClient::PageValidator do
  it "should validate the elements contained on the AdvancedSearch page object" do
    create_selenium_driver("http://www.homeaway.com")
    browser.start_new_browser_session
    validate(AdvancedSearch, "/searchForm")
    @found_missing_locators.should_not be_nil
    @found_missing_locators.should have(0).missing_locators
  end
  it "should fail if there are missing locators" do
    create_selenium_driver("http://www.homeaway.com")
    class MissingLocators
      def initialize *browser
        @browser=browser
        @missing = "missing_id"
      end

      attr_reader :missing
    end
    browser.start_new_browser_session
    begin
      validate(MissingLocators, browser, "/searchForm")
    rescue Exception => e
      puts e.message.should include("found missing locators")
      @found_missing_locators["missing"].should =="missing_id"
    end
  end
  it "should have found missing locators in module",SeleniumFury::SeleniumClient::PageValidator do
    SeleniumFury::SeleniumClient::PageValidator.respond_to?(:found_missing_locators).should be_true
  end
end