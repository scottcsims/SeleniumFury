require 'rubygems'
require 'bundler/setup'
require 'jeweler'

require 'rspec'
require 'rspec/core/rake_task'

require 'yard'
require 'yard/rake/yardoc_task'

RSpec::Core::RakeTask.new(:spec)

task :default => :spec

Jeweler::Tasks.new do |gem|
  gem.name = "selenium_fury"
  gem.description = %q{Generate and validate page objects with this page object factory for Selenium.}
  gem.summary = %q{ Selenium Fury allows an automated tester to quickly build page files to use in the page object pattern.  Each page file represents
 a page under test with attributes of all the locators selenium needs to run tests on the page and methods that represent
 actions that can be performed on the page.

 You use the generator to build the page files. After the page has been updated you can use the validator to go through
 all of the selenium locators you are using in your page file and return a list of the locators that it could not find.
 If there are missing locators you can then rerun the generator to generate new selenium locators for your page. http://www.scottcsims.com}
  gem.email = "ssims98@gmail.com"
  gem.authors = ["Scott Sims"]
  gem.homepage = "https://github.com/scottcsims/SeleniumFury"
  gem.version = '0.5.3'
  gem.add_dependency 'nokogiri'
end

YARD::Rake::YardocTask.new do |t|
  t.files = ['lib/**/*.rb']
end