require 'spec_helper'

describe ElementTypes::ElementHelpers::SelectableElementHelper do
  let(:wait_element) { WaitElement.new(driver) }
  let(:test_page) { TestPage.new(driver) }
  before(:all) { launch_web_driver TEST_PAGE_URL }
  after(:all) { stop_web_driver }

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
    expect { wait_element.not_visible.select! }.
        to raise_exception(RuntimeError, "Locator at #{wait_element.not_visible.location.to_s} is not visible")
  end

  it 'should throw timeout error if element to select is not visible and ! is not specified' do
    expect { wait_element.not_visible.select }.
        to raise_exception(Selenium::WebDriver::Error::TimeOutError)
  end
end
