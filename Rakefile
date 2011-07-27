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
    gem.summary = "Selenium Page Object Factory"
    gem.email = "ssims98@gmail.com"
    gem.authors = [ "Scott Sims"]
end

YARD::Rake::YardocTask.new do |t|
  t.files   = ['lib/**/*.rb']
end