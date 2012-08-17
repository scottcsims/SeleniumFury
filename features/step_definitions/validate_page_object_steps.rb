When /^I run the validator$/ do
  validate(TestPageRc, TEST_PAGE_URL)
end
Then /^the test page object locators will be checked$/ do
  @found_missing_locators.should have(0).elements
end
When /^I run the validator with missing locators$/ do
  class TestPageRcBroken < TestPageRc
    def initialize *browser
      super
      @missing_locator_attribute="missing_locator"
    end

    attr_reader :missing_locator_attribute
  end
  begin
    check_page_file_class(TestPageRcBroken,TEST_PAGE_URL)
  rescue Exception=>e
  end
end
Then /^there will be missing locators found$/ do
  @found_missing_locators.should have(1).elements
  @found_missing_locators["missing_locator_attribute"].should == "missing_locator"
end