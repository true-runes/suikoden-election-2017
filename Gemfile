source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?('/')
  "https://github.com/#{repo_name}.git"
end

ruby '3.4.5'

gem 'coffee-rails' # 消したいけど消せない
gem 'csv' # 要明示
gem 'dotenv-rails'
# gem 'jbuilder'
gem 'kaminari'
gem 'nokogiri'
gem 'pg'
gem 'puma'
gem 'rails'
gem 'sass-rails'
gem 'turbolinks' # 消したいけど消せない
gem 'twitter'
gem 'uglifier'
# gem 'whenever', require: false

group :development, :test do
  # gem 'byebug', platforms: %i[mri mingw x64_mingw]
  gem 'rubocop-performance', require: false
  gem 'rubocop-rails', require: false
end

group :development do
  # gem 'listen'
  # gem 'spring'
  # gem 'spring-watcher-listen'
  # gem 'web-console'
end

group :test do
  # gem 'capybara'
  # gem 'factory_bot_rails'
  gem 'rspec-rails', require: false
  # gem 'selenium-webdriver'
  # gem 'webdrivers'
end
