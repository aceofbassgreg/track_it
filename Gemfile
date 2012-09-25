source 'https://rubygems.org'

gem 'rails', '3.2.1'
gem 'haml-rails'

# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'

gem 'json'

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'
  gem 'uglifier', '>= 1.0.3'
  gem 'twitter-bootstrap-rails'
end

gem 'jquery-rails'
gem 'devise'

group :development, :test do 
  gem 'sqlite3'
  gem 'rspec-rails'
end
group :test do
  gem "factory_girl_rails"
  gem 'capybara'
  gem 'guard-rspec'
end

group :production do
  gem 'pg'
end