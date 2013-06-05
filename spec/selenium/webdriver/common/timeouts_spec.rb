require 'spec_helper'

describe Selenium::WebDriver::Timeouts do

  it 'should allow reading of implict wait' do
    launch_web_driver
    driver.manage.timeouts.implicit_wait.should == 0
    driver.manage.timeouts.implicit_wait = 2
    driver.manage.timeouts.implicit_wait.should == 2
  end
end