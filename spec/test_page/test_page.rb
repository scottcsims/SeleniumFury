class TestPage < PageObject
  element :form, {:id => "form"}
  element :input_button, {:id => "input_button"}
  element :input_checkbox, {:id => "input_checkbox"}
  element :input_file, {:id => "input_file"}
  element :input_hidden, {:id => "input_hidden"}
  element :input_image, {:id => "input_image"}
  element :input_message, {:id => "input_message"}
  element :input_msg_button, {:id => "input_msg_button"}
  element :input_password, {:id => "input_password"}
  element :input_radio, {:id => "input_radio"}
  element :input_reset, {:id => "input_reset"}
  element :input_submit, {:id => "input_submit"}
  element :input_text, {:id => "input_text"}
  element :select, {:id => "select"}
  element :textarea, {:id => "textarea"}

  def click_check_box
    input_checkbox.click
  end
end