require 'spec_helper'

describe ElementTypes::ElementHelpers::WaitElementHelper do

  let(:test_page) { TestPage.new(driver) }
  before(:all) { launch_web_driver TEST_PAGE_URL }
  after(:all) { stop_web_driver }

  class TestPage < PageObject
    generic_element :not_a_element, {id: 'not a element'}
    generic_element :not_visible, {id: 'not_visible'}
  end

  context 'With implicit waits' do
    it 'should error immediately with traditional element check and implicit wait not set' do
      start_time = Time.now
      expect { driver.find_element(id: 'not a element') }.
          to raise_exception(Selenium::WebDriver::Error::NoSuchElementError)
      (Time.now-start_time).should < 1
    end

    it 'should error after waiting the time set by implicit wait' do
      driver.manage.timeouts.implicit_wait = 2

      start_time = Time.now
      expect { driver.find_element(id: 'not a element') }.
          to raise_exception(Selenium::WebDriver::Error::NoSuchElementError)
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
          to raise_exception(Selenium::WebDriver::Error::NoSuchElementError)
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