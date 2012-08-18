module SeleniumFury
  module SeleniumApiChooser
    def generate(selenium_api_object)
      if selenium_api_object.class == Selenium::Client::Driver
        return get_source_and_print_elements(selenium_api_object)
      end
      if selenium_api_object.class == Selenium::WebDriver::Driver
        return web_driver_generate(selenium_api_object)
      end
    end

    def validate(page_object, live_url = nil)
      if browser
        return check_page_file_class(page_object, live_url)
      else
        return web_driver_validate(page_object)
      end
    end

  end
end