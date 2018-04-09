source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end
gem 'devise'
gem 'pg', '>= 0.18', '< 2.0'
gem 'puma', '~> 3.7'
gem 'rails', '~> 5.1.5'
gem 'rails_autolink'
gem 'turbolinks', '~> 5'
gem 'twitter'
gem 'jbuilder', '~> 2.5'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'jquery-turbolinks'
gem 'slim'
gem 'sendgrid-ruby'
gem 'html2slim'
gem 'rubyzip', '>= 1.2.1'
gem 'axlsx', git: 'https://github.com/randym/axlsx.git', ref: 'c8ac844'
gem 'axlsx_rails'
gem 'sidekiq'

# Use SCSS for stylesheets
gem 'bootstrap-sass'
gem 'coffee-rails', '~> 4.2'
gem 'feathericon-sass'
gem 'font-awesome-rails'
gem 'font-awesome-sass', '~> 4.7.0'
gem 'jquery-rails'
gem 'popper_js', '~> 1.12.9'
gem 'sprockets-rails', require: 'sprockets/railtie'
gem 'will_paginate'
gem 'gravatar_image_tag'



group :development, :test do
  gem 'annotate'
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'capybara', '~> 2.13'
  gem 'database_cleaner'
  gem 'factory_bot_rails'
  gem 'faker', :git => 'https://github.com/stympy/faker.git', :branch => 'master'
  gem 'pry'
  gem 'rails-controller-testing'
  gem 'rspec-rails', '~> 3.7'
  gem 'selenium-webdriver'
  gem 'shoulda-matchers', '~> 3.1'
end

group :development do
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'web-console', '>= 3.3.0'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
