source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?('/')
  "https://github.com/#{repo_name}.git"
end

gem 'coffee-rails'
gem 'dotenv-rails'
gem 'jbuilder'
gem 'kaminari'
gem 'mysql2'
gem 'nokogiri'
gem 'puma'
gem 'rails', '6.1.6.1'
gem 'sass-rails'
gem 'turbolinks'
gem 'twitter'
gem 'uglifier'
gem 'whenever', require: false

group :development, :test do
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  gem 'capybara'
  gem 'selenium-webdriver'
end

group :development do
  gem 'listen'
  gem 'spring'
  gem 'spring-watcher-listen'
  gem 'web-console'
end
