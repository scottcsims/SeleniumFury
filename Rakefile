#!/usr/bin/env rake
require 'rspec'
require 'rspec/core/rake_task'
require 'cucumber'
require 'cucumber/rake/task'

require "bundler/gem_tasks"
require 'parallel_tests/tasks'

RSpec::Core::RakeTask.new(:spec)
Cucumber::Rake::Task.new(:feature)

task :default => :spec


