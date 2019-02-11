source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "2.4.2"

gem "rails", "~> 5.2.1"
gem "pg", ">= 0.18", "< 2.0"
gem "puma", "~> 3.11"
gem "turbolinks", "~> 5"

gem "bootsnap", ">= 1.1.0", require: false
gem "devise"
gem "jbuilder", "~> 2.5"
gem "sass-rails", "~> 5.0"
gem "uglifier", ">= 1.3.0"

# Fog and CarrierWave are used for uploading files to AWS, such as avatar images
gem "carrierwave"
gem "fog"
# Resizes and crops images
# You will need to install ImageMagick first in the command line:
# brew install imagemagick
gem "mini_magick"

# Kaminari for pagination
gem "kaminari"

# Pundit for authorization
gem "pundit"

group :development, :test do
  # Call "byebug" anywhere in the code to stop execution and get a debugger console
  gem "byebug", platforms: [:mri, :mingw, :x64_mingw]

  # Use dotenv for environment variables
  gem "dotenv-rails"

  # Creates dummy objects for tests
  gem "factory_bot_rails"
  # Creates dummy data
  gem "ffaker"
  # RSpec for Testing
  gem "rspec-rails", "~> 3.8"
end

group :development do
  gem "web-console", ">= 3.3.0"
  gem "listen", ">= 3.0.5", "< 3.2"
  gem "spring"
  gem "spring-watcher-listen", "~> 2.0.0"

  # Annotate models with database schema
  gem "annotate"
end

group :test do
  gem "capybara", ">= 2.15"
  gem "selenium-webdriver"
  gem "chromedriver-helper"
end

group :production do
  # For Heroku hosting
  gem "rails_12factor"
end

gem "tzinfo-data", platforms: [:mingw, :mswin, :x64_mingw, :jruby]
