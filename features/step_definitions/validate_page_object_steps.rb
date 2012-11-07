When /^I run the validator$/ do
  validate(TestPage)
end
Then /^the test page object locators will be checked$/ do
end
When /^I run the validator with missing locators$/ do
 pending
end
Then /^there will be missing locators found$/ do
  pending
end