FROM node:22.13 AS node_22

FROM ruby:3.3.6

COPY --from=node_22 /usr/lib /usr/lib
COPY --from=node_22 /usr/local/lib /usr/local/lib
COPY --from=node_22 /usr/local/include /usr/local/include
COPY --from=node_22 /usr/local/bin /usr/local/bin

WORKDIR /app

COPY entrypoint.sh /app/entrypoint.sh

# RUBY CONFIG

RUN sh -c 'echo "gem: --no-rdoc --no-ri" > ~/.gemrc'

COPY Gemfile /app/Gemfile
COPY Gemfile.lock /app/Gemfile.lock

RUN gem install bundler && bundle install -j4

EXPOSE 3000
