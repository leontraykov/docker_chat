FROM ruby:3.2.2

RUN apt-get update -qq && \
    apt-get install -y nodejs npm postgresql-client && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN apt-get update -qq && apt-get install -y gnupg2 wget --no-install-recommends \
    && wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - \
    && sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list' \
    && apt-get update \
    && apt-get install -y google-chrome-stable

RUN apt-get install -y google-chrome-stable

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
