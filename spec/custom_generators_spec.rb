require File.dirname(__FILE__) + "/spec_helper"
describe AdvancedSearchCustomGeneratorConfiguration do
  it "should generate the advanced search locators" do
    create_selenium_driver("http://www.homeaway.com")
    browser.start_new_browser_session
    puts "Testing #{browser.browser_url} on #{browser.browser_string} "
    browser.open "/searchForm"
    advanced_search_custom_generator_configuration = AdvancedSearchCustomGeneratorConfiguration.new
    custom_generator(:browser => browser,
                     :custom_configuration => advanced_search_custom_generator_configuration)
  end
end
