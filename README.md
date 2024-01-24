[RU]
# ЧатЧат

Это приложение - чат, где пользователи могут создавать комнаты и обмениваться сообщениями в реальном времени. Проект разработан с использованием Ruby on Rails 7, Bun, Docker, PostgreSQL, Hotwire Turbo & Stimulus, Rspec, Devise и Bootstrap 5, а также протестирован с помощью Cucumber и RSpec.

Включает в себя автоматическое создание начальных данных: предустановлены пользователи (например, user_1@ex.co с паролем user_1_password) и чат-комнаты (например, "Общая Чат-Комната"). Это позволяет быстро начать использование приложения.

## Функциональность

- Создание и вход в комнаты для общения.
- Обмен сообщениями в реальном времени.
- Автоматическое обновление списка пользователей, чат-комнат и сообщений при появлении новых.
- Очистка поля ввода после отправки сообщения.
- Полная поддержка тестирования с использованием Cucumber и RSpec.

## Установка и Запуск с Docker

Клонируйте репозиторий:

    git clone https://github.com/leontraykov/docker_chat.git <папка>
    cd <папка>

Запустите тесты:

    docker compose run tests

Запустите приложение с помощью Docker:

    docker compose build
    docker compose up

Откройте приложение в браузере по адресу http://localhost:5000


[EN]
# ChatChat

This application is a chat platform where users can create rooms and exchange messages in real time. The project is developed using Ruby on Rails 7, Docker, PostgreSQL, Hotwire Turbo & Stimulus, Rspec, Devise, and Bootstrap 5, and it's thoroughly tested with Cucumber and RSpec.

Includes automatic creation of initial data: pre-set users (for example, user_1@ex.co with the password user_1_password) and chat rooms (for example, "Common Chat Room"). This allows you to quickly start using the application.

## Features

- Creating and joining chat rooms for communication.
- Real-time message exchange.
- Automatic updates of user lists, chat rooms, and messages when new ones appear.
- Clearing the input field after sending a message.
- Comprehensive testing support with Cucumber and RSpec.

## Installation and Launch with Docker

Clone the repository:

    git clone https://github.com/leontraykov/docker_chat.git <folder>
    cd <folder>

Run the tests:

    docker compose run tests

Launch the application using Docker:

    docker compose build
    docker compose up

Open the application in a browser at http://localhost:5000.
