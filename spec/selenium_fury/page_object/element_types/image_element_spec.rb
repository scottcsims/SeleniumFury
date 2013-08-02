require 'spec_helper'

describe ElementTypes::ImageElement do
  let(:test_page) { TestPage.new(driver) }
  before(:all) { launch_web_driver TEST_PAGE_URL }
  after(:all) { stop_web_driver }

  it 'should return the alternate text for an image' do
    test_page.input_image_element.text.should == 'input image'
  end

  it 'should return the source of an image' do
    test_page.input_image_element.attribute('src').include?('test_page/spacer.gif')
  end
end