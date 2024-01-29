FROM ruby:3.2.2

RUN apt-get update -qq && \
    apt-get install -y nodejs npm postgresql-client && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /docker_chat

RUN curl -fsSL https://bun.sh/install | bash
ENV PATH="/root/.bun/bin:${PATH}"

COPY Gemfile /docker_chat/Gemfile
COPY Gemfile.lock /docker_chat/Gemfile.lock
COPY package.json /docker_chat/package.json

RUN bundle install
RUN bun install

COPY . /docker_chat

COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh

EXPOSE 5000

ENTRYPOINT ["entrypoint.sh"]
CMD ["rails", "server", "-b", "0.0.0.0"]
