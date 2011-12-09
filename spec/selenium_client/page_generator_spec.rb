require "spec_helper"
describe SeleniumFury::SeleniumClient::PageGenerator do
  it "should find elements on the HomeAway advanced search page" do
    create_selenium_driver("http://www.homeaway.com")
    browser.start_new_browser_session
    puts "Testing #{browser.browser_url} on #{browser.browser_string} "
    browser.open "/searchForm"
    result = generate(browser)
    result.should include("found (43 elements)")
  end
end