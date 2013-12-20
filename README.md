MedischRekenenArcade
====================

[![Build Status](https://magnum.travis-ci.com/DefactoSoftware/MedischRekenenArcade.png?token=DyMYzapeFyRPapys4APx&branch=development)](https://magnum.travis-ci.com/DefactoSoftware/MedischRekenenArcade)


**System dependencies:**
- Ruby 2.0 (install with [rbenv](https://github.com/sstephenson/rbenv))
- Rubygems
- Bundler (`gem install bundler`)
- PostgreSQL (http://postgresapp.com/)
- Redis (http://redis.io/download or `brew install redis` on OSX)

**Setup:**
- run `bundle install`
- setup config/database.yml (use database.yml.example as base)
- run `createdb mra_development` to create the development database
- run `createdb mra_test` to create the test database
- run `rake db:setup && rake db:migrate` to set up the development db (make sure to have postgres running)
- run `rake db:test:prepare` to set up the test db

**Running things:**
- Launch redis: (`redis-server`)
- To start the server run `rails server` or `rails s`, this will launch the app on port 3000
- To run the specs run `rake spec` or `rspec`, to run a single file you can `rspec /path/to/your/file`
- To have Guard automatically listen for file changes and run the appropriate specs run `bundle exec guard` from the app root
- To generate the model annotations run `bundle exec annotate`

**Housekeeping**
- Write specs!
- Development happens on the `development` branch only, if something is finished open a pull-request to master. Master should always be ready for deployment.
- For major changes please make a new branch and open a pull-request to development
- Please adhere to the [Github ruby styleguide](https://github.com/styleguide/ruby)

- All code and commit messages should be in English
- Commit messages are written in the imperative with a short, descriptive title. Good => `Add show method for users_controller`, bad => `Changed http response` or `I updated the http response on the update action in the ProblemsController because we're not showing any data there`. The first line should always be 50 characters or less and that it should be followed by a blank line.
