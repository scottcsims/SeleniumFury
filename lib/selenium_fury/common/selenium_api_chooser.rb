module SeleniumFury
  module SeleniumApiChooser
    def generate(selenium_api_object)
      if selenium_api_object.class == Selenium::Client::Driver
        return SeleniumFury::SeleniumClient::PageGenerator.get_source_and_print_elements(selenium_api_object)
      end
      if selenium_api_object.class == Selenium::WebDriver::Driver
        return SeleniumFury::SeleniumWebDriver::PageGenerator.web_driver_generate(selenium_api_object)
      end
    end

    def validate(page_object, *live_url)
      unless browser.nil?
        return check_page_file_class(page_object,*live_url)
      end
      unless driver.nil?
        return SeleniumFury::SeleniumWebDriver::PageValidator.web_driver_validate(page_object)
      end
    end

  end
end