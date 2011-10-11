class InquirySideBar < PageObject
  element :first_name, {:id=>"sidebar-inquirerFirstName"}
  element :last_name, {:id=>"sidebar-inquirerLastName"}
  element :email_address, {:id=>"sidebar-inquirerEmailAddress"}
  element :submit_button, {:id=>"sidebar-submit-btn"}
  element :phone_number, {:id=>"sidebar-inquirerPhoneNumber"}
  element :confirmation_message, {:class=>"confirmation-message"}
end