# frozen_string_literal: true

begin
  require 'bundler/setup'
rescue LoadError
  puts 'You must `gem install bundler` and `bundle install` to run rake tasks'
end

require 'engine_cart/rake_task'
require 'rspec/core/rake_task'
require 'rubocop/rake_task'

Bundler::GemHelper.install_tasks

desc 'Run style checker'
RuboCop::RakeTask.new(:rubocop) do |task|
  task.fail_on_error = true
end

RSpec::Core::RakeTask.new(:spec)

desc 'Generate the engine_cart and run specs'
task ci: [:rubocop, 'engine_cart:generate'] do
  puts 'running continuous integration'
  Rake::Task['spec'].invoke
end

task default: :ci
