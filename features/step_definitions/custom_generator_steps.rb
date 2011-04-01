require File.dirname(__FILE__) + "/require_helper"
require File.dirname(__FILE__) + "/../../spec/advanced_search_custom_generator_configuration"

When /^I have a custom generator configuration class$/ do
  @advanced_search_custom_generator_configuration = AdvancedSearchCustomGeneratorConfiguration.new()
  @advanced_search_custom_generator_configuration.should_not be_nil
end
When /^I run the custom generator$/ do
  @found_element_ids=custom_generator(:browser => browser,
                                      :custom_configuration => @advanced_search_custom_generator_configuration)

end
When /^I specify a selector attribute$/ do
  @advanced_search_custom_generator_configuration.selector.should_not be_nil

end
When /^I create a nokogiri document for the test page$/ do
  @doc = Nokogiri::HTML(ADVANCED_SEARCH_HTML)
  @doc.should_not be_nil
  @doc.class.to_s.should == "Nokogiri::HTML::Document"
end

Then /^I should get a nokogiri node set that I can iterate over to find a name and value for my page object locators$/ do
  @check_box_nokogiri_elements = @doc.css(@advanced_search_custom_generator_configuration.selector)
  @check_box_nokogiri_elements.class.to_s.should == "Nokogiri::XML::NodeSet"
  @check_box_nokogiri_elements.each do |nokogiri_element|
    nokogiri_element.class.to_s.should == "Nokogiri::XML::Element"
  end
end
When /^I call the name method on the custom generator configuration class$/ do
  @advanced_search_custom_generator_configuration.nokogiri_element=@check_box_nokogiri_elements.last
  @advanced_search_custom_generator_configuration.nokogiri_element=@check_box_nokogiri_elements.last
  @locator_name = @advanced_search_custom_generator_configuration.name
end
Then /^I should get the raw string to name my page object attribute$/ do
  @locator_name.should_not be_nil
  @locator_name.should == "downtown"
end
When /^I call the value method on the custom generator configuration class$/ do
  @locator_value = @advanced_search_custom_generator_configuration.value
end
Then /^I should get a value that I can use as a selenium locator$/ do
  @locator_value.should_not be_nil
  @locator_value.should == "location2.2"
end


ADVANCED_SEARCH_HTML=<<EOF
<form id=adv-search-form>
<div class="fieldset">
							<div class="columns">
										<div class="column">
											<div class="cb-box">
												<input class="checkbox" type="checkbox" id="suitability0.0" name="refinements" value="Suitability:children welcome">
												<label for="suitability0.0">children welcome</label>
											</div>
										</div>
										<div class="column">
											<div class="cb-box">
												<input class="checkbox" type="checkbox" id="suitability0.1" name="refinements" value="Suitability:wheelchair accessible">
												<label for="suitability0.1">wheelchair accessible</label>
											</div>
										</div>
										<div class="column">
											<div class="cb-box">
												<input class="checkbox" type="checkbox" id="suitability1.0" name="refinements" value="Suitability:suitable for elderly or infirm">
												<label for="suitability1.0">suitable for elderly or infirm</label>
											</div>
										</div>
										<div class="column">
											<div class="cb-box">
												<input class="checkbox" type="checkbox" id="suitability1.1" name="refinements" value="Suitability:pets considered">
												<label for="suitability1.1">pet friendly</label>
											</div>
										</div>
										<div class="column">
											<div class="cb-box">
												<input class="checkbox" type="checkbox" id="suitability2.0" name="refinements" value="Suitability:non smoking only">
												<label for="suitability2.0">non smoking only</label>
											</div>
										</div>
										<div class="column">
											<div class="cb-box">
												<input class="checkbox" type="checkbox" id="suitability2.1" name="refinements" value="Suitability:long term renters welcome">
												<label for="suitability2.1">long term renters welcome</label>
											</div>
										</div>
								<div class="clear"></div>
							</div>
						</div>
<div class="fieldset">
							<div class="columns">
										<div class="column">
											<div class="cb-box">
												<input class="checkbox" type="checkbox" id="location0.0" name="refinements" value="Location Type:beach">
												<label for="location0.0">beach</label>
											</div>
										</div>
										<div class="column">
											<div class="cb-box">
												<input class="checkbox" type="checkbox" id="location0.1" name="refinements" value="Location Type:lake">
												<label for="location0.1">lake</label>
											</div>
										</div>
										<div class="column">
											<div class="cb-box">
												<input class="checkbox" type="checkbox" id="location0.2" name="refinements" value="Location Type:waterfront">
												<label for="location0.2">waterfront</label>
											</div>
										</div>
										<div class="column">
											<div class="cb-box">
												<input class="checkbox" type="checkbox" id="location0.3" name="refinements" value="Location Type:mountain">
												<label for="location0.3">mountain</label>
											</div>
										</div>
										<div class="column">
											<div class="cb-box">
												<input class="checkbox" type="checkbox" id="location1.0" name="refinements" value="Location Type:near the ocean">
												<label for="location1.0">near the ocean</label>
											</div>
										</div>
										<div class="column">
											<div class="cb-box">
												<input class="checkbox" type="checkbox" id="location1.1" name="refinements" value="Location Type:resort">
												<label for="location1.1">resort</label>
											</div>
										</div>
										<div class="column">
											<div class="cb-box">
												<input class="checkbox" type="checkbox" id="location1.2" name="refinements" value="Location Type:rural">
												<label for="location1.2">rural</label>
											</div>
										</div>
										<div class="column">
											<div class="cb-box">
												<input class="checkbox" type="checkbox" id="location1.3" name="refinements" value="Location Type:town">
												<label for="location1.3">town</label>
											</div>
										</div>
										<div class="column">
											<div class="cb-box">
												<input class="checkbox" type="checkbox" id="location2.0" name="refinements" value="Location Type:village">
												<label for="location2.0">village</label>
											</div>
										</div>
										<div class="column">
											<div class="cb-box">
												<input class="checkbox" type="checkbox" id="location2.1" name="refinements" value="Location Type:river">
												<label for="location2.1">river</label>
											</div>
										</div>
										<div class="column">
											<div class="cb-box">
												<input class="checkbox" type="checkbox" id="location2.2" name="refinements" value="Location Type:downtown">
												<label for="location2.2">downtown</label>
											</div>
										</div>
								<div class="clear"></div>
							</div>
						</div>
<form>
EOF
