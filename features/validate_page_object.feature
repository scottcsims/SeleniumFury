Feature: Validator
  As an automated tester I want a tool to check if my page object locators are correct so that I can update invalid locators.

  Scenario: Use reflection to open a page object and validate that the locators are valid
    Given I am on the test page
    When I run the validator
    Then the test page object locators will be checked

  Scenario: The validator will fail and return a list of missing locators
    Given I am on the test page
    When I run the validator with missing locators
    Then there will be missing locators found
