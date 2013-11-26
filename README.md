MedischRekenenArcade
====================

[![Build Status](https://magnum.travis-ci.com/DefactoSoftware/MedischRekenenArcade.png?token=A49pyqNGPBpMX52bcsLm)](https://magnum.travis-ci.com/DefactoSoftware/MedischRekenenArcade)

**System dependencies:**
- Ruby 2.0 (install with [rbenv](https://github.com/sstephenson/rbenv))
- Rubygems
- Bundler (`gem install bundler`)
- PostgreSQL (http://postgresapp.com/)

**Setup:**
- run `bundle install`
- setup config/database.yml
- run `rake db:migrate`

**Running things:**
- To start the server run `rails server` or `rails s`, this will launch the app on port 3000
- To run the specs run `rake spec` or `rspec`, to run a single file you can `rspec /path/to/your/file`
- To have Guard automatically listen for file changes and run the appropriate specs run `guard` from the app root
- To generate the model annotations run `bundle exec annotate`

**Housekeeping**
- Write specs!
- Development happens on the `development` branch only, if something is finished open a pull-request to master. Master should always be ready for deployment.
- For a big feature create a new branch and open a pull request for reviewing
- Please adhere to the [Github ruby styleguide](https://github.com/styleguide/ruby)
- - Staging branch is for pushing to Heroku

- All code and commit messages should be in English
- Commit messages are written in the imperative with a short, descriptive title. Good => `Return a 204 when updating a learning objec`, bad => `Changed http response` or `I updated the http response on the update action in the LearningObjectsController because we're not showing any data there`. The first line should always be 50 characters or less and that it should be followed by a blank line.
