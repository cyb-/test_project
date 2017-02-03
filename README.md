# Test Project

Using **Ruby 2.3.1** and **Rails 5.0.1**

**Only configured for development and test environments !!**
You need your postfix configured to send emails.

  * Devise for authentication
  * Cancancan for permissions
  * RSpec for tests suite
  * Bootstrap (sass) for stylesheets
  * SQLite3 as database

## Installation

    git clone git@github.com:cyb-/test_project.git && cd test_project
    bundle install


### Development


    bundle exec rake db:migrate && rails s


### Test

**You need to install `geckodriver` in your path to run selenium-webdrier**


    bundle exec rake spec
