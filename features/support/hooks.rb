After do
  browser.close_current_browser_session unless(browser.nil? || browser.session_id.nil?)
  driver.quit unless driver.nil?
end
