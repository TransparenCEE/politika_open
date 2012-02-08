source 'http://gemcutter.org'

gem 'rails', '~> 3.2.1'

gem 'haml'
gem 'mysql2'
gem 'prawn'
gem 'rmagick', :require => false
gem 'kaminari'
gem 'newrelic_rpm'
gem 'thinking-sphinx'

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
	gem 'cucumber-rails'
  gem 'launchy'    # So you can do Then show me the page
  gem 'mocha'
end

gem 'mailcatcher', group: :development