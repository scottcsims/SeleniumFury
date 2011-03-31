require File.dirname(__FILE__) + "/spec_helper"
module CreateBrowserDriver

  def browser
    return @browser
  end

  Spec::Runner.configure do |config|
    config.after(:each) do
      browser.close_current_browser_session if defined?(browser) && !browser.nil?
    end
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