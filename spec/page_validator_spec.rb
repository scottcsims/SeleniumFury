require "spec_helper"
describe PageValidator do
  it "should validate the elements contained on the AdvancedSearch page object" do
    create_selenium_driver("http://www.homeaway.com")
    browser.start_new_browser_session
    puts "Testing #{browser.browser_url} on #{browser.browser_string} "
    validate(AdvancedSearch, "/searchForm")
  end
end