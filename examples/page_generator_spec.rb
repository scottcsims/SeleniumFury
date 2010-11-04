require File.dirname(__FILE__) + "/spec_helper"
require File.dirname(__FILE__) + "/../lib/page_generator"
describe PageGenerator do
  include CreateBrowserDriver
  include PageGenerator
  append_after(:each) do
    if @browser
      browser.close_current_browser_session
    end
  end

  it "should find elements on ebay advanced search" do
    create_selenium_driver("http://computers.shop.ebay.com")
    browser.start_new_browser_session
    puts "Testing #{browser.browser_url} on #{browser.browser_string} "
    browser.open "/ebayadvsearch"
    get_source_and_print_elements(browser)
  end
end