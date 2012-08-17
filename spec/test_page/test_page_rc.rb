class TestPageRc
  def initialize *browser
    @browser = *browser
    @form = "form"
    @input_button = "input_button"
    @input_checkbox = "input_checkbox"
    @input_file = "input_file"
    @input_hidden = "input_hidden"
    @input_image = "input_image"
    @input_message = "input_message"
    @input_msg_button = "input_msg_button"
    @input_password = "input_password"
    @input_radio = "input_radio"
    @input_reset = "input_reset"
    @input_submit = "input_submit"
    @input_text = "input_text"
    @select = "select"
    @textarea = "textarea"
  end
  attr_accessor :browser, :form, :input_button, :input_checkbox, :input_file,
                :input_hidden, :input_image, :input_message, :input_msg_button, :input_password,
                :input_radio, :input_reset, :input_submit, :input_text, :select,
                :textarea

end