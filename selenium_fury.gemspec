# -*- encoding: utf-8 -*-
require File.expand_path('../lib/selenium_fury/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Scott Sims"]
  gem.email         = ["ssims98@gmail.com"]
  gem.description   = %q{Generate and validate page objects with this page object factory for Selenium.}
  gem.summary       = %q{Generate Selenium Page Objects}
  gem.homepage      = "https://github.com/scottcsims/SeleniumFury"
  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "selenium_fury"
  gem.require_paths = ["lib"]
  gem.version       = SeleniumFury::VERSION
  gem.add_dependency('selenium-webdriver','~> 2')
  gem.add_dependency('nokogiri','~> 1')
  gem.add_development_dependency('rspec','~>2.12')
  gem.add_development_dependency('cucumber')
  gem.add_development_dependency('redcarpet')
  gem.add_development_dependency('rake')
  gem.add_development_dependency('json', '~> 1.7.7')
  gem.add_development_dependency('parallel_tests')
end
