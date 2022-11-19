FROM ruby:3.1.2
ENV LANG C.UTF-8

# TODO: development のときはどうするか
ENV RAILS_ENV production

RUN apt update -qq && apt install -y build-essential libpq-dev nodejs
RUN gem install bundler
RUN apt-get update && apt-get install -y curl apt-transport-https wget && \
    curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
    echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list && \
    apt-get update && apt-get install -y yarn

RUN mkdir /myapp
WORKDIR /myapp

COPY Gemfile /myapp/Gemfile
COPY Gemfile.lock /myapp/Gemfile.lock

RUN gem install bundler

# TODO: 開発環境として Docker を利用する場合はどうするか
RUN bundle config set --local without 'test development'
RUN bundle install

COPY . /myapp

# Add a script to be executed every time the container starts.
COPY entrypoint.sh /usr/bin/
ENTRYPOINT ["entrypoint.sh"]
