require 'spec_helper'

describe SeleniumFury::Utilities do
  it "should go to a page using launch_web_driver" do
    begin
      launch_web_driver TEST_PAGE_URL
      driver.current_url.should include '/spec/test_page/test_page.html'
      driver.title.should eql 'SeleniumFury Test Page'
    ensure
      stop_web_driver
    end
  end
end