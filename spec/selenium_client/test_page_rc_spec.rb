require "spec_helper"
describe TestPageRc do
  it "should use elements on the TestPageRc" do
    create_selenium_driver TEST_PAGE_URL
    browser.start_new_browser_session
    puts "Testing #{browser.browser_url} on #{browser.browser_string} "
    browser.open  TEST_PAGE_URL
    test_page = TestPageRc.new(browser)
    browser.click test_page.input_message
    browser.type test_page.input_message, "this is awesome"
    browser.click test_page.input_msg_button
    browser.text("message").should == "this is awesome"
  end
end