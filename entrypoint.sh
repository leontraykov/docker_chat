#!/bin/bash
set -e

check_and_create_db() {
  DB_EXIST=$(PGPASSWORD=$POSTGRES_PASSWORD psql -h $DB_HOST -U $POSTGRES_USER -lqt | cut -d \| -f 1 | grep -w $DB_NAME | wc -l)
  echo "Checking if DB exists..."
  if [ "$DB_EXIST" -eq 0 ]; then
    echo "Database does not exist. Creating..."
    bundle exec rake db:create
    bundle exec rake db:migrate
    bundle exec rake db:seed
    echo "Database created."
  else
    echo "Database already exists."
  fi
}

if [ "$1" == "tests" ]; then
  echo "Waiting for PostgreSQL to become available..."
  until pg_isready -h db -p 5432 -U user; do
    sleep 2
  done
  echo "PostgreSQL is available now."

  bundle exec bun install
  bundle exec bun run build
  bundle exec bun run build:css

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
  
  check_and_create_db

  bundle exec bun install
  bundle exec bun run build
  bundle exec bun run build:css
fi

exec "$@"
