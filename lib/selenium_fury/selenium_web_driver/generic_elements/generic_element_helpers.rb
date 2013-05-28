module GenericElementHelpers
  def el
    raise "Locator at #{location} is not present" unless present?
    @driver.find_element(location)
  end

  def present?
    list.size > 0
  end

  def visible?
    el.displayed?
  end

  def list
    @driver.find_elements(location)
  end

  def value
    el.attribute('value')
  end

  # Use any methods from WebDriverElement not present
  def method_missing method_sym, *args
    if el.respond_to?(method_sym)
      el.send(method_sym, *args)
    else
      raise NoMethodError, "No such  method #{method_sym} for #{self.class}"
    end
  end
end

module ElementWaitHelpers
  def web_driver_wait(opt=10, &condition)
    options={}
    opt.kind_of?(Integer) ? options[:timeout] = opt : options = opt
    Selenium::WebDriver::Wait.new(options).until { condition.call }
  end

  def wait_present(timeout)
    web_driver_wait(timeout) { present? }
  end

  def wait_visible(timeout)
    web_driver_wait(timeout) { visible? }
  end

  def wait_not_present(timeout)
    web_driver_wait(timeout) { !present? }
  end

  def wait_not_visible(timeout)
    web_driver_wait(timeout) { !visible? }
  end
end

module CheckboxElementHelpers
  def checked(be_selected=true)
    select unless be_selected == selected?
  end
end


module DropDownHelpers
  def selected_option
    Selenium::WebDriver::Support::Select.new(el).first_selected_option.text
  end

    # how can be :text, :index, :value
  def select_option(how=nil, what=nil)
    raise "Locator at #{location} can not be interacted with" unless visible?
    el.click if how.nil?
    Selenium::WebDriver::Support::Select.new(el).select_by(how, what)
  end
end

module ImageElementHelpers
  def text
    attribute('alt')
  end

  def source
    attribute('src')
  end
end

module LinkElementHelpers
  def link
    attribute('href')
  end
end


module SelectableElementHelpers
  def select
    raise "Locator at #{location} can not be interacted with" unless visible?
    el.click
  end

  def selected?
    el.selected?
  end
end

module TextElementHelpers
  def send_keys(text)
    raise "Locator at #{location} can not be interacted with" unless visible?
    el.clear
    el.send_keys(text)
  end

  def send_keys!(text)
    raise "Locator at #{location} can not be interacted with" unless visible?
    el.send_keys(text)
  end
end
