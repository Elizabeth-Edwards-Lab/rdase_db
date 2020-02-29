source 'https://rubygems.org'
ruby '~> 2.5'

# git_source(:github) do |repo_name|
#   repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
#   "https://github.com/#{repo_name}.git"
# end

gem 'rails', '~> 5.2.0'
gem 'mysql2', '~> 0.4.9'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.2'
gem 'turbolinks', github: 'turbolinks/turbolinks-classic'
gem 'jbuilder', '~> 2.5'
gem 'slim-rails'
gem 'jquery-rails'
#gem 'sass-rails', '~> 5.0'
gem 'bootstrap-kaminari-views'
gem 'bootstrap', '~> 4.3.1'
gem 'popper_js', '~> 1.14.5'
gem 'bio'
gem 'whenever', require: false
gem 'kaminari'
gem 'recaptcha'
#gem 'will_paginate', '~> 3.1.0'
gem 'rubyzip'
gem 'font-awesome-sass', '~> 5.11.1'
gem 'mail_form'

# activeadmin
gem 'activeadmin'
gem 'devise'
gem 'cancancan'
gem 'draper'
gem 'pundit'

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
#gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]

group :production do
  gem 'newrelic_rpm'
  gem 'nokogiri'
  gem 'execjs'
  gem 'libv8', '~> 7.3.492'
  gem 'mini_racer', '0.2.6'
  gem "puma", ">= 4.3.2" 
  gem 'puma_worker_killer'
end

group :development do
  gem 'awesome_print'
  gem "capistrano"
  gem 'capistrano-rails'
  gem 'capistrano-bundler'
  gem 'capistrano-rbenv'
  gem 'capistrano-sidekiq'
  gem 'thin'
  gem 'better_errors'
  gem 'binding_of_caller'
  #gem 'syncfast', git: 'git@bitbucket.org:wishartlab/syncfast'
  # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
  #gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

group :test do
  gem 'turn', require: false # Pretty printed test output
  gem 'minitest'
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  # Adds support for Capybara system testing and selenium driver
  gem 'capybara', '>= 2.15'
  gem 'selenium-webdriver'
  gem 'rspec-rails', '~> 3.8'
end
