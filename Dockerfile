FROM ruby:3.2.2
# Установка необходимых пакетов
RUN apt-get update -qq && apt-get install -y nodejs npm postgresql-client

# Создание рабочей директории
WORKDIR /docker_chat

# Установка Bun
RUN curl -fsSL https://bun.sh/install | bash
# Добавьте путь к Bun в PATH
ENV PATH="/root/.bun/bin:${PATH}"

# Копирование файлов Gemfile, Gemfile.lock и package.json
COPY Gemfile /docker_chat/Gemfile
COPY Gemfile.lock /docker_chat/Gemfile.lock
COPY package.json /docker_chat/package.json

RUN bundle install
# Установка зависимостей
RUN bun install

# Копирование остальных файлов проекта
COPY . /docker_chat

# Выполнение скриптов сборки
RUN bun run build
RUN bun build:css:compile
RUN bun build:css:prefix

# Копирование и установка прав для entrypoint.sh
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh

EXPOSE 5000

# Просмотр содержимого /usr/bin для отладки
RUN ls -l /usr/bin/

# Установка entrypoint и команды запуска
ENTRYPOINT ["entrypoint.sh"]
CMD ["rails", "server", "-b", "0.0.0.0"]
