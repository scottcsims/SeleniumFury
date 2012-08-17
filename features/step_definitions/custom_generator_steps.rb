When /^I have a custom generator configuration class$/ do
  @test_page_custom_generator_configuration = TestPageCustomGeneratorConfiguration.new()
  @test_page_custom_generator_configuration.should_not be_nil
end
When /^I run the custom generator$/ do
  @found_element_ids=custom_generator(:browser => browser,
                                      :custom_configuration => @test_page_custom_generator_configuration)

end
When /^I specify a selector attribute$/ do
  @test_page_custom_generator_configuration.selector.should_not be_nil

end
When /^I create a nokogiri document for the test page$/ do
  @doc = Nokogiri::HTML(ADVANCED_SEARCH_HTML)
  @doc.should_not be_nil
  @doc.class.to_s.should == "Nokogiri::HTML::Document"
end

Then /^I should get a nokogiri node set that I can iterate over to find a name and value for my page object locators$/ do
  @check_box_nokogiri_elements = @doc.css(@test_page_custom_generator_configuration.selector)
  @check_box_nokogiri_elements.class.to_s.should == "Nokogiri::XML::NodeSet"
  @check_box_nokogiri_elements.each do |nokogiri_element|
    nokogiri_element.class.to_s.should == "Nokogiri::XML::Element"
  end
end
When /^I call the name method on the custom generator configuration class$/ do
  @test_page_custom_generator_configuration.nokogiri_element=@check_box_nokogiri_elements.last
  @test_page_custom_generator_configuration.nokogiri_element=@check_box_nokogiri_elements.last
  @locator_name = @test_page_custom_generator_configuration.name
end
Then /^I should get the raw string to name my page object attribute$/ do
  @locator_name.should_not be_nil
  @locator_name.should == "Link 3"
end
When /^I call the value method on the custom generator configuration class$/ do
  @locator_value = @test_page_custom_generator_configuration.value
end
Then /^I should get a value that I can use as a selenium locator$/ do
  @locator_value.should_not be_nil
  @locator_value.should == "link333333"
end


ADVANCED_SEARCH_HTML=<<EOF
<!doctype html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <title>SeleniumFury Test Page</title>
    <script type="text/javascript">
        function displayMessage() {
           document.getElementById('message').innerHTML = document.form.msgtext.value
        }
    </script>
</head>
<body>

<div id="message"></div>

<form id="form" name="form">
    <label for="textarea">Textarea</label>
    <textarea id="textarea">This is a textarea field.
    </textarea>
    <br/>
    <label for="select">Select</label>
    <select id="select">
        <option value="volvo">Volvo</option>
        <option value="saab">Saab</option>
        <option value="mercedes">Mercedes</option>
        <option value="audi">Audi</option>
    </select>
    <br/>
    <label for="input_button">Button</label>
    <input id="input_button" type="button" value="Click me"/>
    <br/>
    <label for="input_checkbox">Checkbox</label>
    <input id="input_checkbox" type="checkbox"/>
    <br/>
    <label for="input_file">File</label>
    <input id="input_file" type="file"/>
    <br/>
    <input id="input_hidden" type="hidden"/>
    <br/>
    <label for="input_image">Image</label>
    <input id="input_image" type="image" alt="input image"/>
    <br/>
    <label for="input_password">Password</label>
    <input id="input_password" type="password"/>
    <br/>
    <label for="input_radio">Radio</label>
    <input id="input_radio" type="radio"/>
    <br/>
    <label for="input_reset">Reset</label>
    <input id="input_reset" type="reset"/>
    <br/>
    <label for="input_submit">Submit</label>
    <input id="input_submit" type="submit"/>
    <br/>
    <label for="input_text">Text</label>
    <input id="input_text" type="text"/>
    <br/>
    <fieldset>
        <legend>Input test:</legend>
        <label for="input_message">Message Text:</label>
        <input id="input_message" name="msgtext" type="text" />
        <br/>
        <input id="input_msg_button" type="button" value="Click me" onClick="displayMessage()"/>
    </fieldset>
</form>
<a id="link111111" href="http://news.ycombinator.com/">Link 1</a>
<a id="link222222" href="http://yahoo.com">Link 2</a>
<a id="link333333" href="http://google.com">Link 3</a>
</body>
</html>
EOF
