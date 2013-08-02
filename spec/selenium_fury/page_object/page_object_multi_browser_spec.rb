require 'spec_helper'

describe 'PageObject Integration Tests' do

  it 'two page objects; two browser; not the same' do
    begin
      foo = start_web_driver 'http://www.google.com', :b1
      bar = start_web_driver 'http://www.yahoo.com', :b2
      page1 = TestPage.new(driver(:b1))
      page2 = TestPage.new(driver(:b2))

      page1.driver.should eql foo
      page2.driver.should eql bar
      page1.driver.current_url.should_not eql page2.driver.current_url

      page1.driver.current_url.should eql 'http://www.google.com/'
      page2.driver.current_url.should eql 'http://www.yahoo.com/'

    ensure
      stop_all_web_drivers
    end
  end

end
