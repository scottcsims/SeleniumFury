gem "selenium-client", ">=1.2.18"
require "selenium/client"
module CreateBrowserDriver
  def browser
    return @browser
  end

  def page
    return @browser
  end

  def create_selenium_driver(url)

    @browser = Selenium::Client::Driver.new(
            :host => ENV['HOST'] || "localhost",
            :port => 4444,
            :browser => ENV['SELENIUM_RC_BROWSER'] || "*firefox",
            :url => url,
            :timeout_in_second => 60)
  end
end