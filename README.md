[RU]
# ЧатЧат

Это приложение — чат, где пользователи могут создавать комнаты и обмениваться сообщениями в реальном времени. Проект разработан с использованием Ruby on Rails 7, Docker, PostgreSQL, Hotwire Turbo & Stimulus, Rspec, Devise, и Bootstrap 5.

В тестах, выполненных с помощью Cucumber и RSpec, используется драйвер Cuprite для имитации действий пользователя в браузере. Это позволяет проверить, что сообщения в чате появляются в реальном времени без необходимости перезагрузки страницы, демонстрируя работу асинхронных JavaScript операций.

Включает в себя автоматическое создание начальных данных: предустановлены пользователи (например, user_1@ex.co с паролем user_1_password) и чат-комнаты (например, "Общая Чат-Комната"). Это позволяет быстро начать использование приложения.

## Функциональность

- Возможность создания и входа в чат-комнаты для обмена сообщениями.
- Обмен сообщениями в реальном времени без необходимости перезагрузки страницы.
- Автоматическое обновление списка пользователей, чат-комнат и сообщений при их появлении.
- Очистка поля ввода после отправки сообщения.
- Полное тестовое покрытие, включая тестирование асинхронного взаимодействия, с использованием Cucumber, RSpec и Capybara с драйвером Cuprite.

## Установка и Запуск с Docker

Клонируйте репозиторий:

    git clone https://github.com/leontraykov/docker_chat.git <папка>
    cd <папка>

Запустите приложение с помощью Docker:

    docker compose build
    docker compose up

Запустите тесты:

    docker compose run tests

Откройте приложение в браузере по адресу http://localhost:5000


[EN]
# ChatChat

This application is a chat platform where users can create rooms and exchange messages in real-time. The project is developed using Ruby on Rails 7, Docker, PostgreSQL, Hotwire Turbo & Stimulus, Rspec, Devise, and Bootstrap 5.

In the tests, performed with Cucumber and RSpec, the Cuprite driver is used to simulate user actions in the browser. This allows us to verify that messages in the chat appear in real-time without the need for page reloading, demonstrating the operation of asynchronous JavaScript operations.

The application includes automatic creation of initial data: preset users (for example, user_1@ex.co with password user_1_password) and chat rooms (for example, "General Chat Room"). This allows you to quickly start using the application.

## Features

- Ability to create and enter chat rooms for message exchange.
- Real-time message exchange without the need for page reloading.
- Automatic updates of the user list, chat rooms, and messages when they appear.
- Clearing the input field after sending a message.
- Comprehensive test coverage, including testing of asynchronous interactions, using Cucumber, RSpec, and Capybara with the Cuprite driver.

## Installation and Launch with Docker

Clone the repository:

    git clone https://github.com/leontraykov/docker_chat.git <folder>
    cd <folder>

Launch the application using Docker:

    docker compose build
    docker compose up

Run the tests:

    docker compose run tests

Open the application in a browser at http://localhost:5000.
