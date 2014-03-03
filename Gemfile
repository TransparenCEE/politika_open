source 'https://rubygems.org'

gem 'rails', '~> 3.2.17'

gem 'haml'
gem 'mysql2'
gem 'prawn'
gem 'rmagick', require: false
gem 'kaminari'
gem 'newrelic_rpm'
gem 'thinking-sphinx'
gem 'whenever', require: false

gem 'mongo'
gem 'bson_ext'

group :production do
  gem 'therubyracer'
end

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails'
  gem 'coffee-rails'
  gem 'uglifier'
end

gem 'jquery-rails'

gem 'capistrano'
gem 'capistrano-ext'

group :development, :test do
  gem 'rspec-rails'

  gem 'database_cleaner'
  gem 'capybara'
  gem 'cucumber-rails', require: false
  gem 'launchy'    # So you can do Then show me the page
  gem 'mocha'
end

group :development do
  gem 'mailcatcher'
  gem 'rails-erd'
end
