FROM ruby:3.1.0-alpine

ARG RAILS_ROOT=/docker-done-right
ARG PACKAGES="vim openssl-dev postgresql-dev mongodb-tools build-base \
  curl less tzdata git postgresql-client bash screen gcompat"

RUN apk update \
  && apk upgrade \
  && apk add --update --no-cache $PACKAGES

RUN mkdir $RAILS_ROOT
WORKDIR $RAILS_ROOT

COPY Gemfile Gemfile.lock ./
RUN bundle install --jobs 5

ADD . $RAILS_ROOT
ENV PATH=$RAILS_ROOT/bin:${PATH}

EXPOSE 3000
CMD bundle exec rails s -b '0.0.0.0' -p 3000
