source 'https://rubygems.org'
ruby '2.3.1'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end


gem 'rails',                    '~> 5.0.1'

gem 'bootstrap-sass'
gem 'cancancan'
gem 'coffee-rails',             '~> 4.2'
gem 'devise',                   '~> 4.2'
gem 'devise-i18n'
gem 'devise_invitable',         '~> 1.7.0'
gem 'exception_handler',        '~> 0.7.0'
gem 'jbuilder',                 '~> 2.5'
gem 'jquery-rails'
gem 'puma',                     '~> 3.0'
gem 'rails-i18n'
gem 'sass-rails',               '~> 5.0'
gem 'simple_form'
gem 'sqlite3'
gem 'turbolinks',               '~> 5'
gem 'uglifier',                 '>= 1.3.0'

group :development, :test do
  gem 'byebug', platform: :mri
  gem 'factory_girl_rails'
  gem 'faker'
  gem 'rails-controller-testing'
  gem 'rspec-rails'
end

group :development do
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'listen',                 '~> 3.0.5'
  gem 'spring'
  gem 'spring-watcher-listen',  '~> 2.0.0'
  gem 'web-console',            '>= 3.3.0'
end

group :test do
  gem 'capybara'
  gem 'database_cleaner'
  gem 'launchy'
  gem 'selenium-webdriver'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
