Feature: Custom Generator
  As an automated tester I want to create a page object with variable names that reflect business terms so the our test will reflect ubiquitous language.

  Scenario: Use a custom generator configuration object to specify how to name our variables from another source than the id
    Given I am on the test page
    When I have a custom generator configuration class
    And  I run the custom generator
    Then I will have a ruby class produced that I can use as a page object


  Scenario: I can specify a locator that I can pass to nokogiri to get a nokogiri node set that contains data that I want to use as an attribute name and locator value
    Given I have a custom generator configuration class
    When  I specify a selector attribute
    And   I create a nokogiri document for the test page
    Then  I should get a nokogiri node set that I can iterate over to find a name and value for my page object locators
    When  I call the name method on the custom generator configuration class
    Then  I should get the raw string to name my page object attribute
    When  I call the value method on the custom generator configuration class
    Then  I should get a value that I can use as a selenium locator


