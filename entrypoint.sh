#!/bin/bash
set -e

if [ "$1" == "tests" ]; then
  echo "Waiting for PostgreSQL to become available..."
  until pg_isready -h db -p 5432 -U user; do
    sleep 2
  done
  echo "PostgreSQL is available now."

  bundle exec rake db:create RAILS_ENV=test
  bundle exec rake db:migrate RAILS_ENV=test

  echo "Running Cucumber tests..."
  bundle exec cucumber

  echo "Running RSpec tests..."
  bundle exec rspec -f d

  exit 0
fi

if [ -f tmp/pids/server.pid ]; then
  rm tmp/pids/server.pid
fi

if [ ! -f /opt/app-initialized/initialized ]; then
  while ! pg_isready -h db -p 5432 -U user; do
    sleep 2
  done

  touch /opt/app-initialized/initialized

  echo "Dropping the database..."
  bundle exec rake db:drop 
  echo "Database dropping completed."

  echo "Creating the database..."
  bundle exec rake db:create
  echo "Database creating completed."

  echo "Migrating the database..."
  bundle exec rake db:migrate
  echo "Database migrating completed."

  echo "Seeding the database..."
  bundle exec rake db:seed
  echo "Database seeding completed."
fi

exec "$@"
