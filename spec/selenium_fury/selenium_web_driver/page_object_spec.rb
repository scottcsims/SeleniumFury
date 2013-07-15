require 'spec_helper'
describe SeleniumFury::SeleniumWebDriver::CreateSeleniumWebDriver do
  it "should go to a page using launch_web_driver" do
    launch_web_driver TEST_PAGE_URL
    driver.current_url.should include "/spec/test_page/test_page.html"
    driver.title.should == "SeleniumFury Test Page"
  end
end

describe PageObject do
  after(:each) do
    Object.instance_eval { remove_const :TestPage } if Object.const_defined? :TestPage
  end
  specify "has Selenium::WebDriver::Elements defined with the element method" do
    launch_web_driver TEST_PAGE_URL
    test_page = TestPage.new(driver)
    test_page.should_not be_nil
    test_page.textarea.should be_a(Selenium::WebDriver::Element)
  end
  specify "allows a page object class can be linked to another page object class using the page method for sub pages" do
    class ComponentPage < PageObject

    end
    TestPage.page(:component_page, ComponentPage)
    TestPage.new().component_page.should be_a(ComponentPage)
  end

  it "should have an error if a non page object class is passed to the page method" do
    TestPage.page(:not_a_page, String)
    expect { TestPage.new().not_a_page }.to(raise_exception(RuntimeError, "String does not inherit from PageObject"))
  end

  it "should call methods on Selenium::WebDriver::Elements defined in the TestPage class" do
    launch_web_driver TEST_PAGE_URL
    test_page = TestPage.new(driver)
    test_page.input_message.send_keys "this is awesome"
    test_page.input_msg_button.click
    driver.find_element(:id => "message").text.should == "this is awesome"
  end

  specify "PageObject provides a method to return all Selenium::WebDriver::Element defined in the class" do
    launch_web_driver TEST_PAGE_URL
    test_page = TestPage.new(driver)
    test_page.class.elements.should_not be_nil
    test_page.class.elements.should have(39).elements
    test_page.method(test_page.class.elements[0]).call.class.should == Selenium::WebDriver::Element
  end

  it "should raise an exception when the element can't be found'" do
    launch_web_driver TEST_PAGE_URL
    test_page = TestPage.new(driver)
    TestPage.element :not_a_element, {:id => "not a element"}
    expect { test_page.not_a_element }.to raise_exception RuntimeError, "Could not find element not_a_element"
  end

  describe "#element_list" do
    context 'when there are elements found' do
      it "should return an array of Selenium::WebDriver::Elements" do
        launch_web_driver TEST_PAGE_URL
        test_page = TestPage.new(driver)
        test_page.listings.should be_an Array
      end
    end
    context 'when there are not elements found' do
      it "should i dunno" do
        launch_web_driver TEST_PAGE_URL
        test_page = TestPage.new(driver)
        TestPage.element_list :cats, { id: 'meow' }
        expect { test_page.cats }.to raise_error RuntimeError
      end
    end
  end
end
