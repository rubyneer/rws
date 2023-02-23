# frozen_string_literal: true

source 'https://rubygems.org'

git_source(:github) { |repo_name| "https://github.com/#{repo_name}" }

gemspec

group :development, :test do
  gem 'pry-byebug'
end

group :development do
  gem 'rubocop', '~> 1.46.0'
  gem 'rubocop-rspec', require: false
end

group :test do
  gem 'codecov', require: false
  gem 'rspec', '~> 3.11'
end
