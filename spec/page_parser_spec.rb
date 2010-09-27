require "spec_helper"
require "../lib/page_parser"
describe PageParser do
  include CreateBrowserDriver
  append_after(:each) do
    browser.close_current_browser_session
  end
  it "should get source and print elements" do
    url = "http://stage.homeaway.com/"
    create_selenium_driver(url)
    browser.start_new_browser_session
    puts "Testing #{browser.browser_url} on #{browser.browser_string} "
    browser.open "/searchForm"
    page_parser = PageParser.new
    page_parser.get_source_and_print_elements(browser)

  end
end