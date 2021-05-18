FROM ruby:3.0.1

WORKDIR /app

COPY Gemfile Gemfile.lock ./

RUN bundle install

COPY . ./