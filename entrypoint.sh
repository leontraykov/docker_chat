#!/bin/bash
set -e

# Функция для проверки и создания базы данных
check_and_create_db() {
  DB_HOST=db
  POSTGRES_USER=user
  POSTGRES_PASSWORD=password
  DB_NAME=$1  # Имя базы данных передаётся как аргумент функции
  SERVICE_TYPE=$2  # Тип сервиса передаётся как аргумент функции

  # Проверка существования базы данных
  DB_EXIST=$(PGPASSWORD=$POSTGRES_PASSWORD psql -h $DB_HOST -U $POSTGRES_USER -lqt | cut -d \| -f 1 | grep -w $DB_NAME | wc -l)
  
  echo "Checking if $DB_NAME exists..."
  if [ "$DB_EXIST" -eq 0 ]; then
    echo "Database $DB_NAME does not exist. Creating..."
    RAILS_ENV=$SERVICE_TYPE bundle exec rake db:create db:migrate
    if [ "$SERVICE_TYPE" = "development" ] && [ ! -f /opt/app-initialized/$DB_NAME ]; then
      bundle exec rake db:seed
      touch /opt/app-initialized/$DB_NAME
    fi
    echo "Database $DB_NAME created."
  else
    echo "Database $DB_NAME already exists."
    RAILS_ENV=$SERVICE_TYPE bundle exec rake db:migrate
  fi
}

if [ "$1" == "tests" ]; then
  echo "Waiting for PostgreSQL to become available..."
  until pg_isready -h db -p 5432 -U user; do
    sleep 2
  done

  bundle exec bun install
  bundle exec bun run build
  bundle exec bun run build:css

  check_and_create_db "docker_chat_test" "test"

  echo "PostgreSQL is available now."
  echo "Running Cucumber tests..."
  bundle exec cucumber
  echo "Running RSpec tests..."
  bundle exec rspec -f d
  exit 0
else
  # Проверка и создание базы данных для разработки
  check_and_create_db "docker_chat_development" "development"
  
  if [ ! -f /opt/app-initialized/initialized ]; then
    touch /opt/app-initialized/initialized
  fi
fi

if [ -f tmp/pids/server.pid ]; then
  rm tmp/pids/server.pid
fi

bundle exec bun install
bundle exec bun run build
bundle exec bun run build:css

exec "$@"
