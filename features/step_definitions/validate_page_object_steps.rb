When /^I run the validator$/ do
  check_page_file_class(AdvancedSearch, "/searchForm")
end
Then /^the advanced search page object locators will be checked$/ do
  found_missing_locators.should have(0).elements
  found_missing_locators.should_not be_nil
end
When /^I run the validator with missing locators$/ do
  class AdvancedSearchBroken < AdvancedSearch
    def initialize *browser
      super
      @missing_locator_attribute="missing_locator"
    end

    attr_reader :missing_locator_attribute
  end
  begin
    check_page_file_class(AdvancedSearchBroken, "/searchForm")
  rescue Exception=>e
  end
end
Then /^there will be missing locators found$/ do
  found_missing_locators["missing_locator_attribute"].should == "missing_locator"
end