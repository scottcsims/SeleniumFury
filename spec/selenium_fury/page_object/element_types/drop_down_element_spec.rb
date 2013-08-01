require 'spec_helper'

describe ElementTypes::DropDownElement do

  let(:test_page) { TestPage.new(driver) }

  before(:all) do
    launch_web_driver TEST_PAGE_URL
  end

  after(:all) do
    stop_web_driver
  end

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