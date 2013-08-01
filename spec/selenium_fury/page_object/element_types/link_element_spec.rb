require 'spec_helper'

describe ElementTypes::LinkElement do
  let(:test_page) { TestPage.new(driver) }

  before(:all) do
    launch_web_driver TEST_PAGE_URL
  end

  after(:all) do
    stop_web_driver
  end

  it 'should return the link location' do
    test_page.link_element.link.should == 'http://news.ycombinator.com/'
  end
end