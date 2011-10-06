class PageObject
  include PageObjectComponents
  include CreateSeleniumWebDriver

  def initialize *driver
    @driver = *driver
  end

  def driver
    @driver
  end
end
