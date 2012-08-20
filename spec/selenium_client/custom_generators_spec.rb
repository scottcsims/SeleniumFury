require "spec_helper"
describe TestPageCustomGeneratorConfiguration do
  it "should generate the advanced search locators" do
    create_selenium_driver TEST_PAGE_URL
    browser.start_new_browser_session
    puts "Testing #{browser.browser_url} on #{browser.browser_string} "
    browser.open TEST_PAGE_URL
    test_page_custom_generator_configuration = TestPageCustomGeneratorConfiguration.new
    result = custom_generator(:browser => browser,
                     :custom_configuration => test_page_custom_generator_configuration)
    result.should include("found (3 elements)")
  end
end
