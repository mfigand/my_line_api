# MY LINE API

Containerized Api base project with:

- Authentication base on JWT.
- Role policies managed by Pundit.
- Contracts ensurement with JSONSchema.
- Automated tests with RSpec.
- Code smell and style checking with reek and rubocop.

## Install steps

From root:

Build the image
* ./run.sh build

Create the database (./run.sh db help)
* ./run.sh db create

Boot the app (./run.sh dev help)
* ./run.sh dev server

Run specs (./run.sh test help)
* ./run.sh test

Run lints (rubocop -a && reek)
* ./run.sh lint

Run rubocop
* ./run.sh lint rubocop

Run reek
* ./run.sh lint reek

Things you may want to cover:

* Ruby version ruby-2.6.5

* System dependencies
  - docker
  - docker-compose


## Debug with pry

* Steps:

- Add 'binding.pry' in the breakpoint you want to set
- Run app
- Get container id with '$ docker ps' or '$ ctop'
- Attach to the container with it's id '$ docker attach container_id'