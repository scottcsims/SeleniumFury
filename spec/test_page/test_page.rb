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

  element_list :listings, { css: 'li.listing' }


  generic_element       :form_element, {id: 'form'}
  generic_element       :input_file_element, {id: 'input_file'}
  generic_element       :input_hidden_element, {id: 'input_hidden'}
  generic_element       :message_element, {id: 'message'}
  generic_element       :message_text_element, {name: 'msgtext'}
  generic_element       :fieldset_element, {css: 'fieldset'}
  generic_element       :listings_element, {css: 'li.listing'}
  generic_element       :not_visible_element, {id: 'not_visible'}

  checkbox_element      :input_checkbox_element, {id: 'input_checkbox'}

  drop_down_element     :select_element, {id: 'select'}

  image_element         :input_image_element, {id: 'input_image'}

  link_element          :link_element, {id: 'link111111'}
  link_element          :dynamic_locator_css, {css: "a[:locator:='link:id:']"}
  link_element          :dynamic_locator_id, {id: 'link:id:'}

  radio_button_element  :input_radio_element, {id: 'input_radio'}

  submit_element        :input_button_element, {id: 'input_button'}
  submit_element        :input_msg_button_element, {id: 'input_msg_button'}
  submit_element        :input_reset_element, {id: 'input_reset'}
  submit_element        :input_submit_element, {id: 'input_submit'}

  text_element          :input_message_label_element, {css: 'label'}

  text_input_element    :input_message_element, {id: 'input_message'}
  text_input_element    :input_password_element, {id: 'input_password'}
  text_input_element    :input_text_element, {id: 'input_text'}
  text_input_element    :textarea_element, {id: 'textarea'}


  def click_check_box
    input_checkbox.click
  end
end