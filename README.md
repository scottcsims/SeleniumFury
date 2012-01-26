SeleniumFury
=========
 Selenium Fury helps you quickly build page objects when using either Selenium RC API or Selenium Web Driver API.
 
Demo Setup
=========
If you are running the demo from the source.

```ruby
bundle console
require 'spec/spec_helper'
```

If you are running the demo from the installed gem

```ruby
irb
require 'selenium_fury'
include SeleniumFury::SeleniumWebDriver::CreateSeleniumWebDriver
```

Quick Test Demo
=========
```ruby
launch_web_driver("http://www.homeaway.com/")
home_page=get_page_object(driver,'HomePage')
home_page.search_keywords.send_keys 'Destin'
home_page.keyword_submit.click
driver.quit
```

Generate Demo
=========
```ruby
launch_web_driver("http://www.homeaway.com/")
generate(driver)
driver.quit
```
Validate Demo
=========
```ruby
launch_web_driver("http://www.homeaway.com/")
get_page_object(driver,'HomePage')
web_driver_validate(HomePage)
driver.quit
```
 * [Scott Sims](http://scottcsims.com/): Current maintainer.

Copyright
=========
* Copyright (c) 2012 HomeAway, Inc.
* All rights reserved.  http://www.homeaway.com
  See LICENSE for details.
