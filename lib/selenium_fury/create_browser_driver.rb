module CreateBrowserDriver

  # @return [Selenium::Client::Driver]
  def browser
    return @browser
  end

    # @param url [string]
    # @return [Selenium::Client::Driver]
  def create_selenium_driver(url)

    @browser = Selenium::Client::Driver.new(
        :host => ENV['HOST'] || "localhost",
        :port => 4444,
        :browser => ENV['SELENIUM_RC_BROWSER'] || "*firefox",
        :url => url,
        :timeout_in_second => 60)
  end
end