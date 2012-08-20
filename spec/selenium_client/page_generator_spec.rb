require "spec_helper"
describe SeleniumFury::SeleniumClient::PageGenerator do
  it "should find elements on the HomeAway advanced search page" do
    create_selenium_driver TEST_PAGE_URL
    browser.start_new_browser_session
    puts "Testing #{browser.browser_url} on #{browser.browser_string} "
    browser.open TEST_PAGE_URL
    result = generate(browser)
    result.should include("found (15 elements)")
  end
end