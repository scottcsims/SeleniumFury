require 'spec_helper'

describe ElementTypes::ElementHelpers::TextInputElementHelper do

  let(:test_page) { TestPage.new(driver) }
  before(:all) { launch_web_driver TEST_PAGE_URL }
  after(:all) { stop_web_driver }

  it 'should clear and write text' do
    text = 'Hey buddy'
    test_page.textarea_element.send_keys(text)
    test_page.textarea_element.value.should == text
  end

  it 'should write text without clearing' do
    existing_text = test_page.textarea_element.value
    new_text = 'Hey buddy'
    test_page.textarea_element.send_keys!(new_text)
    test_page.textarea_element.value.should == existing_text+new_text
  end
end
