When /^I run the validator$/ do
  validate(TestPage)
end
Then /^the test page object locators will be checked$/ do
end
When /^I run the validator with missing locators$/ do
  class MissingElement < PageObject
    element :not_a_element1, {:id => "not a element1"}
    element :not_a_element2, {:id => "not a element2"}
  end
  expect { web_driver_validate(MissingElement) }.to raise_exception RuntimeError, "Found Missing Elements: [:not_a_element1, :not_a_element2]"
end
Then /^there will be missing locators found$/ do

end