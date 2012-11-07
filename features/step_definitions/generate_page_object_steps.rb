Given /^I am on the test page$/ do
  launch_web_driver TEST_PAGE_URL
end

When /^I run the generator$/ do
  @found_element_ids=generate(driver)
end

Then /^I will have a ruby class produced that I can use as a page object$/ do
  @found_element_ids.should include('found (15 elements)')
end
