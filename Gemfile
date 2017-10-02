source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

gem 'rails'
gem 'pg'
gem 'puma'
gem 'sass-rails'
gem 'uglifier'
gem 'coffee-rails'
gem 'jquery-rails'
gem 'turbolinks'
gem 'jbuilder'
gem 'config'
gem 'devise'
gem 'haml'
gem 'haml-rails'
gem 'jquery-tablesorter'
gem 'jquery-turbolinks'
gem "chartkick"
gem "select2-rails"
gem "selectize-rails"


group :development, :test do
  gem 'byebug', platform: :mri
end

group :development do
  gem 'web-console'
  gem 'listen'
  gem 'spring'
  gem 'spring-watcher-listen'
  gem 'pry'
end

gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
