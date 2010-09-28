require File.dirname(__FILE__) + "/spec_helper"
require File.dirname(__FILE__) + "/../lib/page_generator"
describe PageGenerator do
  include CreateBrowserDriver
  append_after(:each) do
    browser.close_current_browser_session
  end
  it "should get source and print elements" do
    create_selenium_driver("http://stage.homeaway.com/")
    browser.start_new_browser_session
    puts "Testing #{browser.browser_url} on #{browser.browser_string} "
    browser.open "/254680"
    page_parser = PageGenerator.new
    page_parser.get_source_and_print_elements(browser)

  end
end