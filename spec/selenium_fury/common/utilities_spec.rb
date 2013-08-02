require 'spec_helper'

describe SeleniumFury::Utilities do
  it "should go to a page using start_web_driver" do
    begin
      start_web_driver TEST_PAGE_URL
      driver.current_url.should include '/spec/test_page/test_page.html'
      driver.title.should eql 'SeleniumFury Test Page'
    ensure
      stop_web_driver
    end
  end

  it "should throw exception when trying to open a second browser with the same key" do
    begin
      start_web_driver TEST_PAGE_URL
      expect { start_web_driver TEST_PAGE_URL }.
          to raise_exception(RuntimeError, 'Cannot open a second browser with the same key.')
    ensure
      stop_web_driver
    end
  end

  it "should close all open browsers" do
    start_web_driver TEST_PAGE_URL, :b1
    start_web_driver TEST_PAGE_URL, :b2
    drivers.should_not be_empty
    stop_all_web_drivers
    drivers.should be_empty
  end
end