module GenericElementHelpers
  def el
    raise "Locator at #{location} is not present" unless present?
    @driver.find_element(location)
  end

  def list_elements
    (1..list.size).map { |i| self.class.new({css: location[:css]+":nth-of-type(#{i})"}, @driver) }
  end

  def present?
    # Set implicit wait to zero so it doesn't wait that time each method call
    implicit_wait = driver.manage.timeouts.implicit_wait
    driver.manage.timeouts.implicit_wait = 0
    present = list.size > 0
    driver.manage.timeouts.implicit_wait = implicit_wait
    present
  end

  # Raises error if not already present
  def visible?
    el.displayed?
  end

  def list
    @driver.find_elements(location)
  end

  def value
    el.attribute('value')
  end

  def move_to
    @driver.action.move_to(el).perform
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
  def wait_for(opts={}, &condition)
    opts[:timeout] ||= @wait
    opts[:message] ||= ''
    Selenium::WebDriver::Wait.new(opts).until { condition.call }
  end

  def wait_present(timeout=@wait)
    wait_for(timeout: timeout, message: "Element at #{location} is not present") { present? }
  end

  def wait_not_present(timeout=@wait)
    wait_for(timeout: timeout, message: "Element at #{location} is still present") { !present? }
  end

  def wait_visible(timeout=@wait)
    wait_present(timeout)
    wait_visible!(timeout)
  end

  # Raises error if not present
  def wait_visible!(timeout=@wait)
    wait_for(timeout: timeout, message: "Element at #{location} is not visible") { visible? }
  end

  def wait_not_visible(timeout=@wait)
    wait_for(timeout: timeout, message: "Element at #{location} is still visible") { !present? || !visible? }
  end

  # Raises error if not present
  def wait_not_visible!(timeout=@wait)
    wait_for(timeout: timeout, message: "Element at #{location} is still visible") { !visible? }
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
    el.attribute('alt')
  end

  def source
    el.attribute('src')
  end
end

module LinkElementHelpers
  def link
    el.attribute('href')
  end
end

module SelectableElementHelpers

  def selected?
    el.selected?
  end

  # Raises error if not selectable
  def select!
    raise "Locator at #{location} is not visible" unless visible?
    begin
      el.click
    rescue
      raise "Locator at #{location} can not be interacted with" unless visible?
    end
    check_errors
  end

  def select
    wait_visible
    begin
      el.click
    rescue Exception => e
      retry_select(e)
    end
    check_errors
  end

  # Overwrite in your project if desired
  def check_errors;
  end

  def retry_select(exception)
    raise "Locator at #{location} can not be interacted with - Failed with #{exception}"
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
