Feature: As an automated tester I want to use a tool to find html elements on a web page so that I can reuse locators in in the page object pattern.


  Scenario: The generator produces a ruby class on standard out that reflects the ids of page elements that can be used as a page object.
    Given I am on the advanced search page for HomeAway
    When I run the generator
    Then I will have a ruby class produced that I can use as a page object
