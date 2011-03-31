require File.dirname(__FILE__) + "/spec_helper"
describe PageGenerator do
  it "should find elements on ebay advanced search" do
    create_selenium_driver("http://computers.shop.ebay.com")
    browser.start_new_browser_session
    puts "Testing #{browser.browser_url} on #{browser.browser_string} "
    browser.open "/ebayadvsearch"
    get_source_and_print_elements(browser)
  end
end