require 'spec_helper'

describe PageObject do

  let(:test_page) { TestPage.new(driver) }

  before(:each) do
    load 'test_page/test_page.rb'
    launch_web_driver TEST_PAGE_URL
  end

  describe 'Dynamic Locators' do

    it 'should allow a single dynamic selection of an element with id' do
      specific_element = test_page.dynamic_locator_id.update_locator(id: 222222)
      specific_element.location.should == {id: 'link222222'}
      specific_element.link.should == 'http://yahoo.com/'
    end

    it 'should allow multiple dynamic selections of an element with css' do
      specific_element = test_page.dynamic_locator_css.update_locator(locator: 'id', id: 333333)
      specific_element.location.should == {css: "a[id='link333333']"}
      specific_element.link.should == 'http://google.com/'
    end

    it 'should allow changing the selector to allow for different selections with the same element' do
      specific_element = test_page.dynamic_locator_css.update_locator(locator: 'id', id: 333333)
      specific_element.location.should == {css: "a[id='link333333']"}
      specific_element.link.should == 'http://google.com/'
      specific_element = test_page.dynamic_locator_css.update_locator(locator: 'id', id: 222222)
      specific_element.location.should == {css: "a[id='link222222']"}
      specific_element.link.should == 'http://yahoo.com/'
    end
  end

  describe SeleniumFury::SeleniumWebDriver::PageObjectComponents::GenericElement do

    it 'should return correct object type' do
      test_page.input_checkbox_element.should be_an SeleniumFury::SeleniumWebDriver::PageObjectComponents::CheckboxElement
    end

    it 'should return correct superclass object type' do
      test_page.input_checkbox_element.should be_an SeleniumFury::SeleniumWebDriver::PageObjectComponents::GenericElement
    end

    it 'should provide location' do
      test_page.form_element.location.should == {id: 'form'}
    end

    it 'should return a web driver element' do
      test_page.form_element.el.should be_an Selenium::WebDriver::Element
    end

    it 'should find visible elements' do
      test_page.form_element.visible?.should be_true
    end

    it 'should return the value' do
      test_page.input_button_element.value.should == 'Click me'
    end

    it 'When there is more than one element with the provided locator, it should return an array of all of them' do
      test_page.listings_element.list.should be_an Array
      test_page.listings_element.list[0].should be_an Selenium::WebDriver::Element
    end

    describe Selenium::WebDriver::Element

    it 'should return the correct value of a method defined in WebDriver::Element, but not GenericElement class' do
      test_page.input_button_element.tag_name.should == 'input'
    end

    it 'should throw an WebDriver Element error when using a method not defined in either WebDriver::Element or GenericElement classes' do
      expect { test_page.input_checkbox.clickit_good }.to raise_error(NoMethodError)
    end
  end


  describe SeleniumFury::SeleniumWebDriver::PageObjectComponents::CheckboxElement do

    it 'should check a checkbox not checked' do
      test_page.input_checkbox_element.selected?.should be_false
      test_page.input_checkbox_element.checked(true)
      test_page.input_checkbox_element.selected?.should be_true
    end

    it 'should leave a checkbox checked when already checked' do
      test_page.input_checkbox_element.click
      test_page.input_checkbox_element.selected?.should be_true
      test_page.input_checkbox_element.checked(true)
      test_page.input_checkbox_element.selected?.should be_true
    end

    it 'should uncheck a checkbox when checked' do
      test_page.input_checkbox_element.click
      test_page.input_checkbox_element.selected?.should be_true
      test_page.input_checkbox_element.checked(false)
      test_page.input_checkbox_element.selected?.should be_false
    end

    it 'should leave a checkbox alone when already checked' do
      test_page.input_checkbox_element.selected?.should be_false
      test_page.input_checkbox_element.checked(false)
      test_page.input_checkbox_element.selected?.should be_false
    end
  end


  describe SeleniumFury::SeleniumWebDriver::PageObjectComponents::DropDownElement do

    it 'should select from a dropdown by value' do
      test_page.select_element.select_option(:value, 'mercedes')
      test_page.select_element.selected_option.should == 'Mercedes'
    end

    it 'should select from a dropdown by text' do
      what = 'Mercedes'
      test_page.select_element.select_option(:text, what)
      test_page.select_element.selected_option.should == what
    end

    it 'should select from a dropdown by index' do
      test_page.select_element.select_option(:index, 3)
      test_page.select_element.selected_option.should == 'Audi'
    end
  end


  describe SeleniumFury::SeleniumWebDriver::PageObjectComponents::ImageElement do

    it 'should return the alternate text for an image' do
      test_page.input_image_element.text.should == 'input image'
    end

    it 'should return the source of an image' do
      test_page.input_image_element.attribute('src').include?('test_page/spacer.gif')
    end
  end


  describe SeleniumFury::SeleniumWebDriver::PageObjectComponents::LinkElement do

    it 'should return the link location' do
      test_page.link_element.link.should == 'http://news.ycombinator.com/'
    end
  end


  describe SelectableElementHelpers do
    let(:wait_element) { WaitElement.new(driver) }

    class WaitElement < PageObject
      generic_element :not_a_element, {id: 'not a element'}
      selectable_element :not_visible, {id: 'not_visible'}
    end

    it 'should properly submit a form' do
      text = 'Hey buddy'
      test_page.input_message_element.send_keys(text)
      test_page.input_msg_button_element.select
      test_page.message_element.text.should == text
    end

    it 'should verify option is not selected' do
      test_page.input_checkbox_element.selected?.should be_false
    end

    it 'should verify option is selected' do
      test_page.input_checkbox_element.select
      test_page.input_checkbox_element.selected?.should be_true
    end

    it 'should throw not visible error if element to select is not visible and ! is specified' do
      expect {wait_element.not_visible.select!}.
      to raise_exception(RuntimeError, "Locator at #{wait_element.not_visible.location.to_s} is not visible")
    end

    it 'should throw timeout error if element to select is not visible and ! is not specified' do
      expect {wait_element.not_visible.select}.
      to raise_exception(Selenium::WebDriver::Error::TimeOutError)
    end
  end


  describe TextElementHelpers do

    it 'should clear and write text' do
      text = 'Hey buddy'
      test_page.textarea_element.send_keys(text)
      test_page.textarea_element.value.should == text
    end

    it 'should write text without clearing' do
      existing_text = "This is a textarea field.\n    "
      new_text = 'Hey buddy'
      test_page.textarea_element.send_keys!(new_text)
      test_page.textarea_element.value.should == existing_text+new_text
    end
  end

  describe ElementWaitHelpers do
    class TestPage < PageObject
      generic_element :not_a_element, {id: 'not a element'}
      generic_element :not_visible, {id: 'not_visible'}
    end

    context 'With implicit waits' do
      it 'should error immediately with traditional element check and implicit wait not set' do
        start_time = Time.now
        expect { driver.find_element(id: 'not a element') }.
            to raise_exception(Selenium::WebDriver::Error::NoSuchElementError, 'The element could not be found')
        (Time.now-start_time).should < 1
      end

      it 'should error after waiting the time set by implicit wait' do
        driver.manage.timeouts.implicit_wait = 2

        start_time = Time.now
        expect { driver.find_element(id: 'not a element') }.
            to raise_exception(Selenium::WebDriver::Error::NoSuchElementError, 'The element could not be found')
        (Time.now-start_time).should > 2
      end

      it 'should ignore implicit wait for new element check, and reset wait after done' do
        implicit_wait = 2
        driver.manage.timeouts.implicit_wait = implicit_wait
        test_element = test_page.not_a_element
        test_element.implicit_wait = implicit_wait

        start_time = Time.now
        test_element.present?
        (Time.now-start_time).should < 1

        start_time = Time.now
        expect { driver.find_element(id: 'not a element') }.
            to raise_exception(Selenium::WebDriver::Error::NoSuchElementError, 'The element could not be found')
        (Time.now-start_time).should > 2
      end
    end

    context 'With explicit waits' do
      it 'should wait for something with wait time and message parameters set' do
        start_time = Time.now
        begin
          test_page.not_a_element.wait_for(timeout: 2, message: 'This is the message to return') { false }
          raise 'This should have failed'
        rescue Exception => e
          e.message.should == 'This is the message to return'
          time_taken = (Time.now-start_time)
          time_taken.should > 2
          time_taken.should < 10
        end
      end

      it 'should wait for something with wait time set but no message' do
        start_time = Time.now
        begin
          test_page.not_a_element.wait_for(timeout: 2) { false }
          raise 'This should have failed'
        rescue Exception => e
          e.message.should == ''
          time_taken = (Time.now-start_time)
          time_taken.should > 2
          time_taken.should < 10
        end
      end

      it 'should wait for something with message parameters set but not wait time' do
        start_time = Time.now
        begin
          test_page.not_a_element.wait_for(message: 'This is the message to return') { false }
          raise 'This should have failed'
        rescue Exception => e
          e.message.should == 'This is the message to return'
          (Time.now-start_time).should > 10
        end
      end

      it 'should wait for something with no parameters set' do
        start_time = Time.now
        begin
          test_page.not_a_element.wait_for { false }
          raise 'This should have failed'
        rescue Exception => e
          e.message.should == ''
          (Time.now-start_time).should > 10
        end
      end

      it 'should return the value in of the condition' do
        result = test_page.not_a_element.wait_for { true }
        result.should be_a TrueClass
      end

      it 'should error on missing element if specify !' do
        start_time = Time.now
        expect { test_page.not_a_element.wait_visible! }.
            to raise_exception(RuntimeError, "Locator at #{test_page.not_a_element.location.to_s} is not present")
        (Time.now-start_time).should < 1
      end

      it 'should timeout without erroring on missing element if do not specify !' do
        start_time = Time.now
        expect { test_page.not_a_element.wait_visible(2) }.
            to raise_exception(Selenium::WebDriver::Error::TimeOutError)
        time_taken = (Time.now-start_time)
        time_taken.should > 2
        time_taken.should < 10
      end

      it 'should wait for element present and not visible for !' do
        start_time = Time.now
        expect { test_page.not_visible.wait_visible(2) }.
            to raise_exception(Selenium::WebDriver::Error::TimeOutError)
        time_taken = (Time.now-start_time)
        time_taken.should > 2
        time_taken.should < 10
      end

      it 'should wait for element present and not visible without !' do
        start_time = Time.now
        expect { test_page.not_visible.wait_visible(2) }.
            to raise_exception(Selenium::WebDriver::Error::TimeOutError)
        time_taken = (Time.now-start_time)
        time_taken.should > 2
        time_taken.should < 10
      end
    end
  end
end