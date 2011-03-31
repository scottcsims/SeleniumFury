require File.dirname(__FILE__) + "/spec_helper"
describe PageValidator do
  it "should validate the elements contained on the page file" do
    create_selenium_driver("http://computers.shop.ebay.com")
    browser.start_new_browser_session
    puts "Testing #{browser.browser_url} on #{browser.browser_string} "
    check_page_file_class(AdvancedSearch, "/ebayadvsearch")
  end
end