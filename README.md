# Test Project

Using **Ruby 2.3.1** and **Rails 5.0.1**

**Only configured for development and test environments !!**

  * Devise for authentication
  * Cancancan for permissions
  * RSpec for tests suite
  * Bootstrap (sass) for stylesheets

## Installation

    git clone git@github.com:cyb-/PayDev.git && cd PayDev
    bundle install


### Development


    bundle exec rake db:migrate && rails s


### Test


    bundle exec rake spec
