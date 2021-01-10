source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

gem 'rails', '6.1.1'
gem 'puma', '~> 5.1'
gem 'sass-rails', '~> 6.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 5.0'
gem 'turbolinks', '~> 5'
gem 'jbuilder', '~> 2.10'

group :development, :test do
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'capybara', '~> 3.34'
  gem 'selenium-webdriver'
end

group :development do
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.5'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]

gem 'nokogiri', '>= 1.8.2'

gem 'twitter'
gem 'mysql2'
gem 'whenever', require: false # cron on Rails
gem 'kaminari'
gem 'dotenv-rails'
