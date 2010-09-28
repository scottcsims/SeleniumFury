class PropertyPage
  def initialize *browser
    @browser = *browser
    @comments = "comments"
    @end_date_input = "endDateInput"
    @exchange_rate = "exchangeRate"
    @inquirer_email_address = "inquirerEmailAddress"
    @inquirer_first_name = "inquirerFirstName"
    @inquirer_last_name = "inquirerLastName"
    @inquirer_phone_country_code = "inquirerPhoneCountryCode"
    @inquirer_phone_number = "inquirerPhoneNumber"
    @keyword_search_form = "keywordSearchForm"
    @number_of_children = "numberOfChildren"
    @number_of_guests = "numberOfGuests"
    @pick_currency = "pickCurrency"
    @property_inquiry_form = "propertyInquiryForm"
    @search_keywords = "searchKeywords"
    @start_date_input = "startDateInput"
    @submit_button = "submitButton"
  end

  attr_accessor :browser, :comments, :end_date_input, :exchange_rate, :inquirer_email_address, :inquirer_first_name,
                :inquirer_last_name, :inquirer_phone_country_code, :inquirer_phone_number, :keyword_search_form,
                :number_of_children, :number_of_guests, :pick_currency, :property_inquiry_form, :search_keywords,
                :start_date_input, :submit_button
end

