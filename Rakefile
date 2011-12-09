require 'rubygems'
require 'bundler/setup'
require 'jeweler'

require 'rspec'
require 'rspec/core/rake_task'

require 'yard'
require 'yard/rake/yardoc_task'

require 'cucumber'
require 'cucumber/rake/task'


RSpec::Core::RakeTask.new(:spec)

Cucumber::Rake::Task.new(:feature) do |task|
  task.cucumber_opts = ["features"]
end

task :default do
  system "rake -T"
end

YARD::Rake::YardocTask.new do |t|
  t.files = ['lib/**/*.rb']
end

namespace :gem do
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
    gem.authors = ["Scott Sims", "Tim Tischler"]
    gem.homepage = "https://github.com/scottcsims/SeleniumFury"
    gem.add_dependency 'nokogiri'
  end

  desc 'Push gem to gem server'
  task 'release' => ['gem:build', 'gem:git:release'] do
    jeweler = Rake.application.jeweler
    gemspec = jeweler.gemspec
    command = "gem push pkg/#{gemspec.name}-#{jeweler.version}.gem"
    puts "Executing #{command.inspect}:"
    system command
  end
end
