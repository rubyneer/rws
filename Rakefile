# frozen_string_literal: true

require 'bundler/gem_tasks'
require 'rspec/core/rake_task'
require 'rubocop/rake_task'

task default: %i[lint spec]

task :lint do
  RuboCop::RakeTask.new(:lint)
end

task :spec do
  RSpec::Core::RakeTask.new(:spec)
end
