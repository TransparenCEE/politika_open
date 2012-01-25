source 'http://gemcutter.org'

gem 'rails', '~> 3.2.0'

gem 'haml'
gem 'mongo'#, '1.1.2'
gem 'bson_ext'#, '1.1.2'
gem 'mongoid'#,  :git => 'git://github.com/vojto/mongoid.git'
gem 'prawn'
gem 'rmagick', :require => false
gem 'kaminari'

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