require "spec_helper"
describe SeleniumFury::SeleniumClient::PageValidator do
  it "should validate the elements contained on the AdvancedSearch page object" do
    create_selenium_driver("http://www.homeaway.com")
    browser.start_new_browser_session
    puts "Testing #{browser.browser_url} on #{browser.browser_string} "
    web_driver_validate(AdvancedSearch, "/searchForm")
  end
end