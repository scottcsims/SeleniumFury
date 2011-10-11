require "spec_helper"
describe AdvancedSearch do
  it "should find a vacation rental in Destin with a pool and air conditioning " do
    create_selenium_driver("http://www.homeaway.com")
    browser.start_new_browser_session
    puts "Testing #{browser.browser_url} on #{browser.browser_string} "
    browser.open  "/searchForm"
    advanced_search = AdvancedSearch.new(browser)
    browser.click advanced_search.air_conditioning
    browser.click advanced_search.pool
    browser.submit advanced_search.adv_search_form
    browser.wait_for_page_to_load "30000"
    browser.text("css=div#search-headline")
  end
end