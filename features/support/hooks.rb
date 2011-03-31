After do
  browser.close_current_browser_session if defined?(browser) && !browser.nil?
end
