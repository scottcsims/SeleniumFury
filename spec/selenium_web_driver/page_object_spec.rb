require 'spec_helper'
describe SeleniumFury::SeleniumWebDriver::CreateSeleniumWebDriver do
  it "should go to page using launch_web_driver" do
    launch_web_driver TEST_PAGE_URL
    driver.current_url.should include "/spec/test_page/test_page.html"
    driver.title.should == "SeleniumFury Test Page"
  end
end

describe PageObject do
  it "should have a text area method on the test page" do
    launch_web_driver TEST_PAGE_URL
    test_page = TestPage.new(driver)
    test_page.should_not be_nil
    test_page.textarea.should be_a(Selenium::WebDriver::Element)
  end
  it "should have a test page" do
    class ComponentPage < PageObject

    end
    TestPage.page(:component_page, ComponentPage)
    TestPage.new().component_page.should be_a(ComponentPage)
  end

  it "should have an error if a non page object class is passed to page method" do
    TestPage.page(:not_a_page, String)
    expect { TestPage.new().not_a_page }.to(raise_exception(RuntimeError, "String does not inherit from PageObject"))
  end

  it "should use elements on the TestPage" do
    launch_web_driver TEST_PAGE_URL
    test_page = TestPage.new(driver)
    test_page.input_message.send_keys "this is awesome"
    test_page.input_msg_button.click
    driver.find_element(:id => "message").text.should == "this is awesome"
  end

  it "should use some methods man" do
    launch_web_driver TEST_PAGE_URL
    test_page = TestPage.new(driver)
    test_page.click_check_box
    driver.find_element(:id => "input_checkbox").selected?.should be_true
  end

  # OK, so here's some great info about the "magic" behind ruby.
  # When ruby spins up, an Object class is created, and everything runs "inside" it
  # When you do code like this: TestPage.new() an instance of TestPage is added as a constant
  # to the instance of this "global" Object class
  # Therefore, since rspec is running "inside" this Object Class, an instance of TestPage is
  # instantiated and shared from test to test, BUT when you do get_page_object, an instance
  # of the page object must be created and added as a constant, but if it already exists,
  # you're gonna have bad time. Therefore, for testing sake, we must check for this,
  # and handle it appropriately.
  #
  # It should also be noted that get_page_object only adds page elements to the class
  # and currently doesn't look for a pre-defined page object in the project

  it "should have elements" do
    Object.instance_eval { remove_const :TestPage } if Object.const_defined? :TestPage
    launch_web_driver TEST_PAGE_URL
    test_page = get_page_object(driver, 'TestPage')
    test_page.class.elements.should_not be_nil
    test_page.class.elements.should have(15).elements
    test_page.method(test_page.class.elements[0]).call.class.should == Selenium::WebDriver::Element
    Object.instance_eval { remove_const :TestPage }
  end
  it "should return a web_driver element when an attribute is accessed" do
    Object.instance_eval { remove_const :TestPage } if Object.const_defined? :TestPage
    launch_web_driver TEST_PAGE_URL
    test_page = get_page_object(driver, 'TestPage')
    test_page.textarea.class.should == Selenium::WebDriver::Element
    Object.instance_eval { remove_const :TestPage }
  end

  it "should raise an exception when the element can't be found'" do
    Object.instance_eval { remove_const :TestPage } if Object.const_defined? :TestPage
    launch_web_driver TEST_PAGE_URL
    test_page = get_page_object(driver, 'TestPage')
    TestPage.element :not_a_element, {:id => "not a element"}
    expect { test_page.not_a_element }.to raise_exception RuntimeError, "Could not find element not_a_element"
    Object.instance_eval { remove_const :TestPage }
  end

end