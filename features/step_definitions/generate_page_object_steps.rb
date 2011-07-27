Given /^I am on the advanced search page for HomeAway$/ do
  create_selenium_driver("http://www.homeaway.com")
  browser.start_new_browser_session
  puts "Testing #{browser.browser_url} on #{browser.browser_string} "
  browser.open "/searchForm"
end

When /^I run the generator$/ do
  @found_element_ids=get_source_and_print_elements(browser)
end

Then /^I will have a ruby class produced that I can use as a page object$/ do
  @found_element_ids.should_not be_nil
end
