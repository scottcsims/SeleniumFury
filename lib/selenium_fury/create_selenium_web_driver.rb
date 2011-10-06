module CreateSeleniumWebDriver

  # @return [Selenium::WebDriver::Driver]
  def driver
    return @driver
  end

  # @param url [string]
  # @return [Selenium::WebDriver::Driver]
  def launch_site url
    @driver = Selenium::WebDriver.for :firefox
    @driver.navigate.to url
  end
end
