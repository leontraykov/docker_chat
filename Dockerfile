# Use Ruby 3.2.2 base image
FROM ruby:3.2.2

# Update and install dependencies
RUN apt-get update -qq && \
    apt-get install -y nodejs npm postgresql-client && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Set the working directory inside the container
WORKDIR /docker_chat

# Install Bun and update PATH
RUN curl -fsSL https://bun.sh/install | bash
ENV PATH="/root/.bun/bin:${PATH}"

# Copy Gemfile and package.json to the container
COPY Gemfile /docker_chat/Gemfile
COPY Gemfile.lock /docker_chat/Gemfile.lock
COPY package.json /docker_chat/package.json

# Install Ruby and Node.js dependencies
RUN bundle install
RUN bun install

# Copy the application code to the container
COPY . /docker_chat

# Set entrypoint and permissions
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh

# Expose the port the app runs on
EXPOSE 5000

# Set the default command to run the Rails server
ENTRYPOINT ["entrypoint.sh"]
CMD ["rails", "server", "-b", "0.0.0.0"]
