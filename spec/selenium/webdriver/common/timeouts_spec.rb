require 'spec_helper'

describe Selenium::WebDriver::Timeouts do
  it 'should allow reading of implicit wait' do
    begin
     start_web_driver
    driver.manage.timeouts.implicit_wait.should == 0
    driver.manage.timeouts.implicit_wait = 2
    driver.manage.timeouts.implicit_wait.should == 2
    ensure
      stop_web_driver
    end
  end
end